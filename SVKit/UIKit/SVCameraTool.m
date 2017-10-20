//
//  SVCameraTool.m
//  SevenProject
//
//  Created by kuaiqian on 2017/9/30.
//  Copyright © 2017年 Seven. All rights reserved.
//

#import "SVCameraTool.h"
#import <AVFoundation/AVFoundation.h>
//图片判断的系统库
#import <MobileCoreServices/MobileCoreServices.h>

@interface SVCameraTool () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic , copy) SVImageBlock block;

@end

@implementation SVCameraTool

//这边必须要有一个单利  因为ImagePicker的代理  要是一个对象才行
+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static SVCameraTool *tool = nil;
    dispatch_once(&onceToken, ^{
        tool = [[self alloc] init];
    });
    return tool;
}
// 判断设备是否有摄像头
+ (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

// 前面的摄像头是否可用
+ (BOOL) isFrontCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

// 后面的摄像头是否可用
+ (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}



/** 是否有权限 */
+ (BOOL)isHaveAuthorization{
    //判断相机权限
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusDenied){//当不等于授权的时候  那么就提示
        return NO;
    }
    return YES;
}

#pragma mark - 推出相机相册界面
- (BOOL)showCameraViewControllerWithType:(SVImagePickerType)soureType delegate:(UIViewController *)delegate imageBlock:(SVImageBlock)imageBlock{
    // 判断是否有摄像头并且有权限  防崩
    if (![SVCameraTool isCameraAvailable] || ![SVCameraTool isHaveAuthorization]) {
        return NO;
    }
    
    UIImagePickerController *imagePickerVc =[[UIImagePickerController alloc] init];
    /*
     *  设置类型
     *  UIImagePickerControllerSourceTypePhotoLibrary       图片列表
     *  UIImagePickerControllerSourceTypeCamera             相机
     *  UIImagePickerControllerSourceTypeSavedPhotosAlbum   相机相册
     */
    imagePickerVc.sourceType = [self pickerType:soureType];
    imagePickerVc.delegate = self;
    //    imagePickerVc.showsCameraControls = NO;
    // 设置是否可以管理已经存在的图片或者视频
    // 设置选中图片或拍完照片以后 是否可以编辑照片
    imagePickerVc.allowsEditing = YES;
    self.block = imageBlock;
    
    if (![delegate isKindOfClass:[UIViewController class]]) {
        return NO;
    }
    [delegate presentViewController:imagePickerVc animated:YES completion:nil];
    return YES;
}

#pragma mark -UIImagePickerControllerDelegate
//选中图片或拍照结束后
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    // 判断获取类型：图片
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        UIImage *theImage = nil;
        // 判断，图片是否允许修改
        if ([picker allowsEditing]){
            //获取用户编辑之后的图像
            theImage = [info objectForKey:UIImagePickerControllerEditedImage];
        } else {
            // 照片的元数据参数
            theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        
        if (self.block) {
            self.block(theImage);
        }
        [picker dismissViewControllerAnimated:YES completion:nil];
        picker.delegate = nil;
        self.block = nil;
    }else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]){
        //摄像
    }
}


//相机或相册中取消按钮的回调
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
    picker.delegate = nil;
    self.block = nil;
}


#pragma mark - private
// 类型
- (UIImagePickerControllerSourceType)pickerType:(SVImagePickerType)pickerType{
    UIImagePickerControllerSourceType type;
    switch (pickerType) {
        case SVPhotoLibraryPicker:
            type = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        case SVCamerPicker:
            type = UIImagePickerControllerSourceTypeCamera;
            break;
        case SVCamerSavedPhotosAlbum:
            type = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            break;
        default:
            break;
    }
    return type;
}

@end
