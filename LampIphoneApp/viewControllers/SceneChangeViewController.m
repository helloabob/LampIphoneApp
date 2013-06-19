//
//  SceneChangeViewController.m
//  LampIphoneApp
//
//  Created by wangbo on 13-6-17.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import "SceneChangeViewController.h"

#import "VolumeBar.h"

#import "SystemManagerViewController.h"

#import "ConfigurationManager.h"

#import "CoAPSocketUtils.h"

#import <QuartzCore/QuartzCore.h>

static BOOL isOn = YES;

@interface SceneChangeViewController () {
    VolumeBar *volbar;
}

@end

@implementation SceneChangeViewController

@synthesize btn3 = _btn3;
@synthesize btn4 = _btn4;
@synthesize btn5 = _btn5;
@synthesize btn6 = _btn6;

@synthesize lblValue = _lblValue;

- (void)dealloc {
    NSLog(@"SceneChangeViewController_dealloc");
    isOn = YES;
    self.lblValue = nil;
    self.btn3 = nil;
    self.btn4 = nil;
    self.btn5 = nil;
    self.btn6 = nil;
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSArray *presets = [ConfigurationManager objectForKey:PresetUserDefaultKey];
    
    [self.btn3 setTitle:[[presets objectAtIndex:0] objectForKey:PresetLabelNameKey] forState:UIControlStateNormal];
    [self.btn4 setTitle:[[presets objectAtIndex:1] objectForKey:PresetLabelNameKey] forState:UIControlStateNormal];
    [self.btn5 setTitle:[[presets objectAtIndex:2] objectForKey:PresetLabelNameKey] forState:UIControlStateNormal];
    [self.btn6 setTitle:[[presets objectAtIndex:3] objectForKey:PresetLabelNameKey] forState:UIControlStateNormal];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)updateControllerState:(BOOL)selected {
//    btnEnabled.selected = selected;
    if (!selected) {
//        self.sli.enabled = YES;
        volbar.enabled = NO;
        volbar.alpha = 0.5f;
        self.btn3.enabled = NO;
        self.btn4.enabled = NO;
        self.btn5.enabled = NO;
        self.btn6.enabled = NO;
//        self.buttonMaskView.hidden = NO;
//        self.sliderMaskView.hidden = YES;
    } else {
//        self.sli.enabled = NO;
        volbar.enabled = YES;
        volbar.alpha = 1.0f;
        self.btn3.enabled = YES;
        self.btn4.enabled = YES;
        self.btn5.enabled = YES;
        self.btn6.enabled = YES;
//        self.buttonMaskView.hidden = YES;
//        self.sliderMaskView.hidden = NO;
    }
}

- (IBAction)btnTapped:(id)sender {
    //    [[CoAPSocket sharedInstance] openUDPServer];
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 111: {
            if (isOn) {
                NSArray *array = [ConfigurationManager getLightsInfoWithOfficeName:[Common currentOfficeName]];
                for (NSDictionary *dict in array) {
                    TurnOnOff(@"false", [dict objectForKey:DeviceIpKey]);
                }
            } else {
                NSArray *array = [ConfigurationManager getLightsInfoWithOfficeName:[Common currentOfficeName]];
                for (NSDictionary *dict in array) {
                    TurnOnOff(@"true", [dict objectForKey:DeviceIpKey]);
                }
                //            [CoAPSocketUtils sendSocket:"{\"o\":true}" withIP:ip_addr];
            }
            isOn = !isOn;
            [btn setSelected:!isOn];
            [self updateControllerState:isOn];
        }
            break;
        case 110: {
        }
            break;
        case 141: {
//            [self updateControllerState:NO];
            NSArray *array = [ConfigurationManager getLightsInfoWithPresetName:@"preset1"];
            for (NSDictionary *dict in array) {
                ChangeDimmingValue([[dict objectForKey:DimmingLevelKey] intValue], [dict objectForKey:DeviceIpKey]);
            }
        }
            //            [CoAPSocketUtils sendSocket:"{\"b\":55}" withIP:ip_addr];
            break;
        case 142: {
//            [self updateControllerState:NO];
            NSArray *array = [ConfigurationManager getLightsInfoWithPresetName:@"preset2"];
            for (NSDictionary *dict in array) {
                ChangeDimmingValue([[dict objectForKey:DimmingLevelKey] intValue], [dict objectForKey:DeviceIpKey]);
            }
        }
            //            ChangeDimmingValue(110, ip_addr);
            //            [CoAPSocketUtils sendSocket:"{\"b\":110}" withIP:ip_addr];
            break;
        case 143: {
//            [self updateControllerState:NO];
            NSArray *array = [ConfigurationManager getLightsInfoWithPresetName:@"preset3"];
            for (NSDictionary *dict in array) {
                ChangeDimmingValue([[dict objectForKey:DimmingLevelKey] intValue], [dict objectForKey:DeviceIpKey]);
            }
        }
            //            ChangeDimmingValue(165, ip_addr);
            //            [CoAPSocketUtils sendSocket:"{\"b\":165}" withIP:ip_addr];
            break;
        case 144: {
//            [self updateControllerState:NO];
            NSArray *array = [ConfigurationManager getLightsInfoWithPresetName:@"preset4"];
            for (NSDictionary *dict in array) {
                ChangeDimmingValue([[dict objectForKey:DimmingLevelKey] intValue], [dict objectForKey:DeviceIpKey]);
            }
        }
            //            ChangeDimmingValue(220, ip_addr);
            //            [CoAPSocketUtils sendSocket:"{\"b\":220}" withIP:ip_addr];
            break;
        default:
            break;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = app_default_background_color;
    self.title = @"PHILIPS";
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setImage:[UIImage imageNamed:@"power_on"] forState:UIControlStateNormal];
//    [btn setImage:[UIImage imageNamed:@"power_off"] forState:UIControlStateSelected];
//    btn.frame = CGRectMake(0, 0, 60, 60);
//    btn.center = CGPointMake(self.view.center.x, self.view.bounds.size.height - 70);
//    btn.tag = 111;
//    [btn addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
    [self.btn3 setTitleColor:app_philips_color forState:UIControlStateNormal];
    [self.btn4 setTitleColor:app_philips_color forState:UIControlStateNormal];
    [self.btn5 setTitleColor:app_philips_color forState:UIControlStateNormal];
    [self.btn6 setTitleColor:app_philips_color forState:UIControlStateNormal];
    
    UIImageView *backView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"WallPaper1"]];
    [self.view addSubview:backView];
    [self.view sendSubviewToBack:backView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor whiteColor]];
    btn.frame = CGRectMake(0, 0, 245, 40);
    [btn setTitleColor:app_philips_color forState:UIControlStateNormal];
    [btn setTitle:@"ON / OFF" forState:UIControlStateNormal];
    [btn.titleLabel setFont:app_philips_label_font_size];
    btn.layer.cornerRadius = 10.0f;
    btn.center = CGPointMake(self.view.center.x, self.view.bounds.size.height - 70);
    btn.tag = 111;
    [btn addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [self.lblValue setTextColor:app_philips_color];
    
    VolumeBar *vol = [[VolumeBar alloc] initWithFrame:CGRectMake(74, 81, 173, 173) minimumVolume:0 maximumVolume:220];
    [vol addTarget:self action:@selector(onBarChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:vol];
    volbar = vol;
    
    self.lblValue.center = CGPointMake(vol.center.x, vol.center.y + 5);
    self.lblValue.backgroundColor = [UIColor clearColor];
    [self.lblValue setFont:app_philips_label_font_size];
    [self.view bringSubviewToFront:self.lblValue];
    
    UIButton *btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnRight setImage:[UIImage imageNamed:@"settings"] forState:UIControlStateNormal];
    btnRight.frame = CGRectMake(0, 0, 30, 30);
    [btnRight addTarget:self action:@selector(gotoSettingView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btnRight];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)gotoSettingView {
    SystemManagerViewController *presetViewController = [[SystemManagerViewController alloc] init];
    [self.navigationController pushViewController:presetViewController animated:YES];
    [presetViewController release];
    //    if (!systemController) {
    //        systemController = [[SystemManagerViewController alloc] init];
    //    }
    //    [self.navigationController pushViewController:systemController animated:YES];
}

- (void)onBarChanged:(VolumeBar *)sender {
    float tmp = (float)sender.currentVolume / 220.0f;
    int result = tmp * 100;
    self.lblValue.text = [NSString stringWithFormat:@"%d%%",result];
    
    int value = sender.currentVolume;
    NSArray *array = [ConfigurationManager getLightsInfoWithOfficeName:[Common currentOfficeName]];
    for (NSDictionary *dict in array) {
        ChangeDimmingValue(value, [dict objectForKey:DeviceIpKey]);
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
