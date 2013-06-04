//
//  OfficeDetailViewController.h
//  LampIphoneApp
//
//  Created by wangbo on 13-5-27.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OfficeDetailViewController : UIViewController {
}



- (IBAction)lightButtonTapped:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btn1;
@property (strong, nonatomic) IBOutlet UIButton *btn2;
@property (strong, nonatomic) IBOutlet UIButton *btn3;
@property (strong, nonatomic) IBOutlet UIButton *btn4;


@property (strong, nonatomic) IBOutlet UILabel *lblDevice;
@property (strong, nonatomic) IBOutlet UILabel *lblPower;
@property (strong, nonatomic) IBOutlet UILabel *lblDimming;
@property (strong, nonatomic) IBOutlet UILabel *lblRunningTime;

@property (strong, nonatomic) IBOutlet UISlider *sliDimming;

@property (strong, nonatomic) NSMutableArray *lightArray;

@property (assign, nonatomic) int roomIndex;


@end
