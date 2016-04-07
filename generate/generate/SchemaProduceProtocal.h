//
//  SchemaProduceProtocal.h
//  Lion
//
//  Created by Rich on 15/11/19.
//  Copyright © 2015年 JoySim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SchemaGenerator.h"

@interface SchemaProduceProtocal : SchemaModel

//@property (nonatomic, retain) NSString *			superClassName;
//@property (nonatomic, retain) NSString *			className;
//@property (nonatomic, retain) NSMutableArray *		properties;
@property (nonatomic, retain) NSString *            requireMethod;
@property (nonatomic, retain) NSString *            optionalMethod;
//@property (nonatomic, retain) NSString *            isActiveRecord;

- (NSString *)h;

@end
