//
//  DeviceConfigViewController.h
//  LampIphoneApp
//
//  Created by wangbo on 13-5-30.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceConfigViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *txtName;

@property (strong, nonatomic) IBOutlet UILabel *lblType;

@property (strong, nonatomic) IBOutlet UITextField *txtIp;

@property (strong, nonatomic) IBOutlet UITextField *txtMac;

@property (strong, nonatomic) NSString *deviceName;

- (IBAction)btnSaveTapped:(id)sender;

- (IBAction)btnCancelTapped:(id)sender;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withLightName:(NSString *)lightName;

- (IBAction)btnCheckTapped:(id)sender;

@end
