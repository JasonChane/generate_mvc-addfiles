//
//  GenerateTable_View.m
//  AutoCoding_For_Mac
//
//  Created by Rich on 16/1/28.
//  Copyright © 2016年 Rich. All rights reserved.
//

#import "GenerateTable_View.h"
#import "NSString+LionExtension.h"
#import "Cus_Generate_Model.h"

@interface GenerateTable_View()
@property (nonatomic, strong) NSString* proName;


@end


@implementation GenerateTable_View

+ (id)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
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
    [self createMethod_TopView:code];
    
    //footer
    [self createMethod_FooterView:code];
    
    //table
    [self createMethod_TableView:code];
    
    //handleViewChange
    [self createMethod_HandleViewChange:code];
    
    //refreshDelegate
    [self createMethod_RefreshDelegate:code];
    
    //reload
    [self createMethod_ReloadData:code];
    
    //tableDelegate
    [self createMethod_TableDelegate:code];
    
    //click event
    [self createMethod_ClickEvent:code];
    
    code.LINE( @"\n\n@end\n");
}

#pragma mark view

+ (void)createMethod_Init:(NSString*)code
{
    //initWithFrame
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
    code.LINE( @"        self.backgroundColor = BG_COLOR;" );
    code.LINE( @"        self.conditionArray = @[@\"所有项目\",@\"预约中\",@\"投资中\",@\"已筹满\",@\"已结束\"];" );
    code.LINE(nil);
    code.LINE( @"        [self createTableView];" );
    code.LINE( nil );
    code.LINE( @"     }");
    code.LINE( @"     return self;");
    code.LINE( @"}");
    code.LINE( nil );
    
    
    //init
    code.LINE( @"\n#pragma mark public" );
    code.LINE( nil );
    code.LINE( @"- (id)initWithFrame:(CGRect)frame andThemeVO:(InvestmentThemeVO*)themeVO" );
    code.LINE( @"{" );
    code.LINE( @"    self = [super initWithFrame:frame];" );
    code.LINE( @"    if (self)" );
    code.LINE( @"    {" );
//    code.LINE( @"        _themeVO = [[ThemeManager sharedInstance]themeVOWithTitle:%@Theme];",[[self sharedInstance] getProName]);
    code.LINE(nil);
    code.LINE( @"        self.backgroundColor = BG_COLOR;" );
    code.LINE( @"        self.conditionArray = @[@\"所有项目\",@\"预约中\",@\"投资中\",@\"已筹满\",@\"已结束\"];" );
//    code.LINE( @"        self.choosedRow = 0;" );
    code.LINE(nil);
//    code.LINE( @"        [self createTopView];" );
    code.LINE( @"        [self createTableView];" );
    code.LINE( nil );
    code.LINE( @"     }");
    code.LINE( @"     return self;");
    code.LINE( @"}");
    code.LINE( nil );
    
}

+ (void)createMethod_TopView:(NSString*)code
{
    //写topView
    code.LINE( @"#pragma mark  -createTopView" );
    code.LINE( nil );
    code.LINE( @"- (void)createTopView" );
    code.LINE( @"{" );
    code.LINE( @"    if (self.topView == nil) {" );
    code.LINE( @"        CGRect rect = CGRectMake(0.0f, 0.0f, self.width, 44.0f);");
    code.LINE( @"        _topView = [[UIView alloc] initWithFrame:rect];");
    code.LINE( @"        self.topView.backgroundColor = WHITE_COLOR;");
    code.LINE( @"        [self addSubview:self.topView];");
    code.LINE( @"        UIImage *leftImage = [UIImage imageNamed:@\"icon_chooseMark\"];");
//    code.LINE( @"        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(_themeVO.chooseThemeVO.leftImage.left, _themeVO.chooseThemeVO.leftImage.top, _themeVO.chooseThemeVO.leftImage.width, _themeVO.chooseThemeVO.leftImage.height)];");
    code.LINE( @"        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(11,12,22,22)];");
    code.LINE( @"        imageView.image = leftImage;");
    code.LINE( @"        [self.topView addSubview:imageView];");
//    code.LINE( @"        CGFloat labelWidth = _themeVO.chooseThemeVO.label.width;");
    code.LINE( @"        CGFloat labelWidth = 100;");
    code.LINE( @"        CGFloat labelOriginX = imageView.left+imageView.width+10;");
    code.LINE( @"        CGFloat labelOriginY = imageView.top;");
    
    code.LINE( @"        CGFloat labelHeight = 50;");
    code.LINE( @"        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelOriginX, labelOriginY, labelWidth, labelHeight)];");
    code.LINE( @"        label.text = @\"所有项目\";");
    code.LINE( @"        label.font = SIZE_15;");
    code.LINE( @"        label.tag = LABEL_CONDITION_TAG;");
    code.LINE( @"        [self.topView addSubview:label];");
    code.LINE( @"        UIImage *arrowImage = [UIImage imageNamed:@\"arrow\"];");
    code.LINE( @"        CGFloat width = 100;");
    code.LINE( @"        CGFloat originX = self.topView.width - width - 10;");
    code.LINE( @"        CGFloat arrowHeight = 20;");
    code.LINE( @"        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(originX, 30, width, arrowHeight)];");
    code.LINE( @"        arrowImageView.image = arrowImage;");
    code.LINE( @"        [self.topView addSubview:arrowImageView];");
//    code.LINE( @"        [self addSingleTagToView:self.topView];");
    code.LINE( @"    }");
    code.LINE( @"\n}");
    code.LINE( nil );

}

+ (void)createMethod_TableView:(NSString*)code
{
    //写tableView
    code.LINE( @"\n#pragma mark -tableView\n" );
    code.LINE( @"- (void)createTableView" );
    code.LINE( @"{" );
    code.LINE( @"    if (self.tableView == nil)");
    code.LINE( @"    {");
    code.LINE( @"        CGFloat originY = self.topView.top+self.topView.height;");
    code.LINE( @"        _tableView = [[RefreshTableView alloc] initWithFrame:CGRectMake(0.0f, originY, self.bounds.size.width, self.bounds.size.height-originY) style:UITableViewStyleGrouped];");
    code.LINE( @"        self.tableView.backgroundColor = [UIColor clearColor];");
    code.LINE( @"        self.tableView.delegate = self;");
    code.LINE( @"        self.tableView.refreshDelegate = self;");
    code.LINE( @"        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;");
    code.LINE( @"        self.tableView.showsVerticalScrollIndicator = NO;");
    code.LINE( @"        [self addSubview:self.tableView];");
    code.LINE( @"        static NSString *identify = @\"cell\";");
//    code.LINE( @"        TableViewCellConfigureBlock configureCell = ^(ProjectCell *cell, id item) {");
    code.LINE( @"        TableViewCellConfigureBlock configureCell = ^(%@Cell *cell, id item) {",[[self sharedInstance] getProName]);//自定义cell还有很多工作要做
    code.LINE( @"            cell.delegate = self;");
//    code.LINE( @"            cell.themeVO = self.themeVO;");
    code.LINE( @"            //            [cell refreshViews];");
    code.LINE( @"            [cell configure:item];");
    code.LINE( @"        };");
    code.LINE( @"        self.dataSource = [[ArrayDataSource alloc] initWithCellIdentifier:identify andConfigureCellBlock:configureCell];");
    code.LINE( @"        self.dataSource.numberOfSections = 1;");
    code.LINE( @"        self.tableView.dataSource = self.dataSource;");
//    code.LINE( @"        [self.tableView registerClass:[ProjectCell class] forCellReuseIdentifier:identify];");
    code.LINE( @"        [self.tableView registerClass:[%@Cell class] forCellReuseIdentifier:identify];",[[self sharedInstance] getProName] );
    code.LINE( @"        [self.tableView setupRefresh];");
    code.LINE( @"    }");
    
    code.LINE( @"\n}");
    code.LINE( nil );
    


}

+ (void)createMethod_FooterView:(NSString*)code
{
    //footerView
    code.LINE( @"- (void)createFooterView" );
    code.LINE( @"{" );
    code.LINE( @"\n}");
    code.LINE( nil );
    
}

+ (void)createMethod_ReloadData:(NSString*)code
{
    //reloadData
    code.LINE( @"#pragma mark - reloeadData");
    code.LINE( @"- (void)reloadData:(id)data");
    code.LINE( @"{");
    code.LINE( @"    if ([data isKindOfClass:[NSArray class]]) {");
    code.LINE( @"        self.tableView.hidden = NO;");
    code.LINE( @"        self.dataSource.items = (NSArray*)data;");
    code.LINE( @"        [self.tableView reloadTableViewData];");
    code.LINE( @"    }else{");
    code.LINE( @"        self.tableView.hidden = YES;");
    code.LINE( @"    }");
    code.LINE( @"}");
    code.LINE( @"");
    code.LINE( @"- (void)stopRefresh");
    code.LINE( @"{");
    code.LINE( @"    [self.tableView stopRefresh];");
    code.LINE( @"}");
    code.LINE( @"");
    
}

+ (void)createMethod_RefreshDelegate:(NSString*)code
{
    //refreshDelegate
    code.LINE( @"#pragma mark - RefreshTableViewDelegate");
    code.LINE( @"- (void)tableView:(RefreshTableView*)tableView didListViewRefreshOrLoadMoreData:(BOOL)isRefresh");
    code.LINE( @"{");
    code.LINE( @"    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(projectListView:didListViewRefreshOrLoadMoreData:)]) {");
    code.LINE( @"        [self.delegate projectListView:self didListViewRefreshOrLoadMoreData:isRefresh];");
    code.LINE( @"    }");
    code.LINE( @"}");
    code.LINE( @"");
    
}

+ (void)createMethod_TableDelegate:(NSString*)code
{
    //tableDelegate
    code.LINE( @"\n#pragma mark - UITableViewDelegate\n");
    code.LINE( @"- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath");
    code.LINE( @"{");
    code.LINE( @"    return _themeVO.cellTheme.selfTheme.height;");
    code.LINE( @"}");
    code.LINE( @"");
    code.LINE( @"- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath");
    code.LINE( @"{");
    code.LINE( @"    [tableView deselectRowAtIndexPath:indexPath animated:YES];");
    code.LINE( @"    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(projectListView:didListViewRefreshOrLoadMoreData:)]) {");
    code.LINE( @"        [self.delegate projectListView:self didSelectRowAtIndexPath:indexPath];");
    code.LINE( @"    }");
    code.LINE( @"}");
    code.LINE( @"");
    code.LINE( @"-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{");
    code.LINE( @"    return 10.0f;");
    code.LINE( @"}");
    code.LINE( @"");
    

}

+ (void)createMethod_HandleViewChange:(NSString*)code
{
    code.LINE( @"- (void)hideFilterViewWithStatus:(NSInteger)status");
    code.LINE( @"{");
    code.LINE( @"");
    code.LINE( @"}");
    code.LINE( @"");

    
}

+ (void)createMethod_ClickEvent:(NSString*)code
{
    //click event
    code.LINE( @"#pragma mark -  click event" );
    code.LINE( nil );
    code.LINE( @"- (void)clickEvent:(id)sender" );
    code.LINE( @"{" );
    code.LINE( @"    if ([self.delegate respondsToSelector:@selector(clickEvent:)])" );
    code.LINE( @"    {" );
//    code.LINE( @"        [self.delegate clickEvent:sender];" );
    code.LINE( @"    }" );
    code.LINE( nil );
    code.LINE( @"}");
    code.LINE( nil );
    code.LINE( @"- (void)projectCell:(id)cell clickedBtnEvent:(id)sender");
    code.LINE( @"{");
    code.LINE( @"    ProjectCell *projectCell = (ProjectCell*)cell;");
    code.LINE( @"    NSIndexPath *indexPath = [self.tableView indexPathForCell:projectCell];");
    code.LINE( @"    [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];");
    code.LINE( @"}");
    code.LINE( @"");

    
}

#pragma mark -getCustomData

+(NSDictionary*)getProperties_Table_h
{
    Cus_Generate_Model *model = [Cus_Generate_Model shareInstance];
    return model.table_h_Properties;
    
}

+(NSDictionary*)getProperties_Table_m
{
    Cus_Generate_Model *model = [Cus_Generate_Model shareInstance];
    return model.table_m_Properties;
    
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

