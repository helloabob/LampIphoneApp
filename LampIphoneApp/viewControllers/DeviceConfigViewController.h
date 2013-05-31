//
//  DeviceConfigViewController.h
//  LampIphoneApp
//
//  Created by wangbo on 13-5-30.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceConfigViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *txtName;

- (IBAction)btnSaveTapped:(id)sender;

- (IBAction)btnCancelTapped:(id)sender;

@end
