//
//  BMPrivacySettingManager.m
//  BMBlueHouse
//
//  Created by BobWong on 2021/6/8.
//  Copyright © 2021 月亮小屋（中国）有限公司. All rights reserved.
//

#import "BMPrivacySettingManager.h"
#import <Contacts/CNContactStore.h>
#import <Photos/PHPhotoLibrary.h>

@implementation BMPrivacySettingManager

+ (BOOL)isLocationPermissionEnabled {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        return YES;  // Access
    }
    return NO;  // No access or location services are not enabled
}

#pragma mark - 相机

+ (BOOL)isCameraPermissionEnabled {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    return (status == AVAuthorizationStatusAuthorized);
}

+ (void)requestCameraPermission:(void (^)(BOOL granted))handler {
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        if (handler) handler(granted);
    }];
}

#pragma mark - 麦克风

+ (BOOL)isMicrophonePermissionEnabled {
//    AVAudioSessionRecordPermission permission = [[AVAudioSession sharedInstance] recordPermission];
//    return (permission == AVAudioSessionRecordPermissionGranted);
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    return (status == AVAuthorizationStatusAuthorized);
}

+ (void)requestMicrophonePermission:(void (^)(BOOL granted))handler {
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
        if (handler) handler(granted);
    }];
}

#pragma mark - 相册

+ (BOOL)isAlbumPermissionEnabled {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    return (status == PHAuthorizationStatusAuthorized);
}

+ (void)requestAlbumPermission:(void (^)(BOOL granted))handler {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        BOOL granted = (status == PHAuthorizationStatusAuthorized);
        if (handler) handler(granted);
    }];
}

#pragma mark - 通讯录

//+ (BOOL)isContactsPermissionEnabled {
//    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
//    return (status == CNAuthorizationStatusAuthorized);
//}
//
//+ (void)requestContactPermission:(void (^)(BOOL granted))handler {
//    let addressBook: ABAddressBook = ABAddressBookCreateWithOptions(nil, nil) as ABAddressBook
//    ABAddressBookRequestAccessWithCompletion(addressBook) { (granted: Bool, error: CFError?) in
//        if !granted {
//            print("未获得通讯录访问权限")
//            return
//        }
//        print("获得通讯录权限")
//    }
//}

#pragma mark - 设置跳转

+ (void)openSettings {
    [UIApplication.sharedApplication openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
}

@end
