
//
//  Generate.m
//  generate
//
//  Created by guang on 15/4/10.
//  Copyright (c) 2015年 ifangchou. All rights reserved.
//

#import "Generate.h"
#import "Module.h"
#import "ProjectBuild.h"
#import "OriginDataModel.h"
#import "Cus_WriteMethod_In.h"
#import "Cus_ParseStr.h"

@implementation Generate

- (void)argc:(int)argc argv:(const char * [])argv
{
//    Lion.system.logger.enabled = YES;
    
    [Lion.cli argc:argc argv:argv];
    
    Lion.cli.LINE( nil );
    Lion.cli.GREEN().LINE( @"-------------------------------------------------------" );
    Lion.cli.GREEN().LINE( @"--------------------------Generate---------------------" );
    Lion.cli.GREEN().LINE( @"-------------------------------------------------------" );

    Lion.cli.LINE( nil );
    
    [OriginDataModel createOriginModelWithOutputPath:outputPath_define];//读取工程文件
    
    NSError *error;
    [Cus_ParseStr parseStringWithError:&error];//解析源配置文件
    
    [Module execute];//generate
    
    [ProjectBuild customPbxprojInsertGroupAndClass:xcodeproj_url outputPath:nil];//addfile
    
    [Cus_WriteMethod_In writeMethodIn];//写入新方法
}

@end
