//
//  GenerateTable_Cell.m
//  AutoCoding_For_Mac
//
//  Created by Rich on 16/1/29.
//  Copyright © 2016年 Rich. All rights reserved.
//

#import "GenerateTable_Cell.h"
#import "NSString+LionExtension.h"
#import "Cus_Generate_Model.h"

@interface GenerateTable_Cell()

@property (nonatomic,strong) NSString* proName;
@property (nonatomic,strong) NSDictionary* propertiesDict_M;
@property (nonatomic,strong) NSDictionary* propertiesDict_H;

@end


@implementation GenerateTable_Cell

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
    [self assembleData:proName properties:nil];
    
    //属性
    [self createMethod_Properties:code];
    
    //init
    [self createMethod_Init:code];
    
    //createBgView
    [self createMethod_BgView:code];
    
    //createItems
    [self createMethod_Items:code];
    
    //refreshViews
    [self createMethod_RefreshViews:code];
    
    //get set
    [self createMethod_GetSetMethod:code];
    
    code.LINE( @"\n\n@end\n");
}

#pragma mark -properties

+(void)createMethod_Properties:(NSString*)code
{
    code.LINE( @"@interface %@Cell()",[[self sharedInstance] getProName]);
    code.LINE( @"@property(nonatomic,strong) UIView *bgView;" );
    
    NSArray *allCellItems = [Cus_Generate_Model getCellItems];
    for (NSArray *rowItems in allCellItems)
    {
        for (NSDictionary *itemDict in rowItems)
        {
            NSArray *allKeys = [itemDict allKeys];
            for (NSString *key in allKeys)
            {
                code.LINE( @"@property(nonatomic,strong) %@ *%@;",[itemDict valueForKey:key],key );
                
            }
        }
    }
    
//    NSDictionary *propertiesDict = [self getProperties_Cell_m];
//    NSArray *propertyKeys = [propertiesDict allKeys];
//    for (NSString *key in propertyKeys)//key是属性名
//    {
//        code.LINE( @"@property(nonatomic,strong) %@ *%@;",[propertiesDict valueForKey:key],key );
//        
//    }
    code.LINE( @"@property(nonatomic,strong) %@CellTheme *theme;",[[self sharedInstance] getProName]);
    code.LINE( @"\n@end");
    code.LINE( @"");
    
}

#pragma mark view

+ (void)createMethod_Init:(NSString*)code
{
    //init
    code.LINE( @"\n@implementation %@Cell" ,[[self sharedInstance] getProName]);
    code.LINE( @"\n#pragma mark public" );
    code.LINE( nil );
    code.LINE( @"- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier" );
    code.LINE( @"{" );
    code.LINE( @"    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];" );
    code.LINE( @"    if (self)" );
    code.LINE( @"    {" );
    code.LINE( @"        CGRect rect = self.frame;");
    code.LINE(nil);
    code.LINE( @"        rect.size.width = [UIScreen mainScreen].bounds.size.width;" );
    code.LINE( @"        self.frame = rect;" );
    code.LINE(nil);
    code.LINE( @"        self.backgroundColor = BG_COLOR;" );
    code.LINE( @"        %@ThemeVO *themeVO = [[ThemeManager sharedInstance]themeVOWithTitle:%@Theme];",[[self sharedInstance] getProName],[[self sharedInstance] getProName] );
    code.LINE( @"        _theme = themeVO.cellTheme;" );
    code.LINE( @"" );
    code.LINE( @"        [self createBgView];" );
    
    //items
    NSArray *allCellItems = [Cus_Generate_Model getCellItems];
    for (NSArray *rowItems in allCellItems)
    {
        for (NSDictionary *itemDict in rowItems)
        {
            NSArray *allKeys = [itemDict allKeys];
            for (NSString *key in allKeys)
            {
                NSString *upKey = [self upFirstChar:key];
                code.LINE( @"        [self create%@];",upKey );
                
            }
        }
    }
    
//    NSDictionary *propertiesDict = [self getProperties_Cell_m];
//    NSArray *propertyKeys = [propertiesDict allKeys];
//    for (NSString *key in propertyKeys)//key是属性名
//    {
//        NSString *upKey = [self upFirstChar:key];
//        code.LINE( @"        [self create%@];",upKey );
//        
//    }
    
    code.LINE( nil );
    code.LINE( @"     }");
    code.LINE( @"     return self;");
    code.LINE( @"}");
    code.LINE( nil );

}

+ (void)createMethod_BgView:(NSString*)code
{
    code.LINE( @"\n#pragma mark -createItems\n");
    //写bgView
    code.LINE( @"- (void)createBgView");
    code.LINE( @"{");
    code.LINE( @"    if (self.bgView == nil) {");
    code.LINE( @"        CGFloat originX = 0.0f;");
    code.LINE( @"        CGFloat originY = 0.0f;");
    code.LINE( @"        CGFloat width = self.width;");
    code.LINE( @"        CGFloat height = _theme.selfTheme.height;");
    code.LINE( @"        _bgView = [[UIView alloc] initWithFrame:CGRectMake(originX, originY, width, height)];");
    code.LINE( @"        self.bgView.backgroundColor = WHITE_COLOR;");
    code.LINE( @"        self.bgView.layer.cornerRadius = 5;");
    code.LINE( @"        self.bgView.layer.masksToBounds = YES;");
    code.LINE( @"        [self addSubview:self.bgView];");
    code.LINE( @"    }");
    code.LINE( @"}");
    code.LINE( nil );

}

#pragma mark -createItem

+ (void)createMethod_Items:(NSString*)code
{
    //items
    NSArray *allCellItems = [Cus_Generate_Model getCellItems];
    for (int i = 0; i < cellItemRow;i ++ )
    {
        NSArray *rowItems = allCellItems[i];
        for (int j = 0; j < cellItemColumn;j ++ )
        {
            NSDictionary *itemDict = rowItems[j];
            [self createMethod_SingleItem:code itemDict:itemDict itemRow:i itemColumn:j];
            
        }
    }
    
//    NSDictionary *propertiesDict = [self getProperties_Cell_m];
//    NSArray *propertyKeys = [propertiesDict allKeys];
//    for (NSString *key in propertyKeys)//key是属性名
//    {
//        [self createMethod_SingleItem:code propertyName:key propertyType:[propertiesDict objectForKey:key]];
//        
//    }
    
}

+(void)createMethod_SingleItem:(NSString*)code itemDict:(NSDictionary*)itemDict itemRow:(NSInteger)row itemColumn:(NSInteger)column
{
    NSString *key = [itemDict allKeys][0];
    NSString *upKey = [self upFirstChar:key];
    NSString *type = [itemDict valueForKey:key];
    
    {
        code.LINE( @"- (void)create%@",upKey );
        code.LINE( @"{" );
        code.LINE( @"    if (self.%@ == nil) ",key );
        code.LINE( @"    {");
        if (row == 0)//决定Y
        {//第一行
            code.LINE( @"        const CGFloat originY = _theme.%@.top;",key );
            
        }
        else if (row > 0)
        {//第二行以上
            code.LINE( @"        const CGFloat originY = CGRectGetMaxY(_item_%d_0.frame) + _theme.%@.topSpace;",row-1,key );
            
        }
        
        if (column == 0)//决定X
        {//第一列
            code.LINE( @"        const CGFloat originX = _theme.%@.left;",key );
            
        }
        else if(column > 0)
        {//第二行以上
            code.LINE( @"        const CGFloat originX = CGRectGetMaxX(_item_0_%d.frame) + _theme.%@.topSpace;",column-1,key );
            
        }
        code.LINE( @"        const CGFloat width = _theme.%@.width;",key );
        code.LINE( @"        const CGFloat height = _theme.%@.height;",key );
        
        code.LINE( @"        _%@ = [[%@ alloc] initWithFrame:CGRectMake(originX, originY, width, height)];",key,type );
        code.LINE( @"        _%@.backgroundColor = COLOR(_theme.%@.bgColor);",key,key );
        code.LINE( @"        _%@.layer.cornerRadius = 5;",key );
        code.LINE( @"        _%@.layer.masksToBounds = YES;",key );
        if ([type isEqualToString:@"UILabel"] ||[type isEqualToString:@"UITextField"]||[type isEqualToString:@"UITextView"] )
        {
            code.LINE( @"        _%@.font = FONT( _theme.%@.fontSize);",key,key );
            code.LINE( @"        _%@.textColor = COLOR(_theme.%@.textColor);",key,key );
            code.LINE( @"        _%@.textAlignment = _theme.%@.textAlign;",key,key );
            code.LINE( @"        _%@.text = @\"%@\";",key,key );
        }
        code.LINE( @"        [self.bgView addSubview:self.%@];",key );
        code.LINE( @"    }");
        code.LINE( @"}");
        code.LINE( @"");
        
    }
}

#pragma mark -refresh

+ (void)createMethod_RefreshViews:(NSString*)code
{
    
    code.LINE( @"\n#pragma mark - refreshViews\n" );
    code.LINE( @"- (void)refreshViews" );
    code.LINE( @"{" );
    //items
    NSArray *allCellItems = [Cus_Generate_Model getCellItems];
    for (NSArray *rowItems in allCellItems)
    {
        for (NSDictionary *itemDict in rowItems)
        {
            NSArray *allKeys = [itemDict allKeys];
            for (NSString *key in allKeys)
            {
                NSString *upKey = [self upFirstChar:key];
                code.LINE( @"    [self refresh%@];",upKey );
            }
        }
    }
    
//    NSDictionary *propertiesDict = [self getProperties_Cell_m];
//    NSArray *propertyKeys = [propertiesDict allKeys];
//    for (NSString *key in propertyKeys)
//    {
//        NSString *upKey = [self upFirstChar:key];
//        code.LINE( @"    [self refresh%@];",upKey );
//    }
    
    code.LINE( @"" );
    code.LINE( @"}" );
    code.LINE( @"" );
    
    //items
    for (NSArray *rowItems in allCellItems)
    {
        for (NSDictionary *itemDict in rowItems)
        {
            NSArray *allKeys = [itemDict allKeys];
            for (NSString *key in allKeys)
            {
                [self createMethod_RefreshSingleItem:code propertyName:key propertyType:[itemDict objectForKey:key]];
            }
        }
    }
    
//    for (NSString *key in propertyKeys)//key是属性名
//    {
//        [self createMethod_RefreshSingleItem:code propertyName:key propertyType:[propertiesDict objectForKey:key]];
//    }
    
}

+(void)createMethod_RefreshSingleItem:(NSString*)code propertyName:(NSString*)key propertyType:(NSString*)type
{
    NSString *upKey = [self upFirstChar:key];
    
    code.LINE( @"- (void)refresh%@",upKey );
    code.LINE( @"{" );
    code.LINE( @"    const CGFloat originX = _theme.%@.left;",key );
    code.LINE( @"    const CGFloat originY = _theme.%@.top;",key );
    code.LINE( @"    const CGFloat width = _theme.%@.width;",key );
    code.LINE( @"    const CGFloat height = _theme.%@.height;",key );
    
    code.LINE( @"    _%@ = [[%@ alloc] initWithFrame:CGRectMake(originX, originY, width, height)];",key,type );
    code.LINE( @"    _%@.backgroundColor = COLOR(_theme.%@.bgColor);",key,key );
    code.LINE( @"    _%@.layer.cornerRadius = 5;",key );
    code.LINE( @"    _%@.layer.masksToBounds = YES;",key );
    if ([type isEqualToString:@"UILabel"] ||[type isEqualToString:@"UITextField"]||[type isEqualToString:@"UITextView"] )
    {
        code.LINE( @"    _%@.font = FONT( _theme.%@.fontSize);",key,key );
        code.LINE( @"    _%@.textColor = COLOR(_theme.%@.textColor);",key,key );
        code.LINE( @"    _%@.textAlignment = _theme.%@.textAlign;",key,key );
        code.LINE( @"    _%@.text = @\"%@\";",key,key );
    }
    code.LINE( @"}");
    code.LINE( @"");
    
}

#pragma mark -get set

+(void)createMethod_GetSetMethod:(NSString*)code
{
    NSDictionary *propertiesDict = [self getProperties_Cell_h];
    
    NSArray *propertyKeys = [propertiesDict allKeys];

    for (NSString *key in propertyKeys)//key是属性名
    {
        [self createMethod_GetSetSingleMethod:code propertyName:key propertyType:[propertiesDict objectForKey:key]];
        
    }
    
}

+ (void)createMethod_GetSetSingleMethod:(NSString*)code propertyName:(NSString*)key propertyType:(NSString*)type
{
    //get set
    NSString *upKey = [self upFirstChar:key];
    
    code.LINE( @"- (%@*)get%@", type,upKey );
    code.LINE( @"{" );
    code.LINE( @"    return _%@;",key );
    code.LINE( @"" );
    code.LINE( @"}");
    code.LINE( @"");
    code.LINE( @"- (void)set%@:(%@ *)%@",upKey,type,key );
    code.LINE( @"{" );
    code.LINE( @"    _%@ = %@;",key,key );
    code.LINE( @"" );
    code.LINE( @"}");
    code.LINE( @"");

}

#pragma mark -assembleData

+ (NSString*)upFirstChar:(NSString*)title
{
    return [title stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[title substringToIndex:1] uppercaseString]];
    
}

+ (void)assembleData:(NSString*)proName properties:(NSDictionary*)dict
{
    [[self sharedInstance] setProName:proName];

}

#pragma mark -getCustomData

+ (NSDictionary*)getProperties_Cell_h
{
    Cus_Generate_Model* model = [Cus_Generate_Model shareInstance];
    return model.cell_h_Properties;
}

+ (NSDictionary*)getProperties_Cell_m
{
    Cus_Generate_Model* model = [Cus_Generate_Model shareInstance];
    return model.cell_m_Properties;
}


+ (NSString*)getProName
{
    Cus_Generate_Model* model = [Cus_Generate_Model shareInstance];
    return model.vcName;
    
}

- (void)setPropertiesDict_M:(NSDictionary *)propertiesDict
{
    _propertiesDict_M = propertiesDict;
    
}

- (NSDictionary*)getPropertiesDict_M
{
    Cus_Generate_Model *model = [Cus_Generate_Model shareInstance];
    return model.cell_m_Properties;
//    return _propertiesDict_M;
    
}

- (void)setPropertiesDict_H:(NSDictionary *)propertiesDict
{
    _propertiesDict_H = propertiesDict;
    
}

- (NSDictionary*)getPropertiesDict_H
{
    Cus_Generate_Model *model = [Cus_Generate_Model shareInstance];
    return model.cell_h_Properties;
//    return _propertiesDict_H;
    
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
