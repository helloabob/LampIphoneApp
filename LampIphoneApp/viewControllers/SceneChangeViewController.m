//
//  SceneChangeViewController.m
//  LampIphoneApp
//
//  Created by wangbo on 13-6-17.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import "SceneChangeViewController.h"

#import "VolumeBar.h"

@interface SceneChangeViewController ()

@end

@implementation SceneChangeViewController

@synthesize lblValue = _lblValue;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = app_default_background_color;
    
    UIButton *btn = [UIButton buttonWithType:110];
    btn.frame = CGRectMake(0, 0, 260, 40);
    [btn setTitle:@"ON/OFF" forState:UIControlStateNormal];
    btn.center = CGPointMake(self.view.center.x, self.view.bounds.size.height - 70);
    [self.view addSubview:btn];
    
    VolumeBar *vol = [[VolumeBar alloc] initWithFrame:CGRectMake(104, 111, 113, 113) minimumVolume:0 maximumVolume:220];
    [vol addTarget:self action:@selector(onBarChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:vol];
    
}

- (void)onBarChanged:(VolumeBar *)sender {
//    NSLog(@"result:%d",sender.currentVolume);
    self.lblValue.text = [NSString stringWithFormat:@"Dimming:%d",sender.currentVolume];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
