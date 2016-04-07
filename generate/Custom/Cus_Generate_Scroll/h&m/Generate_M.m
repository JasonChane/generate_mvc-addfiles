//
//  Generate_M.m
//  AutoCoding_For_Mac
//
//  Created by Rich on 16/1/27.
//  Copyright © 2016年 Rich. All rights reserved.
//

#import "Generate_M.h"
#import "NSString+LionExtension.h"
#import "Generate_VC.h"
#import "Generate_View.h"

@interface Generate_M()
@property (nonatomic,strong) NSString *proName;


@end


@implementation Generate_M

+ (id)sharedInstance
{
    static dispatch_once_t once;
    static Generate_M *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (NSString*)create_M_WithName:(NSString*)name andType:(NSInteger)type
{
    NSMutableString *code = [NSMutableString string];
    [self outputHeader:code];
    
    switch (type) {
        case 0:
            return [self createVC_M_WithName:name andCode:code];
            
            break;
        case 1:
            return [self createView_M_WithName:name andCode:code];
            
            break;
        case 2:
//            return [self createTheme_M_WithName:name andCode:code];
            
            break;
            
        default:
            break;
    }
    return nil;
    
}

#pragma mark create_M

+ (NSString*)createVC_M_WithName:(NSString*)name andCode:(NSString*)code
{
    //头文件
    code.LINE( @"\n#import \"FC%@VC.h\"" ,name);
    code.LINE( @"#import \"%@View.h\"" ,name);
    code.LINE( @"#import \"UserService.h\"" ,name);
    //属性
    code.LINE( @"\n@interface FC%@VC() <%@ViewDelegate>",name,name );
    code.LINE( @"\n@property (nonatomic, strong) %@View *mainScroller;",name );
    code.LINE( @"@property (nonatomic, assign) NSInteger vcType;" );
    code.LINE( @"\n\n@end\n" );
    //方法
    [Generate_VC createMethods:code proName:name];
    code.LINE( @"\n\n@end\n" );
    return code;
    
}

+ (NSString*)createView_M_WithName:(NSString*)name andCode:(NSString*)code
{
    //头文件
    code.LINE( @"\n#import \"%@View.h\"" ,name);
    code.LINE( @"#import \"NewControls.h\"" ,name);
    code.LINE( @"#import \"MGBoxCustom.h\"" ,name);
    code.LINE( @"#import \"MGBoxLine.h\"" ,name);
    code.LINE( @"#import \"%@ThemeVO.h\"" ,name);
    code.LINE( @"#import \"NewControls.h\"" ,name);
    code.LINE( @"#import \"ThemeManager.h\"" ,name);
    //属性
    code.LINE( @"\n\n@interface %@View() ",name );
    code.LINE( @"\n@property (nonatomic, strong) UILabel *headerLabel;" );
    code.LINE( @"@property (nonatomic, strong) UITextField *SMSCodeTextField;" );
    code.LINE( @"@property (nonatomic, strong) %@ThemeVO *themeVO;",name );
    code.LINE( @"\n\n@end\n" );
    //方法
    [Generate_View createMethods:code proName:name];
    
    code.LINE( @"\n\n@end\n" );
    return code;
}

//+ (NSString*)createTheme_M_WithName:(NSString*)name andCode:(NSString*)code
//{
//    //头文件
//    code.LINE( @"\n#import \"%@ThemeVO.h\"" ,name);
//    code.LINE( @"\n@implementation %@ThemeVO" ,name);
//    code.LINE( @"\n\n@end\n" );
//    //方法
//    
//    
//    return code;
//    
//}

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
