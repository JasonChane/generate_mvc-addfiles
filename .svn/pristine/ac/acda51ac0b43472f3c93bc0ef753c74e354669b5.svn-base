//
//  Generate_H.m
//  AutoCoding_For_Mac
//
//  Created by Rich on 16/1/27.
//  Copyright © 2016年 Rich. All rights reserved.
//

#import "Generate_H.h"
#import "NSString+LionExtension.h"


@implementation Generate_H

+ (NSMutableString*)create_H_WithName:(NSString*)name andType:(NSInteger)type
{
    NSMutableString *code = [NSMutableString string];
    [self outputHeader:code];
    
    switch (type) {
        case 0:
            return [self createVC_H_WithName:name andCode:code];
            
            break;
        case 1:
            return [self createView_H_With:name andCode:code];
            
            break;
        case 2:
            
            
            break;
            
        default:
            break;
    }
    return nil;
}

+ (NSMutableString*)createVC_H_WithName:(NSString*)name andCode:(NSMutableString *)code
{
    code.LINE( @"#import \"FCBaseCompleteVC.h\"" );
    code.LINE( @"\n@interface FC%@VC : FCBaseCompleteVC",name );
    code.LINE( @"\n- (id)initWithVCType:(NSInteger)vcType;" );
    code.LINE( @"\n\n@end" );
    
    return code;
}

+ (NSMutableString*)createView_H_With:(NSString*)name andCode:(NSMutableString *)code
{
    
    code.LINE( @"#import \"MGScrollView.h\"" );
    code.LINE( @"\n@protocol %@ViewDelegate;",name );
    code.LINE( @"\n@interface %@View : MGScrollView",name );
    code.LINE( @"\n@property (nonatomic, weak) id<%@ViewDelegate> mainViewDelegate;",name );
    code.LINE( @"\n\n@end" );
    code.LINE( @"\n@protocol %@ViewDelegate <NSObject>",name );
    code.LINE( @"\n@required");
    code.LINE( @"\n@optional");
    code.LINE( @"\n- (void)clickEvent:(id)sender;");
    
    code.LINE( @"\n\n@end" );


    return code;
    
}

//+ (NSMutableString*)createTheme_H_With:(NSString*)name andCode:(NSMutableString*)code
//{
//    code.LINE( @"#import \"JSONModel.h\"" );
//    code.LINE( @"#import \"%@BoxHeaderTheme.h\"",name );
//    code.LINE( @"#import \"%@BoxMidTheme.h\"",name );
//    code.LINE( @"#import \"%@BoxFooterTheme.h\"",name );
//    code.LINE( @"#define %@Theme @\"%@ThemeVO\"",name,name );
//
//    
//    code.LINE( @"\n@interface %@ThemeVO : JSONModel",name );
//    code.LINE( @"@property (nonatomic,strong) %@BoxHeaderTheme *headerBox;",name );
//    code.LINE( @"@property (nonatomic,strong) %@BoxMidTheme *midBox;",name );
//    code.LINE( @"@property (nonatomic,strong) %@BoxFooterTheme *footerBox;",name );
//
//    code.LINE( @"\n\n@end" );
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
