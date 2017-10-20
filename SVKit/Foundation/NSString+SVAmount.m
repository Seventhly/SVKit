//
//  NSString+SVAmount.m
//  SevenProject
//
//  Created by kuaiqian on 2017/10/20.
//  Copyright © 2017年 Seven. All rights reserved.
//

#import "NSString+SVAmount.h"
#import "SVMacros.h"

@implementation NSString (SVAmount)
#pragma mark - 金额转换
// 分转元
- (NSString *)sv_getDecimalAmount{
    return [self sv_getDecimalAmountWithType:SVAmountUnitTypeFen];
}
#pragma mark - 分/厘转元
- (NSString *)sv_getDecimalAmountWithType:(SVAmountUnitType)amountUnit{
    if ([self isEqualToString:@""]) {
        return @"0.00";
    }
    
    NSString *balanceString;
    NSString *amount = self.copy;
    //去掉可能出现的小数点
    NSRange range = [self rangeOfString:@"."];
    if (range.location != NSNotFound) {
        amount = [self substringWithRange:NSMakeRange(0, range.location)];
    }
    if (amount.length <= 0 + amountUnit) {
        balanceString = @"0.00";
    }else if(amount.length == 1 + amountUnit) {
        balanceString = SV_FORMAT(@"0.0%@", [amount substringWithRange:NSMakeRange(0, 1)]);
    }else if(amount.length == 2 + amountUnit) {
        balanceString = SV_FORMAT(@"0.%@", [amount substringWithRange:NSMakeRange(0, 2)]);
    }else{
        balanceString = SV_FORMAT(@"%@.%@", [amount substringWithRange:NSMakeRange(0, amount.length - (2 + amountUnit))],[amount substringWithRange:NSMakeRange(amount.length - (2 + amountUnit), 2)]);
    }
    return balanceString;
}

#pragma mark - 元转分
- (NSString *)sv_getIntegerAmount{
    NSString *balanceString;
    if (([self rangeOfString:@"."].location !=NSNotFound)) {
        NSArray *dismantlingArray = [self componentsSeparatedByString:@"."];
        NSInteger beforeDecimalInteger = [dismantlingArray[0] integerValue];
        NSString *beforeDecimal = @"";
        if (beforeDecimalInteger > 0) {
            beforeDecimal = SV_FORMAT(@"%ld",(long)beforeDecimalInteger);
        }
        NSString *afterDecimal = dismantlingArray[1];
        if (afterDecimal.length == 0) {
            afterDecimal = @"00";
        } else if (afterDecimal.length == 1) {
            afterDecimal = SV_FORMAT(@"%@0", afterDecimal);
        } else {
            afterDecimal = afterDecimal;
        }
        balanceString = SV_FORMAT(@"%@%@", beforeDecimal,afterDecimal);
    } else {
        balanceString = SV_FORMAT(@"%ld00",(long)[self integerValue]);
    }
    return balanceString;
}

#pragma mark - 金额格式转换
// 将金额转化为###,###的格式。 sample： 1234.8转换后变1,234
- (NSString *)sv_bankAmount{
    NSInteger srcAmount = [self integerValue];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,###;"];
    return [numberFormatter stringFromNumber:@(srcAmount)];
}

// 将金额转化为###,##0.00的格式。 sample： 1234.8转换后变1,234.80
- (NSString *)sv_bankAmountCode{
    double srcAmount = [self doubleValue];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    return [numberFormatter stringFromNumber:@(srcAmount)];
}

@end
