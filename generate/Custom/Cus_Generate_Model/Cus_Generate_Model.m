//
//  Cus_Generate_Model.m
//  Lion
//
//  Created by Rich on 16/2/3.
//  Copyright © 2016年 JoySim. All rights reserved.
//

#import "Cus_Generate_Model.h"

@implementation Cus_Generate_Model

+(id)shareInstance
{
    static id instance;
    static dispatch_once_t once;
    dispatch_once(&once,^{
        instance = [[self alloc]init];
        
    });
    return instance;
}

+ (NSArray*)getCellItems
{
    Cus_Generate_Model *model = [self shareInstance];
    return model.cellItems;
}



@end
