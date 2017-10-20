//
//  SVTouchID.h
//  SevenProject
//
//  Created by kuaiqian on 2017/9/29.
//  Copyright © 2017年 Seven. All rights reserved.
//  TouchID 简单封装

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger , SVTouchIDType){
    SVTouchIDSuccess = 1 ,                  //!< TouchID 校验成功
    SVTouchIDUserCanceled ,                 //!< 用户取消
    SVTouchIDAuthenticationFailed ,         //!< 验证失败
    SVTouchIDUserFallback ,                 //!< 用户选择输入密码
    SVTouchIDSystemCancel ,                 //!< 系统取消（如：另外一个应用进入前台）
    SVTouchIDLockout ,                      //!< 用户指纹错误多次，TouchID 被锁定
    SVTouchIDAppCancel ,                    //!< 被应用程序或电话取消
    SVTouchIDInvalidContext ,               //!< 验证失效
    SVTouchIDFailOther ,                    //!< 其他原因的失败
    SVTouchIDNotEnrolled ,                  //!< 没有登记TouchID
};

@interface SVTouchID : NSObject

/**
 是否能touchID
 */
+ (BOOL)canTouchID;

/**
 展示TouchID (默认backTitle为@"")
 
 @param title 提示的文字
 @param replyBlock 回调block
 */
+ (BOOL)showTouchIDWithTitle:(NSString *)title replyBlock:(void(^)(SVTouchIDType type , NSError *error))replyBlock;

/**
 展示TouchID
 
 @param title 提示文字
 @param backTitle 当用户验证错误时,TouchID底部会出现一个按钮,该字段为设置按钮文字字段,如果为@"",那么用户验证错误,不显示会出现按钮,只有 取消
 @param replyBlock 回调block
 */
+ (BOOL)showTouchIDWithTitle:(NSString *)title backTitle:(NSString *)backTitle replyBlock:(void(^)(SVTouchIDType type , NSError *error))replyBlock;

@end
