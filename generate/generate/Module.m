//
//  Module.m
//  generate
//
//  Created by guang on 15/4/20.
//  Copyright (c) 2015年 ifangchou. All rights reserved.
//

#import "Module.h"
#import "Module_help.h"
#import "Lion.h"

@implementation Module

+ (NSString *)command
{
    return nil;
}

+ (void)usage
{
    [Module_help execute];
}

+ (BOOL)execute
{
    if ( Lion.cli.arguments.count == 0 )
    {
        [self usage];
        return NO;
    }
    
    BOOL		handled = NO;
    NSString *	command = Lion.cli.arguments[0];
    NSArray *	classes = [LionRuntime allSubClassesOf:[Module class]];
    
    for ( Class classType in classes )
    {
        NSString * moduleCommand = [classType command];
        if ( moduleCommand && [moduleCommand isEqualToString:command] )
        {
            handled = [classType execute];
            if ( handled )
            {
                return YES;
            }
        }
    }
    
    if ( NO == handled )
    {
        [self usage];
    }
    
    return NO;
}


@end
