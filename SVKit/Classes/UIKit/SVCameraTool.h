//
//  SVCameraTool.h
//  SevenProject
//
//  Created by kuaiqian on 2017/9/30.
//  Copyright © 2017年 Seven. All rights reserved.
//  对于系统相机的简单封装

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^SVImageBlock)(UIImage *image);

typedef NS_ENUM(NSInteger ,SVImagePickerType ) {
    SVPhotoLibraryPicker,               //!< 图片列表是指所有的图片
    SVCamerPicker,                      //!< 相机
    SVCamerSavedPhotosAlbum,            //!< 相机相册是指相机拍的照片
};

@interface SVCameraTool : NSObject

+ (instancetype)shareInstance;

/** 判断设备是否有摄像头 */
+ (BOOL) isCameraAvailable;
/** 前面的摄像头是否可用 */
+ (BOOL) isFrontCameraAvailable;
/** 后面的摄像头是否可用 */
+ (BOOL) isRearCameraAvailable;
/** 是否有权限 */
+ (BOOL)isHaveAuthorization;

/**
 根据类型弹出普通的相机或相册
 
 @param soureType 类型
 @param delegate 弹出相机或相册的viewController
 @param imageBlock 选择完照片的回调
 */
- (BOOL)showCameraViewControllerWithType:(SVImagePickerType)soureType delegate:(id)delegate imageBlock:(SVImageBlock)imageBlock;

@end
