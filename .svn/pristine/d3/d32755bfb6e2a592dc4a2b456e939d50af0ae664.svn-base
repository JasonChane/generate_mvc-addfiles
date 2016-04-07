//
//  SchemaProduceProtocal.m
//  Lion
//
//  Created by Rich on 15/11/19.
//  Copyright © 2015年 JoySim. All rights reserved.
//

#import "SchemaProduceProtocal.h"

@implementation SchemaProduceProtocal

//----------------SchemaProduceProtocal制造工厂
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
        SchemaProduceProtocal* modelProtocal = [[self alloc]init];
        modelProtocal.superClassName = superClass? superClass:@"NSObejct";
        modelProtocal.className = key;
        modelProtocal.requireMethod = @"@require";
        modelProtocal.optionalMethod = @"@otional";
        
        modelProtocal.protocol = protocol;
        
        return modelProtocal;
    }
    
    return nil;
}

- (NSString *)h//produceProtocal
{
    
    NSString *			prefix = self.protocol.prefix;
    prefix = prefix? prefix:@"";
    NSMutableString *	code = [NSMutableString string];
    
    //	code.LINE( @"#pragma mark - %@%@", prefix, self.className );
    //	code.LINE( nil );
    code.LINE( @"#pragma mark - %@%@\n", prefix, self.className );
    
    
    if ( self.superClassName )
        //@interface SHOT : BeeActiveObject
    {
        code.LINE( @"@protocal %@%@ <%@>", prefix, self.className, self.superClassName );
    }
    else
    {
        if ( self.isActiveRecord )
        {
            code.LINE( @"@protocal %@%@ <%@>", prefix, self.className, @"NSObject" );
        }
        else
        {
            code.LINE( @"@protocal %@%@ : %@", prefix, self.className, @"BeeActiveObject" );
        }
    }
    
    for ( SchemaProperty * property in self.properties )
        //设置生成的属性及类型
        //    @interface SHOT : BeeActiveObject
        //    @property (nonatomic, retain) NSNumber *			comments_count;
        //    @property (nonatomic, retain) NSString *			created_at;
        //    @property (nonatomic, retain) NSNumber *			height;
        //    @property (nonatomic, retain) NSNumber *			likes_count;
        //    @property (nonatomic, retain) PLAYER *			player;
        //    @property (nonatomic, retain) NSNumber *			rebound_source_id;
        //    @property (nonatomic, retain) NSNumber *			rebounds_count;
        //    @property (nonatomic, retain) NSString *			title;
        //    @property (nonatomic, retain) NSNumber *			views_count;
        //    @property (nonatomic, retain) NSNumber *			width;
        //    @property (nonatomic, retain) NSNumber *			id;
        //    @end
    {
        if ( property.type == SchemaProperty.TYPE_ENUM )
        {
            SchemaEnum * enums = [self.protocol enumByName:property.elemClass];
            if ( enums && enums.isString )
            {
                code.LINE( @"@property (nonatomic, retain) NSString *\t\t\t%@;", property.name );
            }
            else
            {
                code.LINE( @"@property (nonatomic, retain) NSNumber *\t\t\t%@;", property.name );
            }
        }
        else if ( property.type == SchemaProperty.TYPE_NUMBER )
        {
            code.LINE( @"@property (nonatomic, retain) NSNumber *\t\t\t%@;", property.name );
        }
        else if ( property.type == SchemaProperty.TYPE_STRING )
        {
            code.LINE( @"@property (nonatomic, retain) NSString *\t\t\t%@;", property.name );
        }
        else if ( property.type == SchemaProperty.TYPE_ARRAY )
        {
            code.LINE( @"@property (nonatomic, retain) NSArray *\t\t\t\t%@;", property.name );
        }
        else if ( property.type == SchemaProperty.TYPE_DICTIONARY )
        {
            code.LINE( @"@property (nonatomic, retain) NSDictionary *\t\t\t%@;", property.name );
        }
        else if ( property.type == SchemaProperty.TYPE_OBJECT )
        {
            code.LINE( @"@property (nonatomic, retain) %@%@ *\t\t\t%@;", prefix, property.elemClass, property.name );
        }
        else
        {
            code.LINE( @"@property (nonatomic, retain) NSObject *\t\t\t%@;", property.name );
        }
        
        
    }
    
    code.LINE( nil );
    code.LINE( @"@require" );
    code.LINE( @"@optional" );
    code.LINE( nil );
    
    //	code.LINE( @"- (BOOL)validate;" );
    code.LINE( @"@end" );
    return code;
}


@end
