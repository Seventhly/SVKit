//
//  NSString+SVVerification.h
//  SevenProject
//
//  Created by kuaiqian on 2017/10/20.
//  Copyright © 2017年 Seven. All rights reserved.
//  字符串校验类(校验中文、英文、数字、邮箱、手机号)

#import <Foundation/Foundation.h>

@interface NSString (SVVerification)

#pragma mark - 中文字符
/** 是否包含中文字符 */
- (BOOL) sv_haveChinese;
/** 字符串中中文字符的个数 */
- (NSUInteger) sv_chineseCount;

#pragma mark - 大写字母
/** 是否含有大写字母 */
- (BOOL) sv_haveUppercase;
/** 字符串中大写英文的个数 */
- (NSInteger) sv_uppercaseCount;

#pragma mark - 小写字母
/** 是否含有小写字母 */
- (BOOL) sv_haveLowercase;
/** 字符串中小写英文的个数 */
- (NSInteger) sv_lowercaseCount;

#pragma mark - 数字
/** 是否含有数字 */
- (BOOL) sv_haveNumber;
/** 字符串中小写英文的个数 */
- (NSInteger) sv_numberCount;

#pragma mark - 邮箱手机号
/** 检验是否为邮箱 */
- (BOOL)sv_validateEmail;
/** 验证是否为手机号 */
- (BOOL)sv_validateMobilePhoneCode;


@end
