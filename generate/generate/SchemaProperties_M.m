//
//  SchemaProperties_M.m
//  Lion
//
//  Created by Rich on 15/11/20.
//  Copyright © 2015年 JoySim. All rights reserved.
//

#import "SchemaProperties_M.h"

@implementation SchemaProperties_M

//----------------SchemaModel制造工厂（一个model的最终产品，包括类名，类属性，类属性类型）
+ (id)parseKey:(NSString *)key value:(NSDictionary *)value protocol:(SchemaProtocol *)protocol
{
    
    //	INFO( @"model >>> '%@'", key );
    
    NSString * thisClass = nil;
    NSString * superClass = nil;
    
    if ( NSNotFound != [key rangeOfString:@"<"].location )
    {
        NSArray * array = [key componentsSeparatedByString:@"<"];
        if ( array.count >= 2 )
        {
            thisClass = ((NSString *)[array objectAtIndex:0]).trim;
            superClass = ((NSString *)[array objectAtIndex:1]).trim;
        }
        else
        {
            thisClass = key.trim;
        }
    }
    else
    {
        thisClass = key.trim;
    }
    
    if ( thisClass && thisClass.length )
    {
        SchemaModel * model = [[self alloc] init];
        model.superClassName = superClass;
        
        if ( [thisClass hasPrefix:@"!"] )
        {
            model.isActiveRecord = YES;
            model.className = [thisClass substringFromIndex:1].trim;
        }
        else
        {
            model.isActiveRecord = NO;
            model.className = thisClass;
        }
        
        model.properties = [[NSMutableArray alloc] init];
        
        if ( [value isKindOfClass:[NSDictionary class]] )
        {
            NSMutableArray * sortedKeys = [NSMutableArray arrayWithArray:value.allKeys];
            [sortedKeys sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                return [obj1 compare:obj2];
            }];
            
            for ( NSString * sortedKey in sortedKeys )
            {
                SchemaProperty * property = [SchemaProperty parseKey:sortedKey value:[value objectForKey:sortedKey] protocol:protocol];
                if ( property )
                {
                    [model.properties addObject:property];//类属性集合
                }
            }
            
            model.isDictionary = YES;
            model.isContainer = YES;
        }
        else if ( [value isKindOfClass:[NSArray class]] )
        {
            SchemaProperty * property = [SchemaProperty parseKey:key value:value protocol:protocol];
            if ( property )
            {
                [model.properties addObject:property];
            }
            
            model.isArray = YES;
            model.isContainer = NO;
        }
        else
        {
            SchemaProperty * property = [SchemaProperty parseKey:key value:value protocol:protocol];
            if ( property )
            {
                [model.properties addObject:property];
            }
            
            model.isContainer = NO;
        }
        
        [model.properties sortUsingComparator:^NSComparisonResult(id obj1, id obj2)
         {//排序
             NSInteger result = NSOrderedSame;
             
             if ( ((SchemaProperty *)obj1).required )
             {
                 result = 1;
             }
             else if ( ((SchemaProperty *)obj2).required )
             {
                 result = -1;
             }
             else
             {
                 result = ((SchemaProperty *)obj1).order - ((SchemaProperty *)obj2).order;
             }
             
             return (result > 0 ? NSOrderedDescending : (result < 0 ? NSOrderedAscending : NSOrderedSame));
         }];
        
        model.properties = [[NSMutableArray alloc] init];
        
        if ( [value isKindOfClass:[NSDictionary class]] )
        {
            NSMutableArray * sortedKeys = [NSMutableArray arrayWithArray:value.allKeys];
            [sortedKeys sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                return [obj1 compare:obj2];
            }];
            
            for ( NSString * sortedKey in sortedKeys )
            {
                SchemaProperty * property = [SchemaProperty parseKey:sortedKey value:[value objectForKey:sortedKey] protocol:protocol];
                if ( property )
                {
                    [model.properties addObject:property];//类属性集合
                }
            }
            
            model.isDictionary = YES;
            model.isContainer = YES;
        }
        else if ( [value isKindOfClass:[NSArray class]] )
        {
            SchemaProperty * property = [SchemaProperty parseKey:key value:value protocol:protocol];
            if ( property )
            {
                [model.properties addObject:property];
            }
            
            model.isArray = YES;
            model.isContainer = NO;
        }
        else
        {
            SchemaProperty * property = [SchemaProperty parseKey:key value:value protocol:protocol];
            if ( property )
            {
                [model.properties addObject:property];
            }
            
            model.isContainer = NO;
        }
        
        [model.properties sortUsingComparator:^NSComparisonResult(id obj1, id obj2)
         {//排序
             NSInteger result = NSOrderedSame;
             
             if ( ((SchemaProperty *)obj1).required )
             {
                 result = 1;
             }
             else if ( ((SchemaProperty *)obj2).required )
             {
                 result = -1;
             }
             else
             {
                 result = ((SchemaProperty *)obj1).order - ((SchemaProperty *)obj2).order;
             }
             
             return (result > 0 ? NSOrderedDescending : (result < 0 ? NSOrderedAscending : NSOrderedSame));
         }];
        
        //		[model.properties sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        //			NSInteger result = ((SchemaProperty *)obj1).order - ((SchemaProperty *)obj2).order;
        //			return (result > 0 ? NSOrderedDescending : (result < 0 ? NSOrderedAscending : NSOrderedSame));
        //		}];
        
        model.protocol = protocol;
        return model;
    }
    
    return nil;
}


- (NSString *)mm
{

    NSString *			prefix = self.protocol.prefix;
    NSMutableString *	code = [NSMutableString string];
    
    code.LINE( @"#pragma mark - %@%@", prefix, self.className );
    code.LINE( nil );
    code.LINE( @"@interface %@%@ ()", prefix, self.className );

    if (self.properties && self.properties.count)
    {//待优化
        for (SchemaProperty* property in self.properties)
        {
            code.LINE( @"@property (nonatomic, retain) %@ *\t\t\t%@;", property.elemClass, property.name );

        }
    }
    code.LINE( nil );
    code.LINE( @"@end" );
    code.LINE( nil );
    
    code.LINE( @"@implementation %@%@", prefix, self.className );
    code.LINE( nil );
    
    code.LINE( @"#pragma mark createViews" );
    
    //创建 create
    if (self.properties && self.properties.count)
    {
        for (SchemaProperty* property in self.properties)
        {
            NSString* capitalPrefix = [property.name stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[property.name substringToIndex:1] uppercaseString]];
            
            code.LINE(@"-(void)create%@",capitalPrefix);
            code.LINE( @"{" );
            code.LINE( @"   if (_%@ == nil)",property.name );
            code.LINE( @"   {" );
            code.LINE( @"       CGFloat originX = originX;" );
            code.LINE( @"       CGFloat originY = originY;" );
            code.LINE( @"       CGRect rect = CGRectMake(originX, originY, self.width-originX, xxx);" );
            if ([property.elemClass containsString:@"UILabel"])
            {
                code.LINE( @"       _%@ = [NewControls createLabelWithFrame:rect text:nil font:SIZE_12 textColor:BLACK_COLOR textAlignment:NSTextAlignmentLeft backgroundColor:CLEAR_COLOR];" ,property.name);
                
            }
            else if ([property.elemClass containsString:@"UIButton"])
            {
                NSLog(@"UIButton");
                code.LINE(@"       _%@ = [NewControls createButtonWithFrame:(CGRect)rect normalTitle:(NSString *)normalTitle highlightedTitle:(NSString *)highlightedTitle selectedTitle:(NSString *)selectedTitle normalTitleColor:(UIColor *)normalTitleColor highlightedTitleColor:(UIColor *)highlightedColor selectedColor:(UIColor *)selectedColor titleFont:(UIFont *)titleFont backgroundColor:(UIColor *)bgColor normalImage:(UIImage *)normalImage highlightedImage:(UIImage *)highlightedImage selectedImage:(UIImage *)selectedImage normalBackgroundImage:(UIImage *)normalBgImage highlightedBgImage:(UIImage *)highlightedBgImage selectedBgImage:(UIImage *)selectedBgImage]",property.name );
                
            }
            else if ([property.elemClass containsString:@"UITextFiled"])
            {
                NSLog(@"UITextFiled");
                code.LINE(@"       _%@ = [NewControls createTextFieldWithFrame:(CGRect)rect placeholder:(NSString *)placeholder textColor:(UIColor *)textColor textFont:(UIFont *)textFont textAlignment:(NSTextAlignment)textAlignment backgroundColor:(UIColor *)bgColor returnKeyType:(UIReturnKeyType)returnKeyType]",property.name );
                
            }
            else if ([property.elemClass containsString:@"UIView"])
            {
                NSLog(@"UIView");
                code.LINE(@"       _%@ = [NewControls createViewWithFrame:(CGRect)rect backgroundColor:(UIColor *)bgColor]",property.name );

            }
            else if ([property.elemClass containsString:@"UIImageView"])
            {
                NSLog(@"UIImageView");
                code.LINE(@"       _%@ = [NewControls createImageViewWithFrame:(CGRect)rect image:(UIImage *)image]",property.name );
            }
            else if ([property.elemClass containsString:@"AttributedLabel"])
            {
                NSLog(@"AttributedLabel");
                code.LINE(@"       _%@ = [NewControls createAttributedLabelWithFrame:(CGRect)rect fontSize:(UIFont*)fontSize textArray:(NSArray*)textArray colorArray:(NSArray*)colorArray numberOfLines:(NSInteger)numberOfLines backgroudColor:(UIColor*)backgroudColor];",property.name );
                
            }
            
            code.LINE( @"       [self addSubview:_%@];",property.name );
            code.LINE( @"   }" );
            code.LINE( nil );
            code.LINE( @"}" );
            code.LINE( nil );
        }
    }

    return code;
}



@end
