//
//  Generte_Theme.m
//  AutoCoding_For_Mac
//
//  Created by Rich on 16/1/27.
//  Copyright © 2016年 Rich. All rights reserved.
//

#import "Generte_Theme.h"
#import "NSString+LionExtension.h"


@interface Generte_Theme()
@property (nonatomic, strong) NSString* proName;
@property (nonatomic, strong) NSString* fileName;

@end

@implementation Generte_Theme

+ (id)sharedInstance
{
    static dispatch_once_t once;
    static Generte_Theme *sharedInstance;
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
            
            fileName = [NSString stringWithFormat:@"%@BoxHeaderTheme",name];
            
            break;
        case 2:
            
            fileName = [NSString stringWithFormat:@"%@BoxMidTheme",name];
            
            break;
        case 3:
            
            fileName = [NSString stringWithFormat:@"%@BoxFooterTheme",name];
            
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
        case 3:
            return [self createFooterBoxTheme_H_With:name andCode:code];
            
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
    code.LINE( @"#import \"%@BoxHeaderTheme.h\"",name );
    code.LINE( @"#import \"%@BoxMidTheme.h\"",name );
    code.LINE( @"#import \"%@BoxFooterTheme.h\"",name );
    code.LINE( @"#define %@Theme @\"%@ThemeVO\"",name,name );
    
    
    code.LINE( @"\n@interface %@ThemeVO : JSONModel",name );
    code.LINE( @"@property (nonatomic,strong) %@BoxHeaderTheme *headerBox;",name );
    code.LINE( @"@property (nonatomic,strong) %@BoxMidTheme *midBox;",name );
    code.LINE( @"@property (nonatomic,strong) %@BoxFooterTheme *footerBox;",name );
    
    code.LINE( @"\n\n@end" );
    
    return code;
    
}

#pragma mark -headerBoxTheme

+ (NSMutableString*)createHeaderTheme_H_With:(NSString*)name andCode:(NSMutableString*)code
{
    code.LINE( @"#import \"JSONModel.h\"" );
    code.LINE( @"#import \"ViewThemeVO.h\"",name );
    code.LINE( @"#import \"BoxThemeVO.h\"",name );
    
    
    code.LINE( @"\n@interface %@BoxHeaderTheme : JSONModel",name );
    code.LINE( @"@property (nonatomic,strong) ViewThemeVO *space1;" );
    code.LINE( @"@property (nonatomic,strong) BoxThemeVO *box1;" );
    code.LINE( @"@property (nonatomic,strong) ViewThemeVO *space2;" );
    code.LINE( @"@property (nonatomic,strong) BoxThemeVO *box2;" );
    
    code.LINE( @"\n\n@end" );
    
    return code;

}

#pragma mark -midBoxTheme

+ (NSMutableString*)createMidBoxTheme_H_With:(NSString*)name andCode:(NSMutableString*)code
{
    code.LINE( @"#import \"JSONModel.h\"" );
    code.LINE( @"#import \"ViewThemeVO.h\"",name );
    code.LINE( @"#import \"BoxThemeVO.h\"",name );
    
    code.LINE( @"\n@interface %@BoxMidTheme : JSONModel",name );
    code.LINE( @"@property (nonatomic,strong) BoxThemeVO *box1;" );
    
    code.LINE( @"\n\n@end" );
    
    return code;

}

#pragma mark -footerBoxTheme

+ (NSMutableString*)createFooterBoxTheme_H_With:(NSString*)name andCode:(NSMutableString*)code
{
    code.LINE( @"#import \"JSONModel.h\"" );
    code.LINE( @"#import \"ViewThemeVO.h\"",name );
    code.LINE( @"#import \"BoxThemeVO.h\"",name );
    
    code.LINE( @"\n@interface %@BoxFooterTheme : JSONModel",name );
    code.LINE( @"@property (nonatomic,strong) BoxThemeVO *box1;" );

    
    code.LINE( @"\n\n@end" );
    
    return code;
    
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
