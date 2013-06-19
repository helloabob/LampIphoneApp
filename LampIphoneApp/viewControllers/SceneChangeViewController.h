//
//  SceneChangeViewController.h
//  LampIphoneApp
//
//  Created by wangbo on 13-6-17.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SceneChangeViewController : UIViewController

- (IBAction)btnTapped:(id)sender;

@property (nonatomic, strong) IBOutlet UILabel *lblValue;

@property (nonatomic, strong) IBOutlet UIButton *btn3;
@property (nonatomic, strong) IBOutlet UIButton *btn4;
@property (nonatomic, strong) IBOutlet UIButton *btn5;
@property (nonatomic, strong) IBOutlet UIButton *btn6;

@end
