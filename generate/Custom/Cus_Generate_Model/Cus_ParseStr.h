//
//  Cus_ParseStr.h
//  Lion
//
//  Created by Rich on 16/2/3.
//  Copyright © 2016年 JoySim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cus_Generate_Model.h"

@interface Cus_ParseStr : NSObject

+ (Cus_Generate_Model *)parseStringWithError:(NSError**)perror;

+ (Cus_Generate_Model*)parseString:(NSString *)str error:(NSError **)perror;



@end
