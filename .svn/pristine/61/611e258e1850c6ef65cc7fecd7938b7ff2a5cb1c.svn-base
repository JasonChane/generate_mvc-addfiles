//
//  Module_schema.m
//  generate
//
//  Created by guang on 15/5/4.
//  Copyright (c) 2015年 ifangchou. All rights reserved.
//

#import "Module_schema.h"
#import "SchemaGenerator.h"
#import "SchemaServer.h"

@implementation Module_schema

+ (NSString *)command
{
    return @"schema";
}

+ (void)usage
{
    Lion.cli.LINE( nil );
    Lion.cli.LINE( @"type 'bee schema build my.json'" );
    Lion.cli.LINE( @"type 'bee schema build my.json ~/Desktop'" );
    Lion.cli.LINE( nil );
    Lion.cli.LINE( @"type 'bee schema test server my.json'" );
    Lion.cli.LINE( @"type 'bee server test my.json 3000'" );
    Lion.cli.LINE( nil );
}

+ (void)schema_build
{
    if ( Lion.cli.arguments.count < 3 )
    {
        [self usage];
        return;
    }
    
    NSString * inputPath = [Lion.cli fileArgumentAtIndex:2];//json路径
    NSString * outputPath = [Lion.cli pathArgumentAtIndex:3];//输出路径
    
    if ( nil == inputPath )
    {
        [self usage];
        return;
    }
    
    if ( nil == outputPath )
    {
        outputPath = inputPath;
    }
    
    SchemaGenerator * generator = [[[SchemaGenerator alloc] init] autorelease];
    generator.inputPath = [inputPath stringByDeletingLastPathComponent];
    generator.inputFile = [inputPath lastPathComponent];
    generator.outputPath = [outputPath stringByDeletingLastPathComponent];

//------------------------------------------------------------上面是路径设置
//------------------------------------------------------------下面是数据组织    
    BOOL succeed = [generator generate];//组织.h和.m
    
    if ( NO == succeed )
    {
        if ( generator.errorLine )
        {
            Lion.cli.RED().LINE( nil );
            Lion.cli.RED().LINE( @"line #%d: %@", generator.errorLine, generator.errorDesc );
            Lion.cli.RED().LINE( nil );
        }
        else
        {
            Lion.cli.RED().LINE( nil );
            Lion.cli.RED().LINE( @"%@", generator.errorDesc );
            Lion.cli.RED().LINE( nil );
        }
    }
    else
    {
        for ( NSString * file in generator.results )
        {
            Lion.cli.ECHO( @"%@", file );
            Lion.cli.GREEN().LINE( @"\tDONE" );
        }
        
        Lion.cli.GREEN().LINE( nil );
        Lion.cli.GREEN().LINE( @"Total %d file(s) generated", generator.results.count );
        Lion.cli.GREEN().LINE( nil );
    }
}

+ (void)schema_test
{
    if ( Lion.cli.arguments.count < 3 )
    {
        [self usage];
        return;
    }
    
    NSString * inputPath = [Lion.cli fileArgumentAtIndex:2];
    if ( nil == inputPath )
    {
        [self usage];
        return;
    }
    
    NSString * port = [Lion.cli.arguments safeObjectAtIndex:3];
    
    SchemaServer * server = [[[SchemaServer alloc] init] autorelease];
    server.inputPath = [inputPath stringByDeletingLastPathComponent];
    server.inputFile = [inputPath lastPathComponent];
    server.port = port ? [port intValue] : 3000;
    
    BOOL succeed = [server start];
    if ( NO == succeed )
    {
        if ( server.errorLine )
        {
            Lion.cli.RED().LINE( nil );
            Lion.cli.RED().LINE( @"line #%d: %@", server.errorLine, server.errorDesc );
            Lion.cli.RED().LINE( nil );
        }
        else
        {
            Lion.cli.RED().LINE( nil );
            Lion.cli.RED().LINE( @"%@", server.errorDesc );
            Lion.cli.RED().LINE( nil );
        }
    }
    else
    {
        Lion.cli.GREEN().LINE( nil );
        Lion.cli.GREEN().LINE( @"Running..." );
        Lion.cli.CYAN().LINE( nil );
        Lion.cli.CYAN().LINE( @"Try to access 'http://localhost:%d'", server.port );
        Lion.cli.CYAN().LINE( nil );
        
        CFRunLoopRun();
    }
}

+ (BOOL)execute
{
   // NSString * command1 = [Lion.cli.arguments objectAtIndex:0];
    NSString * command2 = [Lion.cli.arguments objectAtIndex:1];
    
    if ( [command2 isEqualToString:@"build"] )
    {
        [self schema_build];
        
        return YES;
    }
    else if ( [command2 isEqualToString:@"test"] )
    {
        [self schema_test];
        
        return YES;
    }
    
    return NO;
}


@end
