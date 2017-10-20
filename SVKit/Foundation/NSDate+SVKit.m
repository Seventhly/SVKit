//
//  NSDate+SVKit.m
//  SevenProject
//
//  Created by kuaiqian on 2017/9/29.
//  Copyright © 2017年 Seven. All rights reserved.
//  时间处理类

#import "NSDate+SVKit.h"
#import "SVUtility.h"
@implementation NSDate (SVKit)

#pragma mark 当前时间字符串
+ (NSString * __nullable) sv_nowTimeStringWithFormatter:(NSString *__nonnull)formatter{
    return [[NSDate date] sv_dateStringWithFormatter:@"yyy-MM-dd HH:mm:ss"];
}

#pragma mark 时间转字符串
- (NSString * __nullable) sv_dateString{
    return [self sv_dateStringWithFormatter:@"yyy-MM-dd HH:mm:ss"];
}

- (NSString * __nullable) sv_dateStringWithFormatter:(NSString * __nonnull)formatter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatter;
    return [dateFormatter stringFromDate:self];
}

#pragma mark 秒转字符串
+ (NSString *__nullable) sv_stringFromFromSeconds:(NSTimeInterval)seconds formatter:(NSString * __nonnull)formatter{
    NSDate *date = [self sv_dateFromSeconds:seconds];
    return [date sv_dateStringWithFormatter:formatter];
}

#pragma mark 毫秒转字符串
+ (NSString *__nullable) sv_stringFromFromMilliseconds:(NSTimeInterval)milliseconds formatter:(NSString * __nonnull)formatter{
    NSDate *date = [self sv_dateFromMillisecond:milliseconds];
    return [date sv_dateStringWithFormatter:formatter];
}

#pragma mark 时间转星期
- (NSString *__nullable)sv_weekDay{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMinute | NSCalendarUnitWeekday;
    NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:self];
    NSString *weekDay = nil;
    switch (cmp1.weekday) {
        case 1:
            weekDay = @"周日";
            break;
        case 2:
            weekDay = @"周一";
            break;
        case 3:
            weekDay = @"周二";
            break;
        case 4:
            weekDay = @"周三";
            break;
        case 5:
            weekDay = @"周四";
            break;
        case 6:
            weekDay = @"周五";
            break;
        case 7:
            weekDay = @"周六";
            break;
        default:
            break;
    }
    return weekDay;
}

#pragma mark 其他转成时间
#pragma mark 把字符串转成时间
+ (NSDate * __nullable) sv_dateFromString:(NSString * __nullable) timeString{
    return [self sv_dateFromString:timeString formatter:@"yyy-MM-dd HH:mm:ss"];
}

+ (NSDate * __nullable) sv_dateFromString:(NSString * __nullable) timeString formatter:(NSString * __nonnull)formatter{
    if (!sv_isStr(timeString)) return nil;
    if (!sv_isStr(formatter)) return nil;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatter;
    return [dateFormatter dateFromString:timeString];
}

#pragma mark 把秒转成时间
+ (NSDate * __nullable) sv_dateFromSeconds:(NSTimeInterval)seconds{
    if (seconds <= 1) {
        return nil;
    }
    return [NSDate dateWithTimeIntervalSince1970:seconds];
}

#pragma mark 把秒转成时间
+ (NSDate *__nullable) sv_dateFromMillisecond:(NSTimeInterval)millisecond{
    if (millisecond <= 1) {
        return nil;
    }
    NSTimeInterval timeInterval = millisecond / 1000.0;
    return [NSDate dateWithTimeIntervalSince1970:timeInterval];
}


#pragma makr - 时间比较
- (NSTimeInterval)componentsDate:(NSDate * __nonnull)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmp = [calendar components:NSCalendarUnitSecond fromDate:self toDate:date options:0];
    return labs(cmp.second);
}


@end
