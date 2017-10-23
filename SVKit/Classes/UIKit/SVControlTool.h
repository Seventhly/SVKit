//
//  SVControlTool.h
//  SevenProject
//
//  Created by kuaiqian on 2017/9/29.
//  Copyright © 2017年 Seven. All rights reserved.
//  快速创建库控件

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SVControlTool : NSObject

#pragma makr - UILable
/***  正常的label*/
+ (UILabel *)labelWithFrame:(CGRect)frame font:(NSInteger)font textColor:(UIColor *)textColor text:(NSString *)text;
/**
 *  带背景颜色的正常label
 */
+ (UILabel *)labelWithFrame:(CGRect)frame font:(NSInteger)font textColor:(UIColor *)textColor text:(NSString *)text backgroundColor:(UIColor *)backgroundColor;
/***  自适应的label */
+ (UILabel *)labelSizeFitWithText:(NSString *)text textColor:(UIColor *)textColor font:(NSInteger)font;
/***  带背景颜色的自适应的label */
+ (UILabel *)labelSizeFitWithText:(NSString *)text textColor:(UIColor *)textColor font:(NSInteger)font backgroundColor:(UIColor *)backgroundColor;

#pragma mark - UIButton
/***  图片按钮带 */
+ (UIButton *)buttonWithImageName:(NSString *)imageName clickBlock:(void(^)(id x))clickBlock;
/***  图片按钮带frame */
+ (UIButton *)buttonWithImageName:(NSString *)imageName frame:(CGRect)frame clickBlock:(void(^)(id x))clickBlock;

/** 背景图片按钮 */
+ (UIButton *)buttonWithBackgroundImageName:(NSString *)BackgroundImageName clickBlock:(void(^)(id x))clickBlock;
/***  背景图片按钮带frame */
+ (UIButton *)buttonWithBackgroundImageName:(NSString *)BackgroundImageName frame:(CGRect)frame clickBlock:(void(^)(id x))clickBlock;
/***  带背景颜色的文字按钮 */
+ (UIButton *)buttonWithText:(NSString *)text textColor:(UIColor *)textColor font:(NSInteger)font frame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor clickBlock:(void(^)(id x))clickBlock;
/***  文字按钮 */
+ (UIButton *)buttonWithText:(NSString *)text textColor:(UIColor *)textColor font:(NSInteger)font frame:(CGRect)frame clickBlock:(void(^)(id x))clickBlock;

/***  一个透明的按钮 */
+(UIButton *)buttonClearWithClickBlock:(void(^)(id x))clickBlock;
+(UIButton *)buttonClearWithFrame:(CGRect)frame clickBlock:(void(^)(id x))clickBlock;

#pragma mark - UIView
/***  带背景颜色的普通view */
+(UIView *)viewWithFrame:(CGRect)frame backGroudColor:(UIColor *)backGroudColor;

#pragma mark - UIImageView
/***  普通图片*/
+ (UIImageView *)imageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName;
/***  设置拉伸范围的图片 */
+ (UIImageView *)imageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName edge:(UIEdgeInsets)edge;

@end
