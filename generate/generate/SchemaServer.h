//
//  SchemaServer.h
//  generate
//
//  Created by guang on 15/5/4.
//  Copyright (c) 2015年 ifangchou. All rights reserved.
//

#import "Lion.h"

@class SchemaProtocol;

@interface SchemaServer : NSObject

@property (nonatomic, retain) NSString *			inputPath;
@property (nonatomic, retain) NSString *			inputFile;
@property (nonatomic, assign) NSUInteger			port;
@property (nonatomic, retain) SchemaProtocol *		protocol;
@property (nonatomic, assign) NSUInteger			errorLine;
@property (nonatomic, retain) NSString *			errorDesc;

- (BOOL)start;

@end
