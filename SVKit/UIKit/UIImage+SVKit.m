//
//  UIImage+SVKit.m
//  SevenProject
//
//  Created by kuaiqian on 2017/10/20.
//  Copyright © 2017年 Seven. All rights reserved.
//  图片类

#import "UIImage+SVKit.h"

@implementation UIImage (SVKit)

+ (UIImage *_Nullable)sv_createImageWithColor:(UIColor *__nonnull)color{
    return [self sv_createImageWithColor:color size:CGSizeMake(1.0f, 1.0f)];
}

+ (UIImage *_Nullable)sv_createImageWithColor:(UIColor *__nonnull)color size:(CGSize)size{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
