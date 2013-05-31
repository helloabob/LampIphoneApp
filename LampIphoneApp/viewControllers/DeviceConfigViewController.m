//
//  DeviceConfigViewController.m
//  LampIphoneApp
//
//  Created by wangbo on 13-5-30.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import "DeviceConfigViewController.h"

@interface DeviceConfigViewController ()

@end

@implementation DeviceConfigViewController

@synthesize txtName = _txtName;

- (void)dealloc {
    self.txtName = nil;
    NSLog(@"device_config_dealoc");
    [super dealloc];
}

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
    self.view.backgroundColor = app_default_background_color;
    // Do any additional setup after loading the view from its nib.
//    self.title = @"Device Config";
//    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(tt) userInfo:nil repeats:NO];
    NSLog(@"title:%@",self.title);
    if (self.title) {
        self.txtName.enabled = NO;
    }
}

- (void)tt {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnCancelTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnSaveTapped:(id)sender {
    
}

@end
