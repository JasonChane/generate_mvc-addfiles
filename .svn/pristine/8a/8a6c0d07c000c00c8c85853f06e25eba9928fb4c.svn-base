//
//  Generate_VC.m
//  AutoCoding_For_Mac
//
//  Created by Rich on 16/1/27.
//  Copyright © 2016年 Rich. All rights reserved.
//

#import "Generate_VC.h"
#import "NSString+LionExtension.h"

@interface Generate_VC()
@property (nonatomic, strong) NSString* proName;


@end


@implementation Generate_VC

+ (id)sharedInstance
{
    static dispatch_once_t once;
    static Generate_VC *sharedInstance;
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
    
    //viewDidLoad
    [self createMethod_SystemLoad:code];
    
    //assembleData
    [self createMethod_AssembleData:code];
    
    //createMainView
    [self createMethod_MainView:code];
    
    //request
    [self createMethod_Request:code];
    
    //mainViewDelegate
    [self createMethod_MainViewDelegate:code];
    
    //click event
    [self createMethod_ClickEvent:code];
    
}

#pragma mark controller

+ (void)createMethod_Init:(NSString*)code
{
    //init
    code.LINE( @"\n@implementation FC%@VC" ,[[self sharedInstance] getProName]);
    code.LINE( @"\n#pragma mark public" );
    code.LINE( nil );
    code.LINE( @"- (id)initWithVCType:(NSInteger)vcType" );
    code.LINE( @"{" );
    code.LINE( @"    self = [super init];" );
    code.LINE( @"    if (self)" );
    code.LINE( @"    {" );
    code.LINE( @"        _vcType = vcType;" );
    code.LINE( nil );
    code.LINE( @"    }");
    code.LINE( @"    return self;");
    code.LINE( @"}");
    code.LINE( nil );
    
}

+ (void)createMethod_SystemLoad:(NSString*)code
{
    //写viewdidload
    code.LINE( nil );
    code.LINE( @"- (void)viewDidLoad" );
    code.LINE( @"{" );
    code.LINE( @"    [super viewDidLoad];" );
    code.LINE( @"    // Do any additional setup after loading the view." );
    code.LINE( @"    self.title = @\"%@\";", [[self sharedInstance] getProName] );
    code.LINE( @"    [self requestDataFromServer];" );
    code.LINE( @"    [self assembleData];" );
    code.LINE( @"    [self createMainScrollView];" );
    code.LINE( nil );
    code.LINE( @"}");
    code.LINE( nil );
    
    code.LINE( @"- (void)viewWillAppear:(BOOL)animated" );
    code.LINE( @"{" );
    code.LINE( @"     [super viewWillAppear:animated];" );
    code.LINE( nil );
    code.LINE( @"}");
    code.LINE( nil );
    
    code.LINE( @"- (void)viewWillDisappear:(BOOL)animated" );
    code.LINE( @"{" );
    code.LINE( @"     [super viewWillDisappear:animated];" );
    code.LINE( nil );
    code.LINE( @"}");
    code.LINE( nil );
    
    code.LINE( @"- (void)didReceiveMemoryWarning " );
    code.LINE( @"{" );
    code.LINE( @"     [super didReceiveMemoryWarning];" );
    code.LINE( nil );
    code.LINE( @"}");
    code.LINE( nil );
    
}

+ (void)createMethod_AssembleData:(NSString*)code
{
    //data
    code.LINE( @"- (void)assembleData" );
    code.LINE( @"{" );
    code.LINE( @"    // Assemble the data." );
    code.LINE( @"" );
    code.LINE( nil );
    code.LINE( @"}");
    code.LINE( nil );
    
}

+ (void)createMethod_MainView:(NSString*)code
{
    //mainView
    code.LINE( @"- (void)createMainScrollView" );
    code.LINE( @"{" );
    code.LINE( @"    float originY = 64;" );
    code.LINE( @"    if (IOS7_OR_LATER) " );
    code.LINE( @"    {" );
    code.LINE( @"        originY = 64;" );
    code.LINE( @"    }" );
    code.LINE( @"    else " );
    code.LINE( @"    {" );
    code.LINE( @"        originY = 44;" );
    code.LINE( @"    }" );
    code.LINE( @"    float height = self.view.frame.size.height - originY;" );
    code.LINE( @"    CGRect rect = CGRectMake(0.0f, originY, self.view.frame.size.width, height);" );
    code.LINE( @"    _mainScroller = [[%@View alloc]initWithFrame:rect];",[[self sharedInstance] getProName] );
    code.LINE( @"    _mainScroller.mainViewDelegate = self;" );
    code.LINE( @"    [self.view addSubview:_mainScroller];" );
    code.LINE( @"" );
    code.LINE( nil );
    code.LINE( @"}");
    code.LINE( nil );

}

+ (void)createMethod_Request:(NSString*)code
{
    //request
    code.LINE( @"#pragma mark - request" );
    code.LINE( nil );
    code.LINE( @"- (void)requestDataFromServer" );
    code.LINE( @"{" );
    code.LINE( @"    // 以getUserInfo接口为例" );
    code.LINE( @"    UserService *service = [[UserService alloc] init];" );
    code.LINE( @"    [service getUserInfoWithhSuccess:^(ResponseObject *object) {" );
    code.LINE( @"        if( object.status != 1 )" );
    code.LINE( @"        {" );
    code.LINE( @"            return;" );
    code.LINE( @"        }" );
    code.LINE( @"        if( object.status == 1 )" );
    code.LINE( @"        {//获取需要的数据" );
    code.LINE( @"           " );
    code.LINE( @"        }" );
    code.LINE( nil );
    code.LINE( @"    } failure:^(NSError *error) {" );
    code.LINE( nil );
    code.LINE( @"    }];" );
    code.LINE( nil );
    code.LINE( @"}");
    code.LINE( nil );
    
}

+ (void)createMethod_MainViewDelegate:(NSString*)code
{
    //mainDelegate
    code.LINE( @"#pragma mark - mainViewDelegate" );
    code.LINE( nil );
    code.LINE( @"- (void)mainViewDelegate" );
    code.LINE( @"{" );
    code.LINE( nil );
    code.LINE( @"}");
    code.LINE( nil );
    
}

+ (void)createMethod_ClickEvent:(NSString*)code
{
    //click event
    code.LINE( @"#pragma mark -  click event" );
    code.LINE( nil );
    code.LINE( @"- (void)clickCustomNavigationBarLeftButtonEvent:(id)sender" );
    code.LINE( @"{" );
    code.LINE( @"     [self.navigationController popViewControllerAnimated:YES];" );
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
