//
//  OfficeDetailViewController.m
//  LampIphoneApp
//
//  Created by wangbo on 13-5-27.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import "OfficeDetailViewController.h"

#import "ConfigurationManager.h"

#import "CoAPSocketUtils.h"

@interface OfficeDetailViewController () {
    int lightIndex;
    int lastDimmingValue;
}

@end

static BOOL isOn;

@implementation OfficeDetailViewController

@synthesize lblDevice = _lblDevice;
@synthesize lblPower = _lblPower;
@synthesize roomIndex = _roomIndex;

- (void)dealloc {
    self.lblPower = nil;
    self.lblDevice = nil;
    self.lightArray = nil;
    self.sliDimming = nil;
    NSLog(@"detail_dealloc");
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
    NSArray *array = [[[ConfigurationManager objectForKey:OfficeUserDefaultKey] objectAtIndex:self.roomIndex] objectForKey:OfficeDeviceNameKey];
    NSArray *devices = [ConfigurationManager objectForKey:DeviceUserDefaultKey];
    
    self.lightArray = [NSMutableArray array];
    for (NSString *lightName in array) {
        for (NSDictionary *dict in devices) {
            if ([lightName isEqualToString:[dict objectForKey:DeviceNameKey]]) {
                [self.lightArray addObject:dict];
                break;
            }
        }
    }
    [self.sliDimming addTarget:self action:@selector(dimmingChanged:) forControlEvents:UIControlEventValueChanged];
    lastDimmingValue = 110;
}

- (void)dimmingChanged:(id)sender {
    NSLog(@"dimming:%f",self.sliDimming.value);
    
    int value = self.sliDimming.value;
    lastDimmingValue = value;
    if (value == 0) {
        TurnOnOff(@"false", ip_addr);
//        [ConfigurationManager updateLastTurnOnTimeInterval:NO forLightName:self.title];
        isOn = NO;
    } else {
        if (!isOn) {
            TurnOnOff(@"true", ip_addr);
//            [ConfigurationManager updateLastTurnOnTimeInterval:YES forLightName:self.title];
            isOn = YES;
        }
        ChangeDimmingValue(value, ip_addr);
//        [ConfigurationManager changeLightDimming:[NSNumber numberWithInt:value] forLightName:self.title];
    }
    [self updateInfo];
    
    //todo to prevent change dimming value too fast
//    int currentDimmingValue = self.sliDimming.value;
//    if (currentDimmingValue - lastDimmingValue >= 10) {
//        
//    }
//    CoAPSocketUtils sendSocket:<#(const char *)#> withIP:<#(const char *)#>
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateInfo {
    self.lblDimming.text = [NSString stringWithFormat:@"%d",lastDimmingValue];
    self.lblPower.text = [NSString stringWithFormat:@"%.2f(w)",CalculatePowerRate(lastDimmingValue)];
    
}

- (IBAction)lightButtonTapped:(id)sender {
    UIButton *btn = (UIButton *)sender;
    lightIndex = btn.tag - 1;
    self.lblDevice.text = [[self.lightArray objectAtIndex:lightIndex] objectForKey:DeviceNameKey];
    CGFloat dimming = [[[self.lightArray objectAtIndex:lightIndex] objectForKey:DimmingLevelKey] doubleValue];
    self.lblPower.text = [NSString stringWithFormat:@"%.2f(w)",CalculatePowerRate(dimming)];
    self.lblDimming.text = [NSString stringWithFormat:@"%d",(int)dimming];
}

@end
