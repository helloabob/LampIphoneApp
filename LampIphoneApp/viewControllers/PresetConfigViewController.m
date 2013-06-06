//
//  PresetConfigViewController.m
//  LampIphoneApp
//
//  Created by wangbo on 13-6-6.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import "PresetConfigViewController.h"

#import "ConfigurationManager.h"

#import "MBProgressHUD.h"

@interface PresetConfigViewController ()

@end

@implementation PresetConfigViewController

@synthesize slider1 = _slider1;
@synthesize slider2 = _slider2;
@synthesize slider3 = _slider3;
@synthesize slider4 = _slider4;

- (void)dealloc {
    self.slider4 = nil;
    self.slider3 = nil;
    self.slider2 = nil;
    self.slider1 = nil;
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
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = app_default_background_color;
    
    UIButton *btn = [UIButton buttonWithType:110];
    [btn setTitle:@"Save" forState:UIControlStateNormal];
    btn.frame = CGRectMake(40, 350, 100, 35);
    [btn addTarget:self action:@selector(btnSaveTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    btn = [UIButton buttonWithType:110];
    [btn setTitle:@"Cancel" forState:UIControlStateNormal];
    btn.frame = CGRectMake(180, 350, 100, 35);
    [btn addTarget:self action:@selector(btnCancelTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    NSArray *array = [ConfigurationManager objectForKey:PresetUserDefaultKey];
    NSArray *dict = nil;
    for (NSDictionary *tmp in array) {
        if ([[tmp objectForKey:PresetNameKey] isEqualToString:self.title]) {
            dict = [tmp objectForKey:PresetDeviceNameKey];
            break;
        }
    }
    for (NSString *presetInfo in dict) {
        NSArray *tmpArray = [presetInfo componentsSeparatedByString:@":"];
        NSString *lightName = [tmpArray objectAtIndex:0];
        int lightDimming = [[tmpArray objectAtIndex:1] intValue];
        if ([lightName isEqualToString:@"light0"]) {
            self.slider1.value = lightDimming;
        } else if ([lightName isEqualToString:@"light1"]) {
            self.slider2.value = lightDimming;
        } else if ([lightName isEqualToString:@"light2"]) {
            self.slider3.value = lightDimming;
        } else if ([lightName isEqualToString:@"light3"]) {
            self.slider4.value = lightDimming;
        }
    }
//    [dict release];
}

- (void)btnSaveTapped {
    NSArray *array = [ConfigurationManager objectForKey:PresetUserDefaultKey];
    NSMutableArray *dict = nil;
    for (NSDictionary *tmp in array) {
        if ([[tmp objectForKey:PresetNameKey] isEqualToString:self.title]) {
            dict = [tmp objectForKey:PresetDeviceNameKey];
            break;
        }
    }
    [dict removeAllObjects];
    [dict addObject:[NSString stringWithFormat:@"light0:%d",(int)self.slider1.value]];
    [dict addObject:[NSString stringWithFormat:@"light1:%d",(int)self.slider2.value]];
    [dict addObject:[NSString stringWithFormat:@"light2:%d",(int)self.slider3.value]];
    [dict addObject:[NSString stringWithFormat:@"light3:%d",(int)self.slider4.value]];
//    [dict release];
    [ConfigurationManager setObject:array forKey:PresetUserDefaultKey];
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    hud.labelText = @"Saving...";
    [self.navigationController.view addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:1.0f];
//    [hud removeFromSuperview];
//    [hud release];
//    hud = nil;
    
//    [self.navigationController popViewControllerAnimated:YES];
}

- (void)btnCancelTapped {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
