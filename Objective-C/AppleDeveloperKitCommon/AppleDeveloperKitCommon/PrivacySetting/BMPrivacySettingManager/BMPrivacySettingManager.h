//
//  BMPrivacySettingManager.h
//  BMBlueHouse
//
//  Created by BobWong on 2021/6/8.
//  Copyright © 2021 月亮小屋（中国）有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMPrivacySettingManager : NSObject

/** 获取位置定位权限 */
+ (BOOL)isLocationPermissionEnabled;

/** 获取相机权限 */
+ (BOOL)isCameraPermissionEnabled;
+ (void)requestCameraPermission:(void (^)(BOOL granted))handler;

/** 获取麦克风权限 */
+ (BOOL)isMicrophonePermissionEnabled;
+ (void)requestMicrophonePermission:(void (^)(BOOL granted))handler;

/** 获取相册权限 */
+ (BOOL)isAlbumPermissionEnabled;
+ (void)requestAlbumPermission:(void (^)(BOOL granted))handler;

/** 获取通讯录权限 */
//+ (BOOL)isContactsPermissionEnabled;
//+ (void)requestContactPermission:(void (^)(BOOL granted))handler;

/** 打开系统设置 */
+ (void)openSettings;

@end

NS_ASSUME_NONNULL_END
