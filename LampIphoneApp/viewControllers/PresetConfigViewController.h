//
//  PresetConfigViewController.h
//  LampIphoneApp
//
//  Created by wangbo on 13-6-6.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PresetConfigViewController : UIViewController

@property (nonatomic, strong) IBOutlet UISlider *slider1;
@property (nonatomic, strong) IBOutlet UISlider *slider2;
@property (nonatomic, strong) IBOutlet UISlider *slider3;
@property (nonatomic, strong) IBOutlet UISlider *slider4;

@property (nonatomic, strong) NSMutableDictionary *ip_dict;


@end
