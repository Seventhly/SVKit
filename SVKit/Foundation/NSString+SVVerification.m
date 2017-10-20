//
//  NSString+SVVerification.m
//  SevenProject
//
//  Created by kuaiqian on 2017/10/20.
//  Copyright © 2017年 Seven. All rights reserved.
//  字符串校验类

#import "NSString+SVVerification.h"
#import "SVMacros.h"

typedef NS_ENUM(NSInteger , SVStringType) {
    SVStringChineseType = 0 ,       //!< 中文
    SVStringuUppercaseType ,        //!< 大写字母
    SVStringLowercaseType ,         //!< 小写字母
    SVStringNumberType ,            //!< 数字
};

@implementation NSString (SVVerification)

#pragma mark - 中文
// 是否含有中文
- (BOOL) sv_haveChinese{
    return [self sv_characterWithType:SVStringChineseType];
}
// 中文的个数
- (NSUInteger) sv_chineseCount{
    NSUInteger len = self.length;
    // 汉字字符集
    NSString * pattern  = @"[\u4e00-\u9fa5]";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    // 计算中文字符的个数
    NSInteger numMatch = [regex numberOfMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, len)];
    return numMatch;
}

#pragma mark - 大写字母
- (BOOL) sv_haveUppercase{
    return [self sv_characterWithType:SVStringuUppercaseType];
}

- (NSInteger) sv_uppercaseCount{
    return [self sv_characterCountWithType:SVStringuUppercaseType];
}

#pragma mark - 小写字母
- (BOOL) sv_haveLowercase{
    return [self sv_characterWithType:SVStringLowercaseType];
}

- (NSInteger) sv_lowercaseCount{
    return [self sv_characterCountWithType:SVStringLowercaseType];
}

#pragma mark - 数字
- (BOOL) sv_haveNumber{
    return [self sv_characterWithType:SVStringNumberType];
}

- (NSInteger) sv_numberCount{
    return [self sv_characterCountWithType:SVStringNumberType];
}


// 计算个数
- (NSInteger) sv_characterCountWithType:(SVStringType)type{
    NSInteger rsCount = 0;
    NSInteger alength = [self length];
    for (int i = 0; i<alength; i++) {
        unichar commitChar = [self characterAtIndex:i];
        if (type == SVStringuUppercaseType) {// 大写字母
            if((commitChar>64)&&(commitChar<91)){// 大写字母
                //                NSLog(@"字符串中含有大写英文字母");
                ++rsCount;
            }
        }else if(type == SVStringLowercaseType){// 小写字母
            if((commitChar>96)&&(commitChar<123)){// 小写字母
                //                NSLog(@"字符串中含有小写英文字母");
                ++rsCount;
            }
        }else if (type == SVStringNumberType){// 数字
            if((commitChar>47)&&(commitChar<58)){// 数字
                //                NSLog(@"字符串中含有数字");
                ++rsCount;
            }
        }
    }
    return rsCount;
}

// 是否含有
- (BOOL) sv_characterWithType:(SVStringType)type{
    NSInteger alength = [self length];
    for (int i = 0; i<alength; i++) {
        unichar commitChar = [self characterAtIndex:i];
        if (type == SVStringChineseType) {// 中文
            if((commitChar >=0x4E00 && commitChar <=0x9FFF)){// 中文
                return YES;
            }
        }
        if (type == SVStringuUppercaseType) {// 大写字母
            if((commitChar>64)&&(commitChar<91)){// 大写字母
                return YES;
            }
        }else if(type == SVStringLowercaseType){// 小写字母
            if((commitChar>96)&&(commitChar<123)){// 小写字母
                return YES;
            }
        }else if (type == SVStringNumberType){// 数字
            if((commitChar>47)&&(commitChar<58)){// 数字
                return YES;
            }
        }
    }
    return NO;
}


#pragma mark -检查邮箱合法性
- (BOOL)sv_validateEmail{
    NSString *emailRegex = @"^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

#pragma mark -检查手机号合法性
- (BOOL)sv_validateMobilePhoneCode{
    NSString *emailRegex = @"^((13[0-9])|(14[0-9])|(15[0-9])|(18[0-9])|(17[0-9]))\\d{8}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

@end
