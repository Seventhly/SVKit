//
//  UIControl+SVBlock.h
//  SevenProject
//
//  Created by kuaiqian on 2017/9/29.
//  Copyright © 2017年 Seven. All rights reserved.
//  自定义事件封装

#import <UIKit/UIKit.h>

@interface UIControl (SVBlock)

@property (nonatomic , copy , nullable) void (^sv_block)(UIControl *__nullable button);

- (void)sv_addActionBlock:(void (^_Nullable)(UIControl *__nullable button))action forControlEvents:(UIControlEvents)controlEvents;

@end
