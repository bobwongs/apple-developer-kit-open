//
//  BMPrivacySettingViewController.m
//  BMBlueHouse
//
//  Created by BobWong on 2021/6/7.
//  Copyright © 2021 月亮小屋（中国）有限公司. All rights reserved.
//

#import "BMPrivacySettingViewController.h"
#import "BMPrivacySettingManager.h"

#define BM_TO_SETTING_TEXT @"去设置"
#define BM_OPNED_TEXT @"已开启"

@interface BMPrivacySettingViewController ()

@property (weak, nonatomic) IBOutlet UILabel *locationPrivacyContentLabel;  ///< 位置定位
@property (weak, nonatomic) IBOutlet UILabel *cameraPrivacyContentLabel;  ///< 相机
@property (weak, nonatomic) IBOutlet UILabel *audioPrivacyContentLabel;  ///< 音频
@property (weak, nonatomic) IBOutlet UILabel *photoPrivacyContentLabel;  ///< 相册

@end

@implementation BMPrivacySettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"隐私设置";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkPrivacySetting) name:UIApplicationWillEnterForegroundNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkPrivacySetting) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self checkPrivacySetting];
}

- (void)checkPrivacySetting {
    @weakify(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        @strongify(self)
        self.locationPrivacyContentLabel.text = BMPrivacySettingManager.isLocationPermissionEnabled ? BM_OPNED_TEXT : BM_TO_SETTING_TEXT;
        self.cameraPrivacyContentLabel.text = BMPrivacySettingManager.isCameraPermissionEnabled ? BM_OPNED_TEXT : BM_TO_SETTING_TEXT;
        self.audioPrivacyContentLabel.text = BMPrivacySettingManager.isMicrophonePermissionEnabled ? BM_OPNED_TEXT : BM_TO_SETTING_TEXT;
        self.photoPrivacyContentLabel.text = BMPrivacySettingManager.isAlbumPermissionEnabled ? BM_OPNED_TEXT : BM_TO_SETTING_TEXT;
    });
}

#pragma mark - Action

- (IBAction)toLocationPrivacySetting:(id)sender {
    [BMPrivacySettingManager openSettings];
}

- (IBAction)toCameraPrivacySetting:(id)sender {
    if (BMPrivacySettingManager.isCameraPermissionEnabled) {
        [BMPrivacySettingManager openSettings];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    [BMPrivacySettingManager requestCameraPermission:^(BOOL granted) {
        [weakSelf selectGrantedState:granted];
    }];
}

- (IBAction)toMicrophonePrivacySetting:(id)sender {
    if (BMPrivacySettingManager.isMicrophonePermissionEnabled) {
        [BMPrivacySettingManager openSettings];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    [BMPrivacySettingManager requestMicrophonePermission:^(BOOL granted) {
        [weakSelf selectGrantedState:granted];
    }];
}

- (IBAction)toAlbumPrivacySetting:(id)sender {
    if (BMPrivacySettingManager.isAlbumPermissionEnabled) {
        [BMPrivacySettingManager openSettings];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    [BMPrivacySettingManager requestAlbumPermission:^(BOOL granted) {
        [weakSelf selectGrantedState:granted];
    }];
}

- (void)selectGrantedState:(BOOL)granted {
    [self checkPrivacySetting];
    if (!granted) [BMPrivacySettingManager openSettings];
}

@end
