//
//  NSDate+SVKit.h
//  SevenProject
//
//  Created by kuaiqian on 2017/9/29.
//  Copyright © 2017年 Seven. All rights reserved.
//  时间<->字符串   相互转换类

#import <Foundation/Foundation.h>

@interface NSDate (SVKit)

#pragma mark 其他转字符串
/** 获取当前时间字符串 */
+ (NSString * __nullable) sv_nowTimeStringWithFormatter:(NSString *__nonnull)formatter;

/** 时间转字符串 字符串默认格式为yyy-MM-dd HH:mm:ss */
- (NSString * __nullable) sv_dateString;
/** 时间转字符串 */
- (NSString * __nullable) sv_dateStringWithFormatter:(NSString * __nonnull)formatter;
/** 秒转字符串 */
+ (NSString *__nullable) sv_stringFromFromSeconds:(NSTimeInterval)seconds formatter:(NSString * __nonnull)formatter;
/** 毫秒转字符串 */
+ (NSString *__nullable) sv_stringFromFromMilliseconds:(NSTimeInterval)milliseconds formatter:(NSString * __nonnull)formatter;
/** 时间转星期 */
- (NSString *__nullable)sv_weekDay;

#pragma mark 字符串转时间
/** 字符串转时间 默认格式为yyy-MM-dd HH:mm:ss */
+ (NSDate * __nullable) sv_dateFromString:(NSString * __nullable) timeString;
/** 字符串转时间 */
+ (NSDate * __nullable) sv_dateFromString:(NSString * __nullable) timeString formatter:(NSString * __nonnull)formatter;
/** 秒转时间 */
+ (NSDate * __nullable) sv_dateFromSeconds:(NSTimeInterval)seconds;
/** 毫秒转时间 */
+ (NSDate *__nullable) sv_dateFromMillisecond:(NSTimeInterval)millisecond;


#pragma makr - 时间比较
/** 比较两个时间 */
- (NSTimeInterval)componentsDate:(NSDate * __nonnull)date;

@end
