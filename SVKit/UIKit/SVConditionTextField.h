//
//  SVConditionTextField.h
//  SevenProject
//
//  Created by kuaiqian on 2017/9/30.
//  Copyright © 2017年 Seven. All rights reserved.
//  textField封装

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger , SVConditionType) {
    SVConditionType_Deafult = 0,        //!< 默认
    SVConditionType_Number,             //!< 数字
    SVConditionType_Alphanumeric,       //!< 字母和数字
    SVConditionType_CardNumber,         //!< 银行卡号
    SVConditionType_Money               //!< 金额数字
};

@interface SVConditionTextField : UITextField
/** 类型 */
@property (nonatomic , assign) SVConditionType conditionType;
/** 最大长度 */
@property (nonatomic , assign) NSInteger maxLength;
/** 最大值  为金额专属   可设置金额数字的最大值 */
@property (nonatomic , assign) CGFloat maxValue;
/** 设置内边距 */
@property (nonatomic , assign) UIEdgeInsets edgeInsets;
/** 键盘弹起的Block */
@property (nonatomic , copy) void (^keyboardAppear)(CGRect keyboardRect);
/** 键盘收起的Block */
@property (nonatomic , copy) void (^keyboardDisAppear)(void);

/** 设置textfield的leftView为imageview  imageview的宽度为image.width+15的大小 */
- (void) addLeftImage:(NSString *)image;

/** 设置textfield的leftView为label  label的宽度为自定义 */
- (void) addLeftLabel:(NSString *)title width:(CGFloat)width;

@end
