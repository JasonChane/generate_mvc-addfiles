//
//  Cus_ParseStr.m
//  Lion
//
//  Created by Rich on 16/2/3.
//  Copyright © 2016年 JoySim. All rights reserved.
//

#import "Cus_ParseStr.h"
#import "JSONKit.h"
#import "Lion.h"
#import "Lion_CLI.h"

@implementation Cus_ParseStr

+ (Cus_Generate_Model *)parseStringWithError:(NSError**)perror
{
    NSString *	inputFullPath = nil;
    Cus_Generate_Model* cusModel = [Cus_Generate_Model shareInstance];
    
    if ( Lion.cli.arguments.count < 3 )
    {
        return nil;
    }
    
    NSString * inputPath = [Lion.cli fileArgumentAtIndex:2];//json路径
    NSString * outputPath = [Lion.cli pathArgumentAtIndex:3];//输出路径
    
    if ( nil == inputPath )
    {
        return nil;
    }
    
    if ( nil == outputPath )
    {
        outputPath = inputPath;
    }
    
    cusModel.inputPath = [inputPath stringByDeletingLastPathComponent];
    cusModel.inputFile = [inputPath lastPathComponent];
    cusModel.outPutPath = [outputPath stringByDeletingLastPathComponent];
    
    inputFullPath = [NSString stringWithFormat:@"%@/%@", cusModel.inputPath, cusModel.inputFile];//读取json文件
    inputFullPath = [inputFullPath stringByReplacingOccurrencesOfString:@"//" withString:@"/"];
    
    NSString * content = [NSString stringWithContentsOfFile:inputFullPath encoding:NSUTF8StringEncoding error:NULL];

    
    NSError * error = NULL;
    //数据源
    NSObject * obj = [content objectFromJSONStringWithParseOptions:JKParseOptionValidFlags error:&error];
    if ( nil == obj || NO == [obj isKindOfClass:[NSDictionary class]] )
    {
        if ( error )
        {
            *perror = error;
        }
        return NO;
    }
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *)obj];
    cusModel.moduleName = [dict objectForKey:@"moduleName"];
    cusModel.outPutPath = [dict objectForKey:@"outPutPath"];
    cusModel.vcName = [dict objectForKey:@"vcName"];
    cusModel.generateType = [[dict objectForKey:@"Type"] intValue];
    cusModel.cell_h_Properties = [dict objectForKey:@"cell_h"];
    cusModel.cell_m_Properties = [dict objectForKey:@"cell_m"];
    cusModel.vc_h_Properties = [dict objectForKey:@"vc_h"];
    cusModel.vc_m_Properties = [self createVC_m_properties:[dict objectForKey:@"vc_m"] andDict:[self createRequestDict]];
    cusModel.cellItems = [self createCellItems];
    cusModel.requestParamter = [self createRequestDict];

    
    return cusModel;

    
}

+ (Cus_Generate_Model*)parseString:(NSString *)str error:(NSError **)perror
{
    Cus_Generate_Model* cusModel = [Cus_Generate_Model shareInstance];
    NSError * error = NULL;
    //数据源
    NSObject * obj = [str objectFromJSONStringWithParseOptions:JKParseOptionValidFlags error:&error];
    if ( nil == obj || NO == [obj isKindOfClass:[NSDictionary class]] )
    {
        if ( perror )
        {
            *perror = error;
        }
        return NO;
    }
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *)obj];
    cusModel.moduleName = [dict objectForKey:@"moduleName"];
    cusModel.outPutPath = [dict objectForKey:@"outPutPath"];
    cusModel.vcName = [dict objectForKey:@"vcName"];
    cusModel.generateType = [[dict objectForKey:@"Type"] intValue];
    cusModel.cell_h_Properties = [dict objectForKey:@"cell_h"];
    cusModel.cell_m_Properties = [dict objectForKey:@"cell_m"];
    cusModel.vc_h_Properties = [dict objectForKey:@"vc_h"];
    cusModel.vc_m_Properties = [self createVC_m_properties:[dict objectForKey:@"vc_m"] andDict:[self createRequestDict]];
    cusModel.cellItems = [self createCellItems];
    cusModel.requestParamter = [self createRequestDict];
    
    return cusModel;
    
}

+ (NSDictionary*)createRequestDict
{
    NSDictionary* requestDict = [NSDictionary dictionary];
    requestDict = @{
                    @"pageSize":@"NSInteger",
                    @"currentPageIndex":@"NSInteger",
                    @"status":@"NSInteger",
                    
                    };
    
    return requestDict;
}


+ (NSArray*)createCellItems
{
    NSMutableArray *allItems = [NSMutableArray array];
    for (int row = 0; row < cellItemRow; row ++) {//row
        NSMutableArray *rowItems = [NSMutableArray array];
        for (int column = 0; column < cellItemColumn; column ++) {//column
            NSString *itemType = @"UILabel";
            NSString *itemName = [NSString stringWithFormat:@"item_%d_%d",row,column];
            NSDictionary *itemDict = @{itemName : itemType};
            [rowItems addObject:itemDict];
        }
        [allItems addObject:rowItems];
    }
    return allItems;
}

+ (NSDictionary*)createVC_m_properties:(NSDictionary*)dict1 andDict:(NSDictionary*)dict2
{
    NSMutableDictionary *mutableDic1 = [NSMutableDictionary dictionaryWithDictionary:dict1];
    [mutableDic1 addEntriesFromDictionary:dict2];
    return mutableDic1;
    
}

@end
