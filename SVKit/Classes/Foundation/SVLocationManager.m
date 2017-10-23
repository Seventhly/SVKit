//
//  SVLocationManager.m
//  SevenProject
//
//  Created by kuaiqian on 2017/9/29.
//  Copyright © 2017年 Seven. All rights reserved.
//

#import "SVLocationManager.h"
#import <CoreLocation/CoreLocation.h>
#import "SVUtility.h"

@interface SVLocationManager () <CLLocationManagerDelegate>
//定位管理者
@property (nonatomic, strong) CLLocationManager *locationManager;
//地址编码(把定位转成地址)
@property (nonatomic, strong) CLGeocoder *gecoder;

@property (nonatomic , copy) void(^locationBlock)(SVLocationStatus status);

@end


@implementation SVLocationManager

ShareInstance_M(SVLocationManager)

//开始定位
- (void)startLocationWithLocationBlock:(void(^)(SVLocationStatus status))locationBlock{
    
    if (![CLLocationManager locationServicesEnabled]) {
        SVLineLog(@"定位服务当前可能尚未打开，请设置打开！");
        locationBlock(SVLocationNotAgree);
        return;
    }
    /*
     kCLAuthorizationStatusNotDetermined： 用户尚未做出决定是否启用定位服务
     kCLAuthorizationStatusRestricted： 没有获得用户授权使用定位服务,可能用户没有自己禁止访问授权
     kCLAuthorizationStatusDenied ：用户已经明确禁止应用使用定位服务或者当前系统定位服务处于关闭状态
     kCLAuthorizationStatusAuthorizedAlways： 应用获得授权可以一直使用定位服务，即使应用不在使用状态
     kCLAuthorizationStatusAuthorizedWhenInUse： 使用此应用过程中允许访问定位服务
     */
    self.locationBlock = locationBlock;
    //用户不同意
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted) {
        if (self.locationBlock) {
            self.locationBlock(SVLocationNotAgree);
        }
        return;
    }else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined){
        [self.locationManager requestWhenInUseAuthorization];
    }else{
        //启动跟踪定位
        [self.locationManager startUpdatingLocation];
    }
}

#pragma mark - locationManagerDelegate
#pragma mark 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）
//可以通过模拟器设置一个虚拟位置，否则在模拟器中无法调用此方法
//定位成功
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    //如果不需要实时定位，使用完即使关闭定位服务
    [self.locationManager stopUpdatingLocation];
    
    CLLocation *location = [locations lastObject];//取出最后位置
    //    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
    _lat = location.coordinate.latitude;
    _lng = location.coordinate.longitude;
    [self geocoderWith:location];
    
    
    
    if (self.locationBlock) {
        self.locationBlock(SVLocationSuccess);
    }
    
}


//定位失败
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    [self.locationManager stopUpdatingLocation];
    if (self.locationBlock) {
        self.locationBlock(SVLocationFail);
    }
}


// 授权状态改变的时候
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if (status == kCLAuthorizationStatusDenied || status == kCLAuthorizationStatusRestricted) {//当为不允许的时候
        if (self.locationBlock) {
            self.locationBlock(SVLocationNotAgree);
        }
    }else if(status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse){//当为同意的时候
        [self.locationManager startUpdatingLocation];
    }
}


#pragma mark - 根据经纬度获取地址
- (void)geocoderWith:(CLLocation*)location{
    
    [self.gecoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (!error) {
            if (sv_isArr(placemarks)) {
                CLPlacemark *mark = placemarks.firstObject;
                NSDictionary* addrDic = mark.addressDictionary;
                _updateTime = [NSDate date];
                
                _state = [addrDic objectForKey:@"State"];
                _city = mark.locality;
                _city = [addrDic objectForKey:@"City"];
                _subLocality = [addrDic objectForKey:@"SubLocality"];
                _Thoroughfare = [addrDic objectForKey:@"Thoroughfare"];
                _SubThoroughfare = [addrDic objectForKey:@"SubThoroughfare"];
                
                NSArray * addressArray = [addrDic objectForKey:@"FormattedAddressLines"];
                if (sv_isArr(addressArray)){
                    _address = [addressArray firstObject];
                }
            }
        }
    }];
}

#pragma mark - private
-(NSString*)latLngString{
    return [NSString stringWithFormat:@"%f,%f", self.lat, self.lng];
}


-(NSString *)locationString{
    return  [NSString stringWithFormat:@"%@|%@|%@|%@|%@",self.state,self.city,self.subLocality,self.Thoroughfare,self.SubThoroughfare?self.SubThoroughfare:@""];
}

- (NSString *)location{
    
    if (self.lat && self.lng) {
        return [NSString stringWithFormat:@"%.6f,%.6f",self.lat,self.lng];
    }else{
        return @"";
    }
}

- (NSString *)latString{
    return [NSString stringWithFormat:@"%f",self.lat];
}

- (NSString *)lngString{
    return [NSString stringWithFormat:@"%f",self.lng];
}

#pragma mark - 懒加载
- (CLGeocoder *)gecoder{
    if (_gecoder == nil) {
        _gecoder = [[CLGeocoder alloc] init];
    }
    return _gecoder;
}


- (CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        //设置代理
        _locationManager.delegate = self;
        //设置定位精度
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //定位频率,每隔多少米定位一次
        CLLocationDistance distance = 10.0;//十米定位一次
        _locationManager.distanceFilter = distance;
    }
    return _locationManager;
}


@end
