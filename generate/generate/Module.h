//
//  Module.h
//  generate
//
//  Created by guang on 15/4/20.
//  Copyright (c) 2015年 ifangchou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Module : NSObject

+ (NSString *)command;

+ (void)usage;
+ (BOOL)execute;

@end
