//
//  UIControl+SVBlock.m
//  SevenProject
//
//  Created by kuaiqian on 2017/9/29.
//  Copyright © 2017年 Seven. All rights reserved.
//

#import "UIControl+SVBlock.h"
#import <objc/runtime.h>

static void *SVBlock = &SVBlock;

@implementation UIControl (SVBlock)

- (void)sv_addActionBlock:(void (^_Nullable)(UIControl *__nullable button))action forControlEvents:(UIControlEvents)controlEvents{
    self.sv_block = action;
    [self addTarget:self action:@selector(svkit_controlAction:) forControlEvents:controlEvents];
}

- (void)svkit_controlAction:(UIControl *)control{
    if (self.sv_block) {
        self.sv_block(control);
    }
}

#pragma mark - private
- (void)setSv_block:(void (^)(UIControl *__nullable))sv_block{
    if (sv_block) {
        objc_setAssociatedObject(self, SVBlock, sv_block, OBJC_ASSOCIATION_ASSIGN);
    }
}

- (void (^)(UIControl * _Nullable))sv_block{
    return objc_getAssociatedObject(self, SVBlock);
}


@end
