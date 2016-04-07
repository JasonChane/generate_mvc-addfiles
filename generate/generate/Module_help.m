//
//  Module_help.m
//  generate
//
//  Created by guang on 15/4/20.
//  Copyright (c) 2015年 ifangchou. All rights reserved.
//

#import "Module_help.h"
#import "Lion.h"

@implementation Module_help

+ (NSString *)command
{
    return @"help";
}

+ (void)usage
{
    Lion.cli.LINE( nil );
    Lion.cli.LINE( @"type 'Lion help'" );
    Lion.cli.LINE( nil );
}

+ (BOOL)execute
{
    Lion.cli.LINE( @"Usage:" );
    Lion.cli.LINE( @"	Lion <command> [arguments ...]" );
    Lion.cli.LINE( nil );
    Lion.cli.LINE( @"Commands:" );
    Lion.cli.LINE( @"	schema build <file>" );
    Lion.cli.LINE( @"	schema build <file> <path>" );
    Lion.cli.LINE( @"	schema test <file>" );
    Lion.cli.LINE( @"	schema test <file> <port>" );
    Lion.cli.LINE( @"	version" );
    Lion.cli.LINE( @"	help" );
    Lion.cli.LINE( nil );
    Lion.cli.LINE( @"Example:" );
    Lion.cli.LINE( @"	Lion schema build my.json ~/Desktop" );
    Lion.cli.LINE( @"	Lion schema test my.json" );
    Lion.cli.LINE( nil );
    
    return YES;
}


@end
