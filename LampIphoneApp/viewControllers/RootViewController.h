//
//  RootViewController.h
//  LampIphoneApp
//
//  Created by wangbo on 13-5-27.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController

- (IBAction)btnTapped:(id)sender;

@property (strong, nonatomic) NSArray *lights;

@property (strong, nonatomic) UIButton *btn1;
@property (strong, nonatomic) UIButton *btn2;
@property (strong, nonatomic) UIButton *btn3;
@property (strong, nonatomic) UIButton *btn4;
@property (strong, nonatomic) UIButton *btn5;
@property (strong, nonatomic) UIButton *btn6;

@property (strong, nonatomic) IBOutlet UISlider *sli;

@end
