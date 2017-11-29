//
//  SLFFileManager.m
//  jmxc
//
//  Created by 孙凌锋 on 2017/11/27.
//  Copyright © 2017年 孙凌锋. All rights reserved.
//

#import "SLFFileManager.h"

@implementation SLFFileManager

//根据路径剪切文件
+(BOOL)cutFile:(NSString *)path topath:(NSString *)topath {
    BOOL result = NO;
    NSError * error = nil;
    result = [[NSFileManager defaultManager]moveItemAtPath:path toPath:topath error:&error ];
    if (error){
        NSLog(@"cut失败：%@",[error localizedDescription]);
    }
    return result;
}

@end
