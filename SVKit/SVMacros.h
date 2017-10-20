//
//  SVMacros.h
//  SevenProject
//
//  Created by kuaiqian on 2017/9/29.
//  Copyright © 2017年 Seven. All rights reserved.
//

#ifndef SVMacros_h
#define SVMacros_h

#ifdef DEBUG // 处于开发阶段
#define SVLog(...) NSLog(__VA_ARGS__)
#define SVLineLog(fmt, ...) NSLog((@"[函数名:%s]" "[行号:%d]  " fmt),__FUNCTION__, __LINE__, ##__VA_ARGS__);
#else // 处于发布阶段
#define SVLog(...)
#define SVLineLog(fmt, ...)
#endif


// 单例  .h
#define ShareInstance_H \
+ (instancetype)shareInstance;
// 单例  .m
#define ShareInstance_M(className) \
+ (instancetype)shareInstance {\
static className *classNameShare = nil;\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
classNameShare = [[self alloc] init];\
});\
return classNameShare;\
}\


#define SV_FORMAT(format, args...) [NSString stringWithFormat:format, args]


#endif /* SVMacros_h */
