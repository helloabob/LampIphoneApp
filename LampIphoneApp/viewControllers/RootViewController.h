//
//  RootViewController.h
//  LampIphoneApp
//
//  Created by wangbo on 13-5-27.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OfficeDetailInfoView.h"

@interface RootViewController : UIViewController<OfficeDetailInfoViewDelegate>

- (IBAction)btnTapped:(id)sender;

@property (strong, nonatomic) NSArray *lights;

@property (strong, nonatomic) IBOutlet UIView *buttonMaskView;
@property (strong, nonatomic) IBOutlet UIView *sliderMaskView;

//@property (strong, nonatomic) IBOutlet UIButton *btn1;
//@property (strong, nonatomic) IBOutlet UIButton *btn2;
@property (strong, nonatomic) IBOutlet UIButton *btn3;
@property (strong, nonatomic) IBOutlet UIButton *btn4;
@property (strong, nonatomic) IBOutlet UIButton *btn5;
@property (strong, nonatomic) IBOutlet UIButton *btn6;

@property (strong, nonatomic) UIButton *btnPreset1;
@property (strong, nonatomic) UIButton *btnPreset2;
@property (strong, nonatomic) UIButton *btnPreset3;
@property (strong, nonatomic) UIButton *btnPreset4;

@property (strong, nonatomic) IBOutlet UISlider *sli;

@end
