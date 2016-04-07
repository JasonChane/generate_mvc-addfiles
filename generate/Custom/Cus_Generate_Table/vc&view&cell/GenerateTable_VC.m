//
//  GenerateTable_VC.m
//  AutoCoding_For_Mac
//
//  Created by Rich on 16/1/28.
//  Copyright © 2016年 Rich. All rights reserved.
//

#import "GenerateTable_VC.h"
#import "NSString+LionExtension.h"
#import "Cus_Generate_Model.h"

@interface GenerateTable_VC()

@property (nonatomic,strong) NSString *proName;

@end


@implementation GenerateTable_VC

+ (id)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance = nil;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (void)createMethods_M:(NSString*)code proName:(NSString*)proName
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
    
    code.LINE( @"\n\n@end\n" );
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
    
    Cus_Generate_Model *model = [Cus_Generate_Model shareInstance];
    if (model.requestParamter)
    {
        NSMutableString *paramterStr = [self createMutableParamterMethodStr:model.requestParamter isInvoke:YES];
        code.LINE( @"    [self startGet%@%@];",[[self sharedInstance] getProName], paramterStr);
        
    }
    else
    {
        code.LINE( @"    [self startGet%@];",[[self sharedInstance] getProName]);
        
    }
    
    code.LINE( @"    [self assembleData];" );
    code.LINE( @"    [self createListView];" );
    code.LINE( @"    self.status = 0;" );
    code.LINE( @"    self.isNeedRefresh = YES;" );
    
    code.LINE( nil );
    code.LINE( @"}");
    code.LINE( nil );
    //viewWillAppear
    code.LINE( @"- (void)viewWillAppear:(BOOL)animated" );
    code.LINE( @"{" );
    code.LINE( @"     [super viewWillAppear:animated];" );
    code.LINE( @"     if (self.isNeedRefresh)" );
    code.LINE( @"     {" );
    code.LINE( @"        [self assembleData]; //返回时保留之前选中的状态，不重置status的值" );
    code.LINE( @"        [self.listView hideFilterViewWithStatus:self.status];" );
    code.LINE( @"        if (self.status == 0)" );
    code.LINE( @"        {" );
    code.LINE( @"            self.dataListArray = [FCLocalService readProjectList:10];" );
    code.LINE( @"        }" );
//    code.LINE( @"        [self startGetProjectListWithStatus:self.status andPage:self.currentPageIndex andPageSize:self.pageSize];" );
    code.LINE( @"     }" );
    code.LINE( @"     self.isNeedRefresh = YES;" );
    code.LINE( nil );
    code.LINE( @"}");
    code.LINE( nil );
    //willDisappear
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
    code.LINE( @"    _dataListArray = [RenewalProListModel createTestData];" );
    code.LINE( @"    [_listView reloadData:_dataListArray];" );
    code.LINE( nil );


    code.LINE( @"}");
    code.LINE( nil );
    
}

+ (void)createMethod_MainView:(NSString*)code
{
    //listView
    code.LINE( @"- (void)createListView" );
    code.LINE( @"{" );
    code.LINE( @"    if (self.listView == nil)" );
    code.LINE( @"    {" );
    code.LINE( @"        CGFloat different;" );
    code.LINE( @"        if (self.soruceType == 1 || self.soruceType == 2)" );
    code.LINE( @"        {" );
    code.LINE( @"            different = 0.0f;" );
    code.LINE( @"        }" );
    code.LINE( @"        else" );
    code.LINE( @"        {" );
    code.LINE( @"            different = 49.0f;" );
    code.LINE( @"        }" );
    code.LINE( @"        float originY = self.navigationBar.frame.origin.y + self.navigationBar.frame.size.height;" );
    code.LINE( @"        float height = self.view.frame.size.height - originY - different;" );
    code.LINE( @"        CGRect rect = CGRectMake(0.0f, originY, self.view.frame.size.width, height);");
//    code.LINE( @"        InvestmentThemeVO *themeVO = [ThemeManager sharedInstance].investmentTheme;");
    code.LINE( @"        _listView = [[%@View alloc] initWithFrame:rect];",[[self sharedInstance] getProName]);
    code.LINE( @"        self.listView.delegate = self;");
    code.LINE( @"        [self.view addSubview:self.listView];");
    code.LINE( @"    }" );
    code.LINE( nil );
    code.LINE( @"}");
    code.LINE( nil );


}

#pragma mark - KVO

+ (void)createMethod_KVO:(NSString*)code
{
    //kvo
    code.LINE( @"\n#pragma mark - KVO\n");
    code.LINE( @"- (NSArray *)observableKeypaths");
    code.LINE( @"{");
    code.LINE( @"    return @[DATA_LIST];");
    code.LINE( @"}");
    code.LINE( @"");
    code.LINE( @"- (void)updateDataForKeypath:(NSString *)keyPath");
    code.LINE( @"{");
    code.LINE( @"    if([keyPath isEqualToString:DATA_LIST])");
    code.LINE( @"    {");
    code.LINE( @"        [self.listView reloadData:self.dataListArray];");
    code.LINE( @"    }");
    code.LINE( @"}");
    code.LINE( @"");

}


+ (void)createMethod_Request:(NSString*)code
{

    //request
    code.LINE( @"#pragma mark - request" );
    code.LINE( nil );
    
    Cus_Generate_Model *model = [Cus_Generate_Model shareInstance];
    if (model.requestParamter)
    {
        NSMutableString *paramterStr = [self createMutableParamterMethodStr:model.requestParamter isInvoke:NO];
        code.LINE( @"- (void)startGet%@%@",[[self sharedInstance] getProName], paramterStr);
    }
    else
    {
        code.LINE( @"- (void)startGet%@",[[self sharedInstance] getProName] );
    }
    
    code.LINE( @"{" );
    code.LINE( @"    // 以getUserInfo接口为例" );
    code.LINE( @"    UserService *service = [[UserService alloc] init];" );
    

    if (model.requestParamter)
    {
        NSMutableString *paramterStr = [self createMutableParamterMethodStr:model.requestParamter isInvoke:NO];
        code.LINE( @"    [service get%@%@ withSuccess:^(ResponseObject *object) {",[[self sharedInstance] getProName], paramterStr);
        
    }
    else
    {
        code.LINE( @"    [service get%@WithSuccess:^(ResponseObject *object) {",[[self sharedInstance] getProName]);
        
    }

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
    //listDelegate
    /* 1 */
    code.LINE( @"\n#pragma mark - listViewDelegate\n" );
    code.LINE( @"- (void)projectListView:(id)view didListViewRefreshOrLoadMoreData:(BOOL)isRefreshNotLoadMore;" );
    code.LINE( @"{");
    code.LINE( @"    if (isRefreshNotLoadMore) {");
    code.LINE( @"        self.currentPageIndex = 1;");
    code.LINE( @"    }else{");
    code.LINE( @"        if (self.dataListArray.count || self.pageSize == 0) {");
    code.LINE( @"            self.currentPageIndex++;");
    code.LINE( @"        }else{");
    code.LINE( @"            [self.listView stopRefresh];" );
    code.LINE( @"            return;" );
    code.LINE( @"        }" );
    code.LINE( @"    }" );
    Cus_Generate_Model *model = [Cus_Generate_Model shareInstance];
    if (model.requestParamter)
    {
        NSMutableString *paramterStr = [self createMutableParamterMethodStr:model.requestParamter isInvoke:YES];
        code.LINE( @"    [self startGet%@%@];",[[self sharedInstance] getProName], paramterStr);
        
    }
    else
    {
        code.LINE( @"    [self startGet%@];",[[self sharedInstance] getProName]);
        
    }
    code.LINE( nil );
    code.LINE( @"}");
    code.LINE( nil );
    /* 2 */
    code.LINE( @"- (void)projectListView:(id)view didSelectRowAtIndexPath:(NSIndexPath *)indexPath");
    code.LINE( @"{");
    code.LINE( @"    self.isNeedRefresh = NO;");
    code.LINE( @"    //ProjectListItemDataObject *projectData = self.dataListArray[indexPath.row];");
//    code.LINE( @"    FCProjectDetailVC *nextVC = [[FCProjectDetailVC alloc] init];");
//    code.LINE( @"    nextVC.projectId = projectData.project_id;");
//    code.LINE( @"    nextVC.hidesBottomBarWhenPushed = YES;");
//    code.LINE( @"    [self.navigationController pushViewController:nextVC animated:YES];");
    code.LINE( nil);
    code.LINE( @"}");
    code.LINE( nil);

    /* 2 */
    code.LINE( @"- (void)projectListView:(id)view choosedFilterRow:(NSInteger)row");
    code.LINE( @"{");
    code.LINE( @"    self.dataListArray = nil;");
    code.LINE( @"    self.status = row;  //行号刚好对应状态");
    code.LINE( @"    self.currentPageIndex = 1;");
//    code.LINE( @"    [self startGetProjectListWithStatus:self.status andPage:self.currentPageIndex andPageSize:self.pageSize];");
    code.LINE( nil);
    code.LINE( @"}");
    code.LINE( nil);

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

#pragma mark  - mutalbeParamter

+ (NSMutableString*)createMutableParamterMethodStr:(NSDictionary*)paramterDict isInvoke:(BOOL)isInvoke
{
    NSMutableString *paramterStr = [NSMutableString string];
    NSArray *allKeys = [paramterDict allKeys];
    NSString *with = @"With";
    for (int i = 0;i < allKeys.count;i ++)
    {
        NSString *key = allKeys[i];
        if (i != 0)
        {
            with = @"with";
        }
        
        NSString *subStr;
        if (isInvoke)
        {
            subStr = [NSString stringWithFormat:@"%@%@:_%@ ",with,[key upFirstChar],key];
        }
        else
        {
            subStr = [NSString stringWithFormat:@"%@%@:(%@)%@ ",with,[key upFirstChar],[paramterDict valueForKey:key],key];
        }
        
        [paramterStr appendString:subStr];
    }
    [paramterStr deleteCharactersInRange:NSMakeRange(paramterStr.length - 1, 1)];
    return paramterStr;
}

#pragma mark -getCustomData

+ (NSDictionary*)getProperties_Cell
{
//    Cus_Generate_Model* model = [Cus_Generate_Model shareInstance];
//    return model.view_h_Properties;
    return nil;
}

+ (NSString*)getProName
{
    Cus_Generate_Model* model = [Cus_Generate_Model shareInstance];
    return model.vcName;
    
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

