//
//  GenerateTable_H.m
//  AutoCoding_For_Mac
//
//  Created by Rich on 16/1/28.
//  Copyright © 2016年 Rich. All rights reserved.
//

#import "GenerateTable_H.h"
#import "NSString+LionExtension.h"
#import "Cus_Generate_Model.h"

@interface GenerateTable_H()

@property (nonatomic,strong) NSString* proName;
@property (nonatomic,strong) NSDictionary* propertiesDict;


@end

@implementation GenerateTable_H

+ (id)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (NSMutableString*)createTable_H_WithName:(NSString*)name andType:(NSInteger)type
{
    NSMutableString *code = [NSMutableString string];
    [self outputHeader:code];
    
    switch (type) {
        case 0:
            return [self createTableVC_H_WithName:name andCode:code];
            
            break;
        case 1:
            return [self createTableView_H_With:name andCode:code];
            
            break;
        case 2:
            return [self createTableCell_H_With:name andCode:code];
            
            break;
        case 3:
            //            return [self createTheme_H_With:name andCode:code];
            
            break;
        case 4:
            return [self createTableCell_Categry_H_With:name andCode:code];
            
            break;
        default:
            break;
    }
    return nil;


}

+ (NSMutableString*)createTableVC_H_WithName:(NSString*)name andCode:(NSMutableString *)code
{
    code.LINE( @"#import \"FCBaseCompleteVC.h\"" );
    code.LINE( @"\n@interface FC%@VC : FCBaseCompleteVC",name );
    code.LINE( @"\n@property(nonatomic,assign) NSInteger soruceType;" );
    code.LINE( @"\n- (id)initWithVCType:(NSInteger)vcType;" );
    code.LINE( @"\n\n@end" );
    
    return code;
}

+ (NSMutableString*)createTableView_H_With:(NSString*)name andCode:(NSMutableString *)code
{
    
    code.LINE( @"#import <UIKit/UIKit.h>" );
    code.LINE( @"#import \"InvestmentThemeVO.h\"" );
    code.LINE( @"\n@protocol %@ViewDelegate;",name );
    code.LINE( @"\n@interface %@View : UIView",name );
    code.LINE( @"\n@property (nonatomic, weak) id<%@ViewDelegate> delegate;",name );
    code.LINE( @"\n- (id)initWithFrame:(CGRect)frame andThemeVO:(InvestmentThemeVO*)themeVO;" );
    code.LINE( @"\n- (void)reloadData:(id)data;" );
    code.LINE( @"\n- (void)stopRefresh;" );
    code.LINE( @"\n- (void)hideFilterViewWithStatus:(NSInteger)status;" );
    code.LINE( @"\n\n@end" );
    code.LINE( @"\n@protocol %@ViewDelegate <NSObject>",name );
    code.LINE( @"\n@required");
    code.LINE( @"\n@optional");
    code.LINE( @"\n- (void)projectListView:(id)view didListViewRefreshOrLoadMoreData:(BOOL)isRefreshNotLoadMore;");
    code.LINE( @"\n- (void)projectListView:(id)view didSelectRowAtIndexPath:(NSIndexPath *)indexPath;");
    code.LINE( @"\n- (void)projectListView:(id)view choosedFilterRow:(NSInteger)row;");
    code.LINE( @"\n\n@end" );
    
    return code;
    
}

+ (NSMutableString*)createTableCell_H_With:(NSString*)name andCode:(NSMutableString*)code
{
    code.LINE( @"#import <UIKit/UIKit.h>");
    code.LINE( @"#import \"%@ThemeVO.h\"",name);
    code.LINE( @"\n@protocol %@CellDelegate;",name);
    code.LINE( @"\n@interface %@Cell : UITableViewCell",name);
    code.LINE( @"\n@property(nonatomic,weak) id<%@CellDelegate> delegate;",name);
    
//    NSDictionary *propertiesDict = [[self sharedInstance] getPropertiesDict];
    NSDictionary *propertiesDict = [self getProperties_Cell_h];
    NSArray *propertyKeys = [propertiesDict allKeys];
    for (NSString *key in propertyKeys)//key是属性名
    {
        code.LINE( @"@property(nonatomic,strong) %@ *%@;",[propertiesDict valueForKey:key],key );
        
    }
    code.LINE( nil );
    code.LINE( @"- (void)refreshViews;");
    code.LINE( @"\n\n@end\n");
    code.LINE( @"@protocol %@CellDelegate <NSObject>",name);
    code.LINE( @"\n@optional");
    code.LINE( @"\n- (void)projectCell:(id)cell clickedBtnEvent:(id)sender;");
    code.LINE( @"\n@end");
    code.LINE( @"\n");

    return code;
}

+ (NSMutableString*)createTableCell_Categry_H_With:(NSString*)name andCode:(NSMutableString*)code
{
    code.LINE( @"#import \"%@Cell.h\"",name );
    code.LINE( @"#import \"RenewalProModel.h\"");
    code.LINE( @"");
    code.LINE( @"@interface %@Cell (Config)",name);
    code.LINE( @"");
    code.LINE( @"- (void)configure:(RenewalProModel*)dataObject;");
    code.LINE( @"\n\n@end");
    code.LINE( @"");

    return code;
}


#pragma mark -getCustomData

- (void)setPropertiesDict:(NSDictionary *)propertiesDict
{
    _propertiesDict = propertiesDict;
    
}

- (NSDictionary*)getPropertiesDict
{

    return _propertiesDict;
    
}

+ (NSDictionary*)getProperties_Cell_h
{
    Cus_Generate_Model* model = [Cus_Generate_Model shareInstance];
    return model.cell_h_Properties;
    
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
