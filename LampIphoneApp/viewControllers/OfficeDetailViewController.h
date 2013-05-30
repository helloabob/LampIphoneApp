//
//  OfficeDetailViewController.h
//  LampIphoneApp
//
//  Created by wangbo on 13-5-27.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OfficeDetailViewController : UIViewController

- (IBAction)lightButtonTapped:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *lblDevice;
@property (strong, nonatomic) IBOutlet UILabel *lblPower;


@end
