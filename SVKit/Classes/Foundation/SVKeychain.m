//
//  SVKeychain.m
//  SevenProject
//
//  Created by kuaiqian on 2017/10/19.
//  Copyright © 2017年 Seven. All rights reserved.
//  钥匙串轻量存储

#import "SVKeychain.h"
#import "SVUtility.h"

static NSString *SV_APP_IN_KEYCHAIN_KEY = nil;          //!< key
static NSMutableDictionary *SV_KEYCHAIN_DIC = nil;      //!< 字典

@implementation SVKeychain

+ (void)initialize{
    
    SV_APP_IN_KEYCHAIN_KEY = [NSString stringWithFormat:@"%@.%@", [[NSBundle mainBundle] bundleIdentifier], @"SVKeychain"];
    SV_KEYCHAIN_DIC = [self load:SV_APP_IN_KEYCHAIN_KEY];
    
    if (!SV_KEYCHAIN_DIC) {
        SV_KEYCHAIN_DIC = [[NSMutableDictionary alloc] init];
        [self save:SV_APP_IN_KEYCHAIN_KEY data:SV_KEYCHAIN_DIC];
    }
}


+ (id)loadValue:(NSString *)key{
    if (!sv_isStr(key)) {
        NSLog(@"key is nil when load key chain");
        return nil;
    }
    
    return SV_KEYCHAIN_DIC[key];
}

+ (void)saveValue:(id)data key:(NSString *)key{
    if (!sv_isStr(key)) {
        NSLog(@"key is nil when save key chain");
        return;
    }
    
    if (!data) {
        [self deleteValue:key];
        return;
    }
    
    SV_KEYCHAIN_DIC[key] = data;
    [self save:SV_APP_IN_KEYCHAIN_KEY data:SV_KEYCHAIN_DIC];
}

+ (void)deleteValue:(NSString *)key{
    if (!sv_isStr(key)) {
        NSLog(@"key is nil when save key chain");
        return;
    }
    
    [SV_KEYCHAIN_DIC removeObjectForKey:key];
    [self save:SV_APP_IN_KEYCHAIN_KEY data:SV_KEYCHAIN_DIC];
}

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge_transfer id)kSecClassGenericPassword,(__bridge_transfer id)kSecClass,
            service, (__bridge_transfer id)kSecAttrService,
            service, (__bridge_transfer id)kSecAttrAccount,
            (__bridge_transfer id)kSecAttrAccessibleAfterFirstUnlock,(__bridge_transfer id)kSecAttrAccessible,
            nil];
}

+ (void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge_transfer id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((__bridge_retained CFDictionaryRef)keychainQuery, NULL);
}

+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge_transfer id)kSecReturnData];
    [keychainQuery setObject:(__bridge_transfer id)kSecMatchLimitOne forKey:(__bridge_transfer id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge_retained CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge_transfer NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    return ret;
}

+ (void)delete:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
}

@end


