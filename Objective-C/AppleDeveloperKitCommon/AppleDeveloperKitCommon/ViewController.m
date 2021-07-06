//
//  ViewController.m
//  AppleDeveloperKitCommon
//
//  Created by BobWong on 2021/7/6.
//

#import "ViewController.h"
#import "BMPrivacySettingViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)toPrivacySetting:(id)sender {
    BMPrivacySettingViewController *viewController = [BMPrivacySettingViewController new];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
