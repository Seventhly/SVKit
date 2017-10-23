//
//  NSString+SVAmount.h
//  SevenProject
//
//  Created by kuaiqian on 2017/10/20.
//  Copyright © 2017年 Seven. All rights reserved.
//  字符串金额转换(分/厘转元，元转分)

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SVAmountUnitType) {
    SVAmountUnitTypeFen = 0,   //金额单位为分
    SVAmountUnitTypeLi         //金额单位为厘
};

@interface NSString (SVAmount)

#pragma mark - 金额转换
/**
 金额转换，分转元
 
 @return 元为单位的金额
 */
- (NSString *)sv_getDecimalAmount;

/**
 金额转换，分\厘转元
 
 @param amountUnit 指定输入的金额的单位
 @return 元为单位的金额
 */
- (NSString *)sv_getDecimalAmountWithType:(SVAmountUnitType)amountUnit;

/**
 元转分
 
 @return 分为单位的金额
 */
- (NSString *)sv_getIntegerAmount;


#pragma mark - 金额格式转换

/**
 将金额转化为###,###的格式。 sample： 1234.8转换后变1,234
 
 @return 格式化的金额
 */
- (NSString *)sv_bankAmount;
/**
 将金额转化为###,##0.00的格式。 sample： 1234.8转换后变1,234.80   123456.789转换后变为123,456.79会进位的
 
 @return 格式化的金额
 */
- (NSString *)sv_bankAmountCode;

@end
