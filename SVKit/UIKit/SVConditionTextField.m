//
//  SVConditionTextField.m
//  SevenProject
//
//  Created by kuaiqian on 2017/9/30.
//  Copyright © 2017年 Seven. All rights reserved.
//

#import "SVConditionTextField.h"
#import "UIView+Frame.h"
#import "NSString+SVVerification.h"

#define kAlphanumeric @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_"

@implementation SVConditionTextField


- (void)awakeFromNib{
    [super awakeFromNib];
    [self initialize];
}

- (instancetype)init{
    if (self = [super init]) {
        [self initialize];
    }
    return  self;
}

#pragma mark - 初始化
- (void)initialize{
    self.maxLength = INT_MAX;                               //!< 默认长度为不限制
    self.conditionType = SVConditionType_Deafult;           //!< 默认类型
    self.maxValue = CGFLOAT_MAX;                            //!< 金额默认不限制
    self.clearButtonMode = UITextFieldViewModeAlways;       //!< 默认有clean按钮
    self.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.autocorrectionType = UITextAutocorrectionTypeNo;   //!< 取消自动校正
    self.spellCheckingType = UITextSpellCheckingTypeNo;     //!< 取消拼写检查
    // 文字改变的事件
    [self addTarget:self action:@selector(textFieldContextChange) forControlEvents:UIControlEventEditingChanged];
    // 监听键盘弹起
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAppear:) name:UIKeyboardWillShowNotification object:nil];
    // 监听键盘收起
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDisAppear:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark 输入框文字改变事件
- (void)textFieldContextChange{
    // 长度限制
    if (self.text.length >= self.maxLength) {
        self.text = [self.text substringToIndex:self.maxLength];
        return;
    }
    switch (self.conditionType) {
        case SVConditionType_Deafult://默认
            
            break;
        case SVConditionType_Money:{//金额
            [self moneyLimit];
        }
            break;
        case SVConditionType_Number:{//数字
            [self onlyNumber];
        }
            break;
        case SVConditionType_CardNumber:{//卡号
            [self onlyNumber];
        }
            break;
            
        case SVConditionType_Alphanumeric:{//字母和数字
            [self AlphanumericLimit];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 设置textfield的内边距
// 注: 下面两个要一起重写  如果光重写一个的话  那么就有会有问题
// 设置默认文字的内边距(不在选中状态下的时候)
- (CGRect)textRectForBounds:(CGRect)bounds{
    return [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, self.edgeInsets)];
}

// 设置输入文字的内边距(在选中状态下的时候)
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [super editingRectForBounds:UIEdgeInsetsInsetRect(bounds, self.edgeInsets)];
}

#pragma mark textfield的工具栏
- (UIView *)inputAccessoryView
{
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    UIToolbar* inputAccessoryToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, screenBounds.size.width, 40)];
    [inputAccessoryToolbar setBarStyle:UIBarStyleDefault];
    [inputAccessoryToolbar setTranslucent:YES];
    [inputAccessoryToolbar setBackgroundColor:[UIColor whiteColor]];
    
    UIBarButtonItem *fixItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(accessoryViewHideKeyboard)];
    
    [inputAccessoryToolbar setItems:[NSArray arrayWithObjects:fixItem, doneItem, nil]];
    return inputAccessoryToolbar;
}

-(void)accessoryViewHideKeyboard
{
    [self resignFirstResponder];
}


#pragma mark 键盘弹出事件
- (void)keyboardAppear:(NSNotification *)not{
    // 拿到键盘的frame
    CGRect rect = [not.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    if (self.keyboardAppear) {
        self.keyboardAppear(rect);
    }
}

#pragma mark 键盘收起事件
- (void)keyboardDisAppear:(NSNotification *)not{
    if (self.keyboardDisAppear) {
        self.keyboardDisAppear();
    }
}

#pragma mark - 添加左边的图片
- (void) addLeftImage:(NSString *)image{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
    imageView.width += 15;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.leftView = imageView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)addLeftLabel:(NSString *)title width:(CGFloat)width{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, self.height)];
    label.text = title;
    label.textColor = self.textColor;
    label.font = self.font;
    label.textAlignment = NSTextAlignmentCenter;
    self.leftView = label;
    self.leftViewMode = UITextFieldViewModeAlways;
}

#pragma mark - private
#pragma mark - 类型
- (void)setConditionType:(SVConditionType)conditionType{
    _conditionType = conditionType;
    switch (conditionType) {
        case SVConditionType_Deafult://默认
            self.keyboardType = UIKeyboardTypeDefault;
            break;
        case SVConditionType_Money:{//金额
            self.keyboardType = UIKeyboardTypeDecimalPad;//!< 这个键盘带小数点
        }
            break;
        case SVConditionType_Number:{//数字
            self.keyboardType = UIKeyboardTypeNumberPad;
        }
            break;
        case SVConditionType_CardNumber:{//卡号
            self.keyboardType = UIKeyboardTypeNumberPad;
            // 银行位数  19位
            if (self.maxLength == INT32_MAX) {
                self.maxLength = 19;
            }
        }
            break;
            
        case SVConditionType_Alphanumeric:{//字母和数字
            self.keyboardType = UIKeyboardTypeDefault;
        }
            break;
            
        default:
            break;
    }
}

#pragma mark  金额限定
/**
 *  只能输入数字和点
 *  第一位为0  第二位不能为零
 *  只能输入小数点后两位
 */
- (void)moneyLimit{
    CGFloat price =  self.text.floatValue;
    if (price > self.maxValue) {
        //        self.text = [self.text substringToIndex:self.text.length - 1];
        self.text = [NSString stringWithFormat:@"%.2f",self.maxValue];
        return;
    }
    if (self.text.length >= 1) {
        //只能输入数字和点
        char last = [self.text characterAtIndex:self.text.length - 1];
        if (!((last >= '0' && last <= '9')||last == '.')//!< 只能输入数字和点
            || (self.text.length == 1 && last == '.')   //!< 第一位不能输入点
            ) {
            self.text = [self.text substringToIndex:self.text.length - 1];
            return;
        }
        // 当第一位为0  第二位不能为零
        char fist = [self.text characterAtIndex:0];
        if (self.text.length == 2 && fist == '0' && last != '.') {//!< 当为第一个数字为0的时候第二位必须为'.'不能为其他的数字
            self.text = [self.text substringToIndex:self.text.length - 1];
            return;
        }
        
        
        NSRange range = [self.text rangeOfString:@"."];
        if (range.location != NSNotFound) {
            // 限时:只能输入小数点后两位
            // 先找一下 是否有小数点  如果有   那么判断现在输入的是在小数点后面几位  如果为第三位  那么不让输
            if (self.text.length - 1 - range.location >= 3) {
                self.text = [self.text substringToIndex:self.text.length - 1];
                return;
            }
            
            // 限时:小数点  只能有一个
            if (last == '.' && range.location != self.text.length - 1) {
                self.text = [self.text substringToIndex:self.text.length - 1];
                return;
            }
        }
    }
    
    //    if (self.text.length >= 2) {
    //        char lastSecond = [self.text characterAtIndex:self.text.length - 2];
    //        char last = [self.text characterAtIndex:self.text.length - 1];
    //        if (last == '.' && lastSecond == '.') {
    //            self.text = [self.text substringToIndex:self.text.length - 1];
    //            return;
    //        }
    //    }
}

#pragma mark 只能输入数字
- (void)onlyNumber{
    if (self.text.length >= 1) {//只能输入数字
        char last = [self.text characterAtIndex:self.text.length - 1];
        if (! (last >= '0' && last <= '9')) {
            self.text = [self.text substringToIndex:self.text.length - 1];
            return;
        }
    }
}

#pragma mark - 字母和数字，不能输入中文  (现在有问题，当输入两个中文的时候，只会去掉一个  所以就能输入一个了。。。)
- (void)AlphanumericLimit{
    if (self.text.length > 0) {
        //判断不能输入字符
        NSString *lastString = [self.text substringFromIndex:self.text.length - 1];
        NSCharacterSet *cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphanumeric] invertedSet];
        NSString *filtered = [[lastString componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
        // 是否为字母
        BOOL canChange = [lastString isEqualToString:filtered];
        // 是否为中文
        BOOL IsChinese = [lastString sv_haveChinese];
        if (!canChange && IsChinese) {
            self.text = [self.text substringToIndex:self.text.length - 1];
            return;
        }
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
