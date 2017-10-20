//
//  SVControlTool.m
//  SevenProject
//
//  Created by kuaiqian on 2017/9/29.
//  Copyright © 2017年 Seven. All rights reserved.
//  快速创建库控件

#import "SVControlTool.h"
#import "UIControl+SVBlock.h"

@implementation SVControlTool

#pragma mark - Label
#pragma mark 普通的label
+ (UILabel *)labelWithFrame:(CGRect)frame font:(NSInteger)font textColor:(UIColor *)textColor text:(NSString *)text{
    return [self labelWithFrame:frame font:font textColor:textColor text:text backgroundColor:nil];
}

+ (UILabel *)labelWithFrame:(CGRect)frame font:(NSInteger)font textColor:(UIColor *)textColor text:(NSString *)text backgroundColor:(UIColor *)backgroundColor{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = textColor;
    if (backgroundColor) {
        label.backgroundColor = backgroundColor;
    }
    return label;
    
}

#pragma mark 根据文字自适应的label   text必须要传入
+ (UILabel *)labelSizeFitWithText:(NSString *)text textColor:(UIColor *)textColor font:(NSInteger)font{
    return [self labelSizeFitWithText:text textColor:textColor font:font backgroundColor:nil];
}

+ (UILabel *)labelSizeFitWithText:(NSString *)text textColor:(UIColor *)textColor font:(NSInteger)font backgroundColor:(UIColor *)backgroundColor{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = textColor;
    label.text = text;
    label.font = [UIFont systemFontOfSize:font];
    if (backgroundColor) {
        label.backgroundColor = backgroundColor;
    }
    [label sizeToFit];
    return label;
}

#pragma mark - Button
#pragma mark 图片按钮
+ (UIButton *)buttonWithImageName:(NSString *)imageName clickBlock:(void(^)(id x))clickBlock{
    return [self buttonWithImageName:imageName frame:CGRectZero clickBlock:clickBlock];
}

+ (UIButton *)buttonWithImageName:(NSString *)imageName frame:(CGRect)frame clickBlock:(void(^)(id x))clickBlock{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button sv_addActionBlock:clickBlock forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)buttonWithBackgroundImageName:(NSString *)BackgroundImageName clickBlock:(void(^)(id x))clickBlock{
    return [self buttonWithBackgroundImageName:BackgroundImageName frame:CGRectZero clickBlock:clickBlock];
}
+ (UIButton *)buttonWithBackgroundImageName:(NSString *)BackgroundImageName frame:(CGRect)frame clickBlock:(void(^)(id x))clickBlock{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setBackgroundImage:[UIImage imageNamed:BackgroundImageName] forState:UIControlStateNormal];
    [button sv_addActionBlock:clickBlock forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark 文字按钮
+ (UIButton *)buttonWithText:(NSString *)text textColor:(UIColor *)textColor font:(NSInteger)font frame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor clickBlock:(void(^)(id x))clickBlock{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    if (backgroundColor) {
        button.backgroundColor = backgroundColor;
    }
    //点击事件
    if (clickBlock) {
        [button sv_addActionBlock:clickBlock forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}

+ (UIButton *)buttonWithText:(NSString *)text textColor:(UIColor *)textColor font:(NSInteger)font frame:(CGRect)frame clickBlock:(void(^)(id x))clickBlock{
    return [self buttonWithText:text textColor:textColor font:font frame:frame backgroundColor:nil clickBlock:clickBlock];
}

/***  透明按钮 */
+(UIButton *)buttonClearWithClickBlock:(void(^)(id x))clickBlock{
    return [self buttonClearWithFrame:CGRectZero clickBlock:clickBlock];
}
+(UIButton *)buttonClearWithFrame:(CGRect)frame clickBlock:(void(^)(id x))clickBlock{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button sv_addActionBlock:clickBlock forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark - View
+(UIView *)viewWithFrame:(CGRect)frame backGroudColor:(UIColor *)backGroudColor{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = backGroudColor;
    return view;
}

#pragma mark - UIImageView
+ (UIImageView *)imageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName edge:(UIEdgeInsets)edge{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageNamed:imageName];
    //当为不等于 0的时候  说明要求不拉伸了
    if (!UIEdgeInsetsEqualToEdgeInsets(edge,UIEdgeInsetsZero)) {
        imageView.image = [[UIImage imageNamed:imageName] resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
    }
    return imageView;
}


+ (UIImageView *)imageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName{
    return [self imageViewWithFrame:frame imageName:imageName edge:UIEdgeInsetsZero];
}

@end
