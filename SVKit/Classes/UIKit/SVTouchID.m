//
//  SVTouchID.m
//  SevenProject
//
//  Created by kuaiqian on 2017/9/29.
//  Copyright © 2017年 Seven. All rights reserved.
//

#import "SVTouchID.h"
#import "SVUtility.h"
#import <LocalAuthentication/LocalAuthentication.h>

@implementation SVTouchID

/** 判断是否可以TouchID */
+ (BOOL)canTouchID{
    LAContext *context = [[LAContext alloc] init];
    NSError *error;
    return [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
}

+ (BOOL)showTouchIDWithTitle:(NSString *)title replyBlock:(void(^)(SVTouchIDType type , NSError *error))replyBlock{
    return [self showTouchIDWithTitle:title backTitle:@"" replyBlock:replyBlock];
}


/** 展示TouchID */
+ (BOOL)showTouchIDWithTitle:(NSString *)title backTitle:(NSString *)backTitle replyBlock:(void(^)(SVTouchIDType type , NSError *error))replyBlock{
    if (![self canTouchID]) {
        return NO;
    }
    
    if (!replyBlock) {
        return NO;
    }
    
    // 这里一定要init  每个指纹识别  只能显示一次
    LAContext *context = [[LAContext alloc] init];
    // 设置当输错一次的时候  显示 输入密码 按钮的文字
    // 如果为空  那么不显示输入密码按钮
    context.localizedFallbackTitle = backTitle;
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:title reply:^(BOOL success, NSError * _Nullable error) {
        sv_main_block(^{
            if (success) {
                replyBlock(SVTouchIDSuccess , error );
            }else{
                switch (error.code) {
                    case LAErrorSystemCancel:
                    {
                        NSLog(@"Authentication was cancelled by the system");
                        //切换到其他APP，系统取消验证Touch ID
                        replyBlock(SVTouchIDSystemCancel , error);
                        break;
                    }
                    case LAErrorUserCancel:
                    {
                        NSLog(@"Authentication was cancelled by the user");
                        replyBlock(SVTouchIDUserCanceled , error);
                        //用户取消验证Touch ID
                        break;
                    }
                    case LAErrorUserFallback:
                    {
                        NSLog(@"User selected to enter custom password");
                        replyBlock(SVTouchIDUserFallback , error);
                        break;
                    }
                    case LAErrorAuthenticationFailed:
                    {
                        NSLog(@"Authentication Failed");
                        replyBlock(SVTouchIDAuthenticationFailed , error);
                        break;
                    }
                    case LAErrorTouchIDLockout:
                    {
                        NSLog(@"用户指纹错误多次，TouchID 被锁定");
                        replyBlock(SVTouchIDLockout , error);
                        break;
                    }
                    case LAErrorAppCancel:
                    {
                        NSLog(@"应用程序取消验证");
                        replyBlock(SVTouchIDAppCancel , error);
                        break;
                    }
                    case LAErrorInvalidContext:
                    {
                        NSLog(@"失效");
                        replyBlock(SVTouchIDInvalidContext , error);
                        break;
                    }
                    case LAErrorTouchIDNotEnrolled:
                        NSLog(@"没有登记的TouchID");
                        replyBlock(SVTouchIDInvalidContext , error);
                        break;
                    default:
                    {
                        replyBlock(SVTouchIDFailOther , error);
                        break;
                    }
                }
            }
        });
    }];
    return YES;
}


@end
