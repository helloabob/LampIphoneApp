//
//  DeviceConfigViewController.m
//  LampIphoneApp
//
//  Created by wangbo on 13-5-30.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import "DeviceConfigViewController.h"

#import "ConfigurationManager.h"

@interface DeviceConfigViewController ()

@end

@implementation DeviceConfigViewController

@synthesize txtName = _txtName;
@synthesize deviceName = _deviceName;

@synthesize txtIp = _txtIp;
@synthesize txtMac = _txtMac;
@synthesize lblType = _lblType;

- (void)dealloc {
    self.txtMac = nil;
    self.txtIp = nil;
    self.lblType = nil;
    self.deviceName = nil;
    self.txtName = nil;
    NSLog(@"device_config_dealoc");
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withLightName:(NSString *)lightName {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.deviceName = lightName;
    }
    return self;
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
    self.txtName.text = self.deviceName;
    
    NSDictionary *dict = [ConfigurationManager getLightInfoWithLightName:self.deviceName];
    
    self.lblType.text = [dict objectForKey:DeviceTypeKey];
    self.txtIp.text = [dict objectForKey:DeviceIpKey];
    
    self.txtIp.returnKeyType = UIReturnKeyDone;
    self.txtMac.returnKeyType = UIReturnKeyDone;
    self.txtIp.placeholder = @"Enter IP Address";
    self.txtMac.placeholder = @"Enter Mac Address";
    self.txtIp.delegate = self;
    self.txtMac.delegate = self;
    
    UIButton *btn = [UIButton buttonWithType:110];
    [btn setTitle:@"Save" forState:UIControlStateNormal];
    btn.frame = CGRectMake(40, 346, 100, 40);
    [btn addTarget:self action:@selector(btnSaveTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:110];
    [btn2 setTitle:@"Cancel" forState:UIControlStateNormal];
    btn2.frame = CGRectMake(190, 346, 100, 40);
    [btn2 addTarget:self action:@selector(btnCancelTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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
    NSArray *array = [ConfigurationManager objectForKey:DeviceUserDefaultKey];
    for (NSMutableDictionary *dict in array) {
        if ([[dict objectForKey:DeviceNameKey] isEqualToString:self.deviceName]) {
            [dict setObject:self.txtIp.text forKey:DeviceIpKey];
            [dict setObject:self.txtMac.text forKey:DeviceMacKey];
            break;
        }
    }
    [ConfigurationManager setObject:array forKey:DeviceUserDefaultKey];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
