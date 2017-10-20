//
//  UIAlertController+SVKit.h
//  SevenProject
//
//  Created by kuaiqian on 2017/9/28.
//  Copyright © 2017年 Seven. All rights reserved.
//  AlertController

#import <UIKit/UIKit.h>

@interface UIAlertController (SVKit)

#pragma mark - 两个按钮
/** 两个按钮的alert  但是取消按钮的点击事件为空 */
+ (BOOL)sv_alertWithOneActionAndDoubleTitle:(NSString * __nullable)title
                                 message:(NSString * __nullable)msg
                                delegate:(UIViewController * __nonnull)delegate
                             cancelTitle:(NSString * __nonnull)cancelTitle
                                 okTitle:(NSString * __nonnull)okTitle
                               okhandler:(void(^ __nullable)(UIAlertAction * _Nullable okAction))okhandler;
/** 两个按钮的alert */
+ (BOOL)sv_alertWithDoubleTitle:(NSString * __nullable)title
                     message:(NSString * __nullable)msg
                    delegate:(UIViewController * __nonnull)delegate
                 cancelTitle:(NSString * __nonnull)cancelTitle
                     okTitle:(NSString * __nonnull)okTitle
               cancelhandler:(void(^__nullable)(UIAlertAction * __nullable cancelAction))cancelhandler
                   okhandler:(void(^__nullable)(UIAlertAction * __nullable okAction))okhandler;

#pragma mark - 单个按钮
/** 一个按钮的alert */
+ (BOOL)sv_alertWithSingleTitle:(NSString * __nullable)title
                     message:(NSString * __nullable)msg
                    delegate:(UIViewController * __nonnull)delegate
                 cancelTitle:(NSString * __nonnull)cancelTitle
               cancelhandler:(void(^ __nullable)(UIAlertAction * __nullable cancelAction))cancelhandler;

/** 一个按钮的alert 点击按钮的点击事件为空 */
+ (BOOL)sv_alertWithNoActionSingleTitle:(NSString * __nullable)title
                             message:(NSString * __nullable)msg
                            delegate:(UIViewController * __nonnull)delegate
                         cancelTitle:(NSString * __nullable)cancelTitle;
@end
