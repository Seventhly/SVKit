//
//  SVUtility.h
//  SevenProject
//
//  Created by kuaiqian on 2017/9/28.
//  Copyright © 2017年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SVUtility : NSObject
#pragma mark 当程序切到后台  添加毛玻璃效果
+ (void)addEffectView;
+ (void)removeEffectView;

/** 获取当前的ViewController */
+ (UIViewController *__nullable)topViewController;

@end
#pragma mark - 函数
/** 主线程块 */
extern void sv_main_block(void (^ _Nonnull block)(void));

/** 延迟加载 */
extern void sv_delayOperation(float time,void (^ _Nonnull block)(void));

/** 异步块 */
extern void sv_async_block(void (^ _Nonnull block)(void));

/** 是否为字符串 */
extern BOOL sv_isStr(id _Nullable aid);

/** 是否为数组 */
extern BOOL sv_isArr(id _Nullable aid);

/** 是否为字典 */
extern BOOL sv_isDict(id _Nullable aid);

/** 客户端版本-内部版本 */
extern NSString * _Nullable sv_Tool_CFVersion(void);

/** 客户端外部版本号 */
extern NSString * _Nullable sv_Tool_CFVersionString(void);

/** 是否为同一类型 */
extern BOOL sv_KindOfClass(id __nonnull num1 , id __nonnull num2);
