//
//  UIImage+SVKit.h
//  SevenProject
//
//  Created by kuaiqian on 2017/10/20.
//  Copyright © 2017年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SVKit)

/** 根据颜色创建一个宽高为1的图片 */
+ (UIImage *_Nullable)sv_createImageWithColor:(UIColor *__nonnull)color;

/** 根据颜色和大小创建图片 */
+ (UIImage *_Nullable)sv_createImageWithColor:(UIColor *__nonnull)color size:(CGSize)size;

@end
