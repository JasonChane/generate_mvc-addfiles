//
//  GenerateTable_Theme.m
//  AutoCoding_For_Mac
//
//  Created by Rich on 16/1/28.
//  Copyright © 2016年 Rich. All rights reserved.
//

#import "GenerateTable_Theme.h"
#import "NSString+LionExtension.h"
#import "Cus_Generate_Model.h"


@interface GenerateTable_Theme()
@property (nonatomic, strong) NSString* proName;
@property (nonatomic, strong) NSString* fileName;

@end

@implementation GenerateTable_Theme

+ (id)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (NSString*)create_M_WithName:(NSString*)name andType:(NSInteger)type
{
    NSMutableString *code = [NSMutableString string];
    [self outputHeader:code];
    
    NSString *fileName;
    switch (type) {
        case 0:
            
            fileName = [NSString stringWithFormat:@"%@ThemeVO",name];
            
            break;
        case 1:
            
            fileName = [NSString stringWithFormat:@"%@TableTheme",name];
            
            break;
        case 2:
            
            fileName = [NSString stringWithFormat:@"%@CellTheme",name];
            
            break;

        default:
            break;
    }
    return [self createTheme_M_WithName:fileName andCode:code];
    
}

+ (NSMutableString*)create_H_WithName:(NSString*)name andType:(NSInteger)type
{
    NSMutableString *code = [NSMutableString string];
    [self outputHeader:code];
    
    switch (type) {
        case 0:
            return [self createTheme_H_With:name andCode:code];
            
            break;
        case 1:
            return [self createHeaderTheme_H_With:name andCode:code];
            
            break;
        case 2:
            return [self createMidBoxTheme_H_With:name andCode:code];
            
            break;

        default:
            break;
    }
    return nil;
}

#pragma mark -M

+ (NSString*)createTheme_M_WithName:(NSString*)name andCode:(NSString*)code
{
    
    //头文件
    code.LINE( @"\n#import \"%@.h\"" ,name);
    code.LINE( @"\n@implementation %@" ,name);
    
    
    code.LINE( @"\n\n@end\n" );
    //方法
    
    
    return code;
    
}

#pragma mark -VO_H

+ (NSMutableString*)createTheme_H_With:(NSString*)name andCode:(NSMutableString*)code
{
    code.LINE( @"#import \"JSONModel.h\"" );
    code.LINE( @"#import \"%@TableTheme.h\"",name );
    code.LINE( @"#import \"%@CellTheme.h\"",name );
    code.LINE( nil );
    code.LINE( @"#define %@Theme @\"%@ThemeVO\"",name,name );
    
    
    code.LINE( @"\n@interface %@ThemeVO : JSONModel",name );
    code.LINE( @"@property (nonatomic,strong) %@TableTheme *tableViewTheme;",name );
    code.LINE( @"@property (nonatomic,strong) %@CellTheme *cellTheme;",name );
    code.LINE( nil );
    code.LINE( @"- (NSDictionary *)propertyMap;" );
    code.LINE( @"\n\n@end" );
    
    return code;
    
}

#pragma mark -headerBoxTheme

+ (NSMutableString*)createHeaderTheme_H_With:(NSString*)name andCode:(NSMutableString*)code
{
    code.LINE( @"#import \"JSONModel.h\"" );
    code.LINE( @"#import \"ViewThemeVO.h\"",name );
    
    
    code.LINE( @"\n@interface %@TableTheme : JSONModel",name );
    code.LINE( @"@property(nonatomic,strong) ViewThemeVO *selfThemeVO;" );
    
    code.LINE( @"\n\n@end" );
    
    return code;
    
    
}

#pragma mark -midBoxTheme

+ (NSMutableString*)createMidBoxTheme_H_With:(NSString*)name andCode:(NSMutableString*)code
{
    code.LINE( @"#import \"JSONModel.h\"" );
    code.LINE( @"#import \"ViewThemeVO.h\"",name );
    
    code.LINE( @"\n@interface %@CellTheme : JSONModel",name );
    code.LINE( @"@property (nonatomic,strong) ViewThemeVO *selfTheme;" );
    
    //items
    NSArray *allCellItems = [Cus_Generate_Model getCellItems];
    for (NSArray *rowItems in allCellItems)
    {
        for (NSDictionary *itemDict in rowItems)
        {
            NSArray *allKeys = [itemDict allKeys];
            for (NSString *key in allKeys)
            {
                code.LINE( @"@property(nonatomic,strong) ViewThemeVO *%@;",key );
                
            }
        }
    }
    
//    NSDictionary *propertiesDict = [self getItemsOfCell];
//    NSArray *propertyKeys = [propertiesDict allKeys];
//    for (NSString *key in propertyKeys)//key是属性名
//    {
//        code.LINE( @"@property(nonatomic,strong) ViewThemeVO *%@;",key );
//        
//    }
    
    code.LINE( @"\n\n@end" );
    
    return code;
    
}

+ (NSDictionary*)getItemsOfCell
{
    Cus_Generate_Model* model = [Cus_Generate_Model shareInstance];
    return model.cell_m_Properties;
}

+ (void)outputHeader:(NSMutableString *)code//头部 title author date
{
    NSString *title;
    NSString *author;
    code.LINE( @"// title:  %@", title ? title : @"" );
    code.LINE( @"// author: %@", author ? author : @"unknown" );
    code.LINE( @"// date:   %@", [NSDate date] );
    code.LINE( @"//" );
    code.LINE( nil );
}


@end
