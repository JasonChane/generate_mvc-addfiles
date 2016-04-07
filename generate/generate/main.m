//
//  main.m
//  generate
//
//  Created by guang on 15/4/10.
//  Copyright (c) 2015年 ifangchou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Generate.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        @autoreleasepool
        {
            Generate * generate = [[Generate alloc] init];
            if (generate)
            {
                [generate argc:argc argv:argv];
            }
        }
        return 0;
    }
    return 0;
}
