//
//  UIButton+SVCountDown.m
//  SevenProject
//
//  Created by kuaiqian on 2017/9/28.
//  Copyright © 2017年 Seven. All rights reserved.
//  倒计时按钮

#import "UIButton+SVCountDown.h"
#import <objc/runtime.h>
#import "SVUtility.h"

#define defaultSeconds 60 //!< 默认秒数

//关联的关键字
static void *SVCountDownFinishTitle = &SVCountDownFinishTitle;
static void *SVCountDownNormalTitle = &SVCountDownNormalTitle;
static void *SVCountDownFinishBlock = &SVCountDownFinishBlock;
static void *SVCountDownSeconds     = &SVCountDownSeconds;
static void *SVCountDownTimer       = &SVCountDownTimer;

@interface UIButton ()
@property (nonatomic , strong) NSTimer      *timer;         //!< 定时器
@property (nonatomic , assign) NSInteger    seconds;        //!< 秒数
@property (nonatomic , copy)   NSString     *finishTitle;   //!< 结束后的文字
@property (nonatomic , copy)   NSString     *normalTitle;   //!< button的初始文字
@property (nonatomic , copy)   void         (^finishBlock)(void);

@end

@implementation UIButton (SVCountDown)

- (void)sv_startCountDown:(NSInteger)seconds
            spellTitle:(NSString * __nullable)spellTitle{
    [self sv_startCountDown:seconds spellTitle:spellTitle finishTitle:nil finishBlock:nil];
}

- (void)sv_startCountDown:(NSInteger)seconds
            spellTitle:(NSString * __nullable)spellTitle
           finishTitle:(NSString * __nullable)finishTitle{
    [self sv_startCountDown:seconds spellTitle:spellTitle finishTitle:finishTitle finishBlock:nil];
}

- (void)sv_startCountDown:(NSInteger)seconds
            spellTitle:(NSString * __nullable)spellTitle
           finishTitle:(NSString * __nullable)finishTitle
           finishBlock:(void (^ __nullable)(void))finishBlock{
    
    self.seconds = seconds;
    self.finishTitle = finishTitle;
    self.normalTitle = self.titleLabel.text;
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(countDown:) userInfo:@{@"spellTitle":spellTitle} repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    // 设置为不可点击
    // 这个为什么要放到最后面那？
    // 因为在定时器的事件  设置的title的状态是UIControlStateDisabled
    // 所以如果刚上来就 self.enabled = NO的话  那么直接就显示UIControlStateDisabled状态的title
    // 如果是第一次  还可以  如果是第二次的话  因为第一次到0s了
    // 所以如果放到最上面  那么直接显示   0s以后   然后才开始走定时器的时间
    // 所以先设置UIControlStateDisabled状态的title
    // 然后在设置为不可点击
    NSString *content = [NSString stringWithFormat:@"%zd%@",self.seconds,spellTitle];
    [self setTitle:content forState:UIControlStateDisabled];
    self.enabled = NO;
}

// 定时器事件
- (void)countDown:(NSTimer *)timer{
    if (self.seconds > 0) {
        self.seconds -= 1;
        NSString *spellTitle = timer.userInfo[@"spellTitle"];
        NSString *content = [NSString stringWithFormat:@"%zd%@",self.seconds,spellTitle];
        [self setTitle:content forState:UIControlStateDisabled];
    }else{
        [self sv_invalidate];
    }
}

// 定时器停止
- (void)sv_invalidate{
    [self.timer invalidate];
    self.enabled = YES;
    if (sv_isStr(self.normalTitle)) {
        [self setTitle:self.normalTitle forState:UIControlStateNormal];
    }
    
    if (sv_isStr(self.finishTitle)) {
        [self setTitle:self.finishTitle forState:UIControlStateNormal];
    }
    
    if (self.finishBlock) {
        self.finishBlock();
    }
    
    //置空
    self.timer = nil;
    self.finishTitle = nil;
    self.finishBlock = nil;
    self.normalTitle = nil;
    self.seconds = 0;
}

#pragma mark - private
#pragma mark 定时器结束后，button上显示的文字
- (void)setFinishTitle:(NSString *)finishTitle{
    objc_setAssociatedObject(self, SVCountDownFinishTitle, finishTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)finishTitle{
    return objc_getAssociatedObject(self, SVCountDownFinishTitle);
}

#pragma mark button的初始文字
- (void)setNormalTitle:(NSString *)normalTitle{
    objc_setAssociatedObject(self, SVCountDownNormalTitle, normalTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)normalTitle{
    return objc_getAssociatedObject(self, SVCountDownNormalTitle);
}

#pragma mark 结束后调用的block
- (void)setFinishBlock:(void (^)(void))finishBlock{
    objc_setAssociatedObject(self, SVCountDownFinishBlock, finishBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(void))finishBlock{
    return objc_getAssociatedObject(self, SVCountDownFinishBlock);
}

#pragma mark 秒数
- (void)setSeconds:(NSInteger)seconds{
    objc_setAssociatedObject(self, SVCountDownSeconds, @(seconds), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)seconds{
    return [objc_getAssociatedObject(self, SVCountDownSeconds) integerValue];
}

#pragma mark 定时器
- (void)setTimer:(NSTimer *)timer{
    objc_setAssociatedObject(self, SVCountDownTimer, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSTimer *)timer{
    return objc_getAssociatedObject(self, SVCountDownTimer);
}

@end
