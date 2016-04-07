//
//  ProjectBuild.h
//  FFXcodeProjectManager
//
//  Created by Rich on 16/3/16.
//  Copyright © 2016年 Florian Friedrich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OriginDataModel.h"


@interface ProjectBuild : NSObject

@property (nonatomic,strong) NSString *busiName;
@property (nonatomic,strong) NSString *moduleName;
@property (nonatomic,strong) OriginDataModel *originDataModel;

+ (void)customPbxprojInsertGroupAndClass:(NSURL*)url outputPath:(NSString*)outputPath;


@end
