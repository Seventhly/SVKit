//
//  SVLocationManager.h
//  SevenProject
//
//  Created by kuaiqian on 2017/9/29.
//  Copyright © 2017年 Seven. All rights reserved.
//  定位Manager

#import <Foundation/Foundation.h>
#import "SVMacros.h"

typedef NS_ENUM(NSInteger,SVLocationStatus){
    SVLocationSuccess,//定位成功
    SVLocationFail,//定位失败
    SVLocationNotAgree,//定位权限没开（用户不允许）
};


@interface SVLocationManager : NSObject

/** 经度 */
@property(nonatomic , assign) double lat;
/** 纬度 */
@property(nonatomic , assign) double lng;
/** 经度String */
@property(nonatomic , readonly) NSString *latString;
/** 纬度String */
@property(nonatomic , readonly) NSString *lngString;

/** 省 （上海市）*/
@property (nonatomic , readonly) NSString *state;
/** 城市 （上海市） */
@property (nonatomic , readonly) NSString *city;
/** 详细地址 中国上海市黄浦区五里桥街道蒙自路849号*/
@property (nonatomic , readonly) NSString *address;
/** 区域（黄浦区） */
@property (nonatomic , readonly) NSString *subLocality;
/** 地址更新时间 */
@property (nonatomic , readonly) NSDate *updateTime;
/** 街道 (蒙自路) */
@property (nonatomic , readonly) NSString *Thoroughfare;
/** 单元 (849号) */
@property (nonatomic , readonly) NSString *SubThoroughfare;
/** 拼接的地址字符串 省|市|区|路 */
@property (nonatomic , readonly) NSString *locationString;
/** 经纬度 lat|lng */
@property (nonatomic , readonly) NSString *latLngString;
/** 经纬度拼接  保留小数点后6位 */
@property (nonatomic , readonly) NSString *location;


ShareInstance_H

/**
 开始定位

 @param locationBlock 定位成功或失败   如果成功，那么地址信息都存到单例里面了
 */
- (void)startLocationWithLocationBlock:(void(^)(SVLocationStatus status))locationBlock;


@end
