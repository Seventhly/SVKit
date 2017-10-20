//
//  SVKeychain.h
//  SevenProject
//
//  Created by kuaiqian on 2017/10/19.
//  Copyright © 2017年 Seven. All rights reserved.
//  钥匙串轻量存储

#import <Foundation/Foundation.h>

@interface SVKeychain : NSObject

/**
 加载指定key的值
 
 @param key 指定的key
 @return 对应的值
 */
+ (id)loadValue:(NSString *)key;

/**
 更新、存储指定key的值，如果value为空，则删除该key

 @param data 对应的value
 @param key 对应的key
 */
+ (void)saveValue:(id)data key:(NSString *)key;
@end
