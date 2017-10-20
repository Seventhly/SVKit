//
//  SVUtility.m
//  SevenProject
//
//  Created by kuaiqian on 2017/9/28.
//  Copyright © 2017年 Seven. All rights reserved.
//

#import "SVUtility.h"


#define SVVisualEffectViewTag 1103

@implementation SVUtility
#pragma mark 当程序切到后台  添加毛玻璃效果
+ (void)addEffectView{
    // 毛玻璃
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    effectView.frame = [UIScreen mainScreen].bounds;
    effectView.tag = SVVisualEffectViewTag;
    [[UIApplication sharedApplication].delegate.window addSubview:effectView];
}

+ (void)removeEffectView{
    // 移除毛玻璃效果
    UIView *effectView = [[UIApplication sharedApplication].keyWindow viewWithTag:SVVisualEffectViewTag];
    if (effectView) {
        [effectView removeFromSuperview];
    }
}

// 查看屏幕当前的显示的ViewController
#pragma mark 查看屏幕当前的显示的ViewController
+ (UIViewController *__nullable)topViewController{
    UIViewController *resultVC;
    resultVC = [self sv_topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self sv_topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *__nullable)sv_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self sv_topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self sv_topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

@end

#pragma mark  - 主线程块
extern void sv_main_block(void (^ _Nonnull block)(void)){
    dispatch_async(dispatch_get_main_queue(), block);
}

#pragma mark 延迟加载
extern void sv_delayOperation(float time,void (^ _Nonnull block)(void)){
    if (time < 0) return;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:time];
        sv_main_block(block);
    });
}

extern void sv_async_block(void (^ _Nonnull block)(void)){
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

#pragma mark - 是否为字符串
extern BOOL sv_isStr(id _Nullable aid){
    if ([aid isKindOfClass:[NSString class]] && aid != nil) {
        NSString *str = (NSString *)aid;
        if (str.length > 0) {
            return YES;
        }
        return NO;
    }
    return NO;
}

#pragma mark 是否为数组
extern BOOL sv_isArr(id _Nullable aid){
    return aid && [aid isKindOfClass:[NSArray class]] && (((NSArray *)aid).count > 0);
}

#pragma mark  是否为字典
extern BOOL sv_isDict(id _Nullable aid){
    return aid != nil && [aid isKindOfClass:NSDictionary.class] && [aid allKeys].count > 0;
}

#pragma mark - 客户端内部版本
extern NSString * _Nullable sv_Tool_CFVersion(void){
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

#pragma mark - 客户端外部版本号
extern NSString * _Nullable sv_Tool_CFVersionString(void){
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

extern BOOL sv_KindOfClass(id __nonnull num1 , id __nonnull num2){
    return [num1 isKindOfClass:[num2 class]];
}
