//
//  UIButton+SVCountDown.h
//  SevenProject
//
//  Created by kuaiqian on 2017/9/28.
//  Copyright © 2017年 Seven. All rights reserved.
//  倒计时按钮

#import <UIKit/UIKit.h>

@interface UIButton (SVCountDown)
/**
 开始倒计时
 
 @param seconds 秒数
 @param spellTitle 秒数后拼接的文字
 如要显示 60s后重发  那么seconds = 60   spellTitle = @"s后重发"
 */
- (void)sv_startCountDown:(NSInteger)seconds
            spellTitle:(NSString * __nullable)spellTitle;

/**
 开始倒计时
 
 @param seconds 秒数
 @param spellTitle 秒数后拼接的文字
 @param finishTitle 定时器结束后，button上显示的文字
 */
- (void)sv_startCountDown:(NSInteger)seconds
            spellTitle:(NSString * __nullable)spellTitle
           finishTitle:(NSString * __nullable)finishTitle;

/**
 开始倒计时
 
 @param seconds 秒数
 @param spellTitle 秒数后拼接的文字
 @param finishTitle 定时器结束后，button上显示的文字
 @param finishBlock 定时器结束后调用的block   可为nil
 */
- (void)sv_startCountDown:(NSInteger)seconds
            spellTitle:(NSString * __nullable)spellTitle
           finishTitle:(NSString * __nullable)finishTitle
           finishBlock:(void (^ __nullable)(void))finishBlock;

/**
 停止定时器 一般用于delloc或者跳转中
 */
- (void)sv_invalidate;
@end
