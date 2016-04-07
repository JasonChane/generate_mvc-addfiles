//
//  OriginDataModel.m
//  Lion
//
//  Created by Rich on 16/3/21.
//  Copyright © 2016年 JoySim. All rights reserved.
//

#import "OriginDataModel.h"

@implementation OriginDataModel

+ (id)shareInstance
{
    static id shareInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareInstance = [[self alloc]init];
        
    });
    return shareInstance;
}

+ (id)createOriginModelWithOutputPath:(NSString*)outputPath
{
    OriginDataModel *model = [OriginDataModel shareInstance];
    model.outputPath = outputPath;
    NSString *urlString = [NSString stringWithFormat:@"file://%@.xcodeproj/project.pbxproj",outputPath];
    model.xcodeproUrl = [NSURL URLWithString:urlString];
    model.moduleName = moduleName_define;
    model.rootFile = [outputPath lastPathComponent];
    
    return model;
}

- (void)initOriginData
{
//    NSString * content = [NSString stringWithContentsOfFile:inputFullPath encoding:NSUTF8StringEncoding error:NULL];
//    if ( nil == content || 0 == content.length )
//    {
//        self.errorLine = 0;
//        self.errorDesc = [NSString stringWithFormat:@"Failed to open '%@'", inputFullPath];
//        return NO;
//    }
//    Cus_Generate_Model* model = [Cus_ParseStr parseString:content error:NULL];
}


@end
