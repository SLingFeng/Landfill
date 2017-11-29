//
//  SLFFileManager.h
//  jmxc
//
//  Created by 孙凌锋 on 2017/11/27.
//  Copyright © 2017年 孙凌锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLFFileManager : NSObject

//根据路径剪切文件
+(BOOL)cutFile:(NSString *)path topath:(NSString *)topath;

@end
