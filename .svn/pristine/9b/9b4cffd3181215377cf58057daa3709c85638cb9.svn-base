//
//  Generate_View.m
//  AutoCoding_For_Mac
//
//  Created by Rich on 16/1/27.
//  Copyright © 2016年 Rich. All rights reserved.
//

#import "Generate_View.h"
#import "NSString+LionExtension.h"


@interface Generate_View()
@property (nonatomic, strong) NSString* proName;


@end

@implementation Generate_View

+ (id)sharedInstance
{
    static dispatch_once_t once;
    static Generate_View *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (void)createMethods:(NSString*)code proName:(NSString*)proName
{
    [[self sharedInstance] setProName:proName];
    
    //init
    [self createMethod_Init:code];
    
    //header
    [self createMethod_HeaderBoxes:code];
    
    //mid
    [self createMethod_MidBoxes:code];
    
    //footer
    [self createMethod_FooterBoxes:code];
    
    //click event
    [self createMethod_ClickEvent:code];
    
    
    
}

#pragma mark view

+ (void)createMethod_Init:(NSString*)code
{
    //init
    code.LINE( @"\n@implementation %@View" ,[[self sharedInstance] getProName]);
    code.LINE( @"\n#pragma mark public" );
    code.LINE( nil );
    code.LINE( @"- (id)initWithFrame:(CGRect)frame" );
    code.LINE( @"{" );
    code.LINE( @"    self = [super initWithFrame:frame];" );
    code.LINE( @"    if (self)" );
    code.LINE( @"    {" );
    code.LINE( @"        _themeVO = [[ThemeManager sharedInstance]themeVOWithTitle:%@Theme];",[[self sharedInstance] getProName]);
    code.LINE(nil);
    code.LINE( @"        [self createHeaderBoxes];" );
    code.LINE( @"        [self createMidBoxes];" );
    code.LINE( @"        [self createFooterBoxes];" );
    code.LINE(nil);
    code.LINE( @"        [self drawBoxesWithSpeed:0];" );
    code.LINE( @"        [self flashScrollIndicators];" );
    code.LINE( nil );
    code.LINE( @"     }");
    code.LINE( @"     return self;");
    code.LINE( @"}");
    code.LINE( nil );
    
}

+ (void)createMethod_HeaderBoxes:(NSString*)code
{
    //写header
    code.LINE( @"#pragma mark  -createBoxes" );
    code.LINE( nil );
    code.LINE( @"- (void)createHeaderBoxes" );
    code.LINE( @"{" );
    code.LINE( @"    MGBox *box1 = [MGBoxCustom boxWithBgColor:_themeVO.headerBox.box1.bgColor];" );
    code.LINE( @"    [self.boxes addObject:box1];" );
    code.LINE( nil );
    code.LINE( @"    CGFloat originX = _themeVO.headerBox.box1.leftItem.leftSpace;" );
    code.LINE( @"    CGFloat width = SCREEN_WIDTH - originX*2;" );
    code.LINE( @"    CGFloat labelHeight = _themeVO.headerBox.box1.leftItem.height;" );
    code.LINE( @"    CGFloat lineHeight = _themeVO.headerBox.box1.line.height;" );
    code.LINE( @"    UIColor *leftItemColor = COLOR(_themeVO.headerBox.box1.leftItem.textColor);" );
    code.LINE( @"    UIColor *leftItemBgColor = COLOR(_themeVO.headerBox.box1.leftItem.bgColor);" );
    code.LINE( @"    UIFont *leftItemFont = FONT(_themeVO.headerBox.box1.leftItem.fontSize);" );
    code.LINE( nil );
    code.LINE( @"    UILabel *leftItem = [NewControls createLabelWithFrame:CGRectMake(0, 0, width, labelHeight) text:@\"HeaderBox\" font:leftItemFont textColor:leftItemColor textAlignment:NSTextAlignmentLeft backgroundColor:leftItemBgColor];" );
    code.LINE( @"    leftItem.numberOfLines = 2;" );
    code.LINE( nil );
    code.LINE( @"    MGBoxLine *line = [MGBoxLine lineWithLeft:leftItem right:nil size:CGSizeMake(SCREEN_WIDTH, lineHeight)];" );
    code.LINE( @"    [box1.topLines addObject:line];" );
    code.LINE( @"\n}");
    code.LINE( nil );
    
}

+ (void)createMethod_MidBoxes:(NSString*)code
{
    //写header
    code.LINE( nil );
    code.LINE( @"- (void)createMidBoxes" );
    code.LINE( @"{" );
    code.LINE( @"    MGBox *box1 = [MGBoxCustom boxWithBgColor:_themeVO.midBox.box1.bgColor];" );
    code.LINE( @"    box1.topMargin = _themeVO.midBox.box1.topSpace;" );
    code.LINE( @"    [self.boxes addObject:box1];" );
    code.LINE( @"    CGFloat leftItemWidth = _themeVO.midBox.box1.leftItem.width;" );
    code.LINE( @"    CGFloat leftItemHeight = _themeVO.midBox.box1.leftItem.height;" );
    code.LINE( @"    UIFont *leftItemFont = FONT(_themeVO.midBox.box1.leftItem.fontSize);" );
    code.LINE( @"    UIColor *leftItemTextColor = COLOR(_themeVO.midBox.box1.leftItem.textColor);" );
    code.LINE( @"    UIColor *leftItemBgColor = COLOR(_themeVO.midBox.box1.leftItem.bgColor);" );
    code.LINE( nil );
    code.LINE( @"    UITextField *leftItem = [NewControls createTextFieldWithFrame:CGRectMake(0, 0, leftItemWidth, leftItemHeight) placeholder:@\"请输入短信验证码\" textColor:leftItemTextColor textFont:leftItemFont textAlignment:NSTextAlignmentLeft backgroundColor:leftItemBgColor returnKeyType:UIReturnKeyDone];" );
    code.LINE( @"    leftItem.keyboardType = UIKeyboardTypeNumberPad;" );
    code.LINE( @"    leftItem.clearButtonMode = UITextFieldViewModeWhileEditing;");
    code.LINE( @"    [leftItem addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];");
    code.LINE( nil );
    
    code.LINE( @"    CGFloat rightItemWidth = _themeVO.midBox.box1.rightItem.width;" );
    code.LINE( @"    CGFloat rightItemHeight = _themeVO.midBox.box1.rightItem.height;");
    code.LINE( @"    UIColor *rightItemTextColor = COLOR(_themeVO.midBox.box1.rightItem.textColor);");
    code.LINE( @"    UIFont *rightItemFont = FONT(_themeVO.midBox.box1.rightItem.fontSize);");
    code.LINE( @"    UIColor *rightItemBgColor = COLOR(_themeVO.midBox.box1.rightItem.bgColor);");
    code.LINE( @"    UIButton *rightItem = [NewControls createButtonWithFrame:CGRectMake(0, 0, rightItemWidth, rightItemHeight) normalTitle:@\"获取验证码\" highlightedTitle:nil selectedTitle:nil normalTitleColor:rightItemTextColor highlightedTitleColor:rightItemTextColor selectedColor:rightItemTextColor titleFont:rightItemFont backgroundColor:rightItemBgColor normalImage:nil highlightedImage:nil selectedImage:nil normalBackgroundImage:nil highlightedBgImage:nil selectedBgImage:nil];");
    code.LINE( @"    rightItem.layer.cornerRadius = 4;");
    code.LINE( nil );
    
    code.LINE( @"    CGFloat lineHeight = _themeVO.midBox.box1.line.height;" );
    code.LINE( @"    MGBoxLine *line = [MGBoxLine lineWithLeft:leftItem right:rightItem size:CGSizeMake(SCREEN_WIDTH , lineHeight)];" );
    code.LINE( @"    [box1.topLines addObject:line];" );
    code.LINE( @"\n}");
    code.LINE( nil );
    
}

+ (void)createMethod_FooterBoxes:(NSString*)code
{
    //mainDelegate
    code.LINE( @"- (void)createFooterBoxes" );
    code.LINE( @"{" );
    code.LINE( @"    MGBox *box1 = [MGBoxCustom boxWithBgColor:_themeVO.footerBox.box1.bgColor];" );
    code.LINE( @"    box1.topMargin = _themeVO.footerBox.box1.topSpace;" );
    code.LINE( @"    [self.boxes addObject:box1];" );
    code.LINE( nil );
    code.LINE( @"    CGFloat leftItemWidth = SCREEN_WIDTH - _themeVO.footerBox.box1.leftItem.leftSpace*2;");
    code.LINE( @"    CGFloat rightItemHeight = _themeVO.footerBox.box1.leftItem.height;");
    code.LINE( @"    UIColor *leftItemTextColor = COLOR(_themeVO.footerBox.box1.leftItem.textColor);");
    code.LINE( @"    UIColor *leftItemBgColor = COLOR(_themeVO.footerBox.box1.leftItem.bgColor);");
    code.LINE( @"    UIFont *leftItemFont = FONT(_themeVO.footerBox.box1.leftItem.fontSize);");
    code.LINE( @"    UIButton *leftItem = [NewControls createButtonWithFrame:CGRectMake(0, 0, leftItemWidth, rightItemHeight) normalTitle:@\"确认提交\" highlightedTitle:nil selectedTitle:nil normalTitleColor:leftItemTextColor highlightedTitleColor:leftItemTextColor selectedColor:leftItemTextColor titleFont:leftItemFont backgroundColor:leftItemBgColor normalImage:nil highlightedImage:nil selectedImage:nil normalBackgroundImage:nil highlightedBgImage:nil selectedBgImage:nil];");
    code.LINE( @"    leftItem.layer.cornerRadius = 4;");
    code.LINE( @"    [leftItem addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];");

    code.LINE( nil );
    code.LINE( @"    CGFloat lineHeight = _themeVO.footerBox.box1.line.height;" );
    code.LINE( @"    MGBoxLine *line = [MGBoxLine lineWithLeft:leftItem right:nil size:CGSizeMake(SCREEN_WIDTH, lineHeight)];" );
    code.LINE( @"    [box1.topLines addObject:line];" );
    code.LINE( @"\n}");
    code.LINE( nil );
    
}

+ (void)createMethod_ClickEvent:(NSString*)code
{
    //click event
    code.LINE( @"#pragma mark -  click event" );
    code.LINE( nil );
    code.LINE( @"- (void)clickEvent:(id)sender" );
    code.LINE( @"{" );
    code.LINE( @"    if ([self.mainViewDelegate respondsToSelector:@selector(clickEvent:)])" );
    code.LINE( @"    {" );
    code.LINE( @"        [self.mainViewDelegate clickEvent:sender];" );
    code.LINE( @"    }" );
    code.LINE( nil );
    code.LINE( @"}");
    code.LINE( nil );

}


- (void)setProName:(NSString *)proName
{
    _proName = proName;
    
}

- (NSString*)getProName
{
    return _proName;
    
}

@end
