//
//  UIAlertController+SVKit.m
//  SevenProject
//
//  Created by kuaiqian on 2017/9/28.
//  Copyright © 2017年 Seven. All rights reserved.
//

#import "UIAlertController+SVKit.h"
#import "SVUtility.h"

@implementation UIAlertController (SVKit)

/*
 *  两个按钮的alert  但是取消按钮的点击事件为空
 */
+ (BOOL)sv_alertWithOneActionAndDoubleTitle:(NSString * __nullable)title
                                 message:(NSString * __nullable)msg
                                delegate:(UIViewController * __nonnull)delegate
                             cancelTitle:(NSString * __nonnull)cancelTitle
                                 okTitle:(NSString * __nonnull)okTitle
                               okhandler:(void(^ __nullable)(UIAlertAction * _Nullable okAction))okhandler{
    return [self sv_alertWithDoubleTitle:title message:msg delegate:delegate cancelTitle:cancelTitle okTitle:okTitle cancelhandler:^(UIAlertAction *cancelAction) {
        
    } okhandler:okhandler];
}


+ (BOOL)sv_alertWithDoubleTitle:(NSString * __nullable)title
                     message:(NSString * __nullable)msg
                    delegate:(UIViewController * __nonnull)delegate
                 cancelTitle:(NSString * __nonnull)cancelTitle
                     okTitle:(NSString * __nonnull)okTitle
               cancelhandler:(void(^__nullable)(UIAlertAction * __nullable cancelAction))cancelhandler
                   okhandler:(void(^__nullable)(UIAlertAction * __nullable okAction))okhandler{
    if (!sv_KindOfClass(delegate, [UIViewController class])) {
        return NO;
    }
    
    UIAlertAction *canceAction = [UIAlertAction
                                  actionWithTitle:cancelTitle
                                  style:UIAlertActionStyleDefault
                                  handler:cancelhandler];
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:okTitle
                               style:UIAlertActionStyleDefault
                               handler:okhandler];
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:msg
                                          preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:canceAction];
    [alertController addAction:okAction];
    [delegate presentViewController:alertController animated:YES completion:nil];
    return YES;
}


+ (BOOL)sv_alertWithSingleTitle:(NSString * __nullable)title
                     message:(NSString * __nullable)msg
                    delegate:(UIViewController * __nonnull)delegate
                 cancelTitle:(NSString * __nonnull)cancelTitle
               cancelhandler:(void(^ __nullable)(UIAlertAction * __nullable cancelAction))cancelhandler{
    if (!sv_KindOfClass(delegate, [UIViewController class])) {
        return NO;
    }
    
    UIAlertAction *canceAction = [UIAlertAction
                                  actionWithTitle:cancelTitle
                                  style:UIAlertActionStyleDefault
                                  handler:cancelhandler];
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:msg
                                          preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:canceAction];
    [delegate presentViewController:alertController animated:YES completion:nil];
    return YES;
}

/*
 *  一个按钮的alert 点击按钮的点击事件为空
 */
+ (BOOL)sv_alertWithNoActionSingleTitle:(NSString * __nullable)title
                             message:(NSString * __nullable)msg
                            delegate:(UIViewController * __nonnull)delegate
                         cancelTitle:(NSString * __nullable)cancelTitle{
    return [self sv_alertWithSingleTitle:title message:msg delegate:delegate cancelTitle:cancelTitle cancelhandler:^(UIAlertAction *cancelAction) {
    }];
}

@end
