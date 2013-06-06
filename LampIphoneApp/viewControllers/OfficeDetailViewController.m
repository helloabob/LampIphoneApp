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

#import "AppDelegate.h"

#import "DeviceConfigViewController.h"

#import "MBProgressHUD.h"

#import "CoAPProcessOperation.h"

#import "JSON.h"

@interface OfficeDetailViewController () {
    int lightIndex;
    int lastDimmingValue;
    NSString *cur_ip;
//    NSOperationQueue *queue;
}

@end

static BOOL isOn;

@implementation OfficeDetailViewController

@synthesize lblDevice = _lblDevice;
@synthesize lblPower = _lblPower;
@synthesize roomIndex = _roomIndex;

@synthesize toolbar = _toolbar;

- (void)dealloc {
    self.lblPower = nil;
    self.lblDevice = nil;
    self.lightArray = nil;
    self.sliDimming = nil;
    self.btn1 = nil;
    self.btn2 = nil;
    self.btn3 = nil;
    self.btn4 = nil;
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

- (void)getLightInfo {
    self.title = @"PHILIPS";
    self.lightArray = [NSMutableArray arrayWithArray:[ConfigurationManager getLightsInfoWithOfficeName:[Common currentOfficeName]]];
    
//    NSArray *array = [[[ConfigurationManager objectForKey:OfficeUserDefaultKey] objectAtIndex:self.roomIndex] objectForKey:OfficeDeviceNameKey];
//    NSArray *devices = [ConfigurationManager objectForKey:DeviceUserDefaultKey];
//    self.lightArray = [NSMutableArray array];
//    for (NSString *lightName in array) {
//        for (NSDictionary *dict in devices) {
//            if ([lightName isEqualToString:[dict objectForKey:DeviceNameKey]]) {
//                [self.lightArray addObject:dict];
//                break;
//            }
//        }
//    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = app_default_background_color;
    
    [self.btn1 setImage:[UIImage imageNamed:@"light_icon_selected"] forState:UIControlStateSelected];
    [self.btn2 setImage:[UIImage imageNamed:@"light_icon_selected"] forState:UIControlStateSelected];
    [self.btn3 setImage:[UIImage imageNamed:@"light_icon_selected"] forState:UIControlStateSelected];
    [self.btn4 setImage:[UIImage imageNamed:@"light_icon_selected"] forState:UIControlStateSelected];
    
    self.toolbar.tintColor = app_philips_color;
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"settings" style:UIBarButtonItemStyleDone target:self action:@selector(gotoSetting)];
    
//    UIButton *btnWifi = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btnWifi setImage:[UIImage imageNamed:@"wifi"] forState:UIControlStateNormal];
//    [btnWifi setFrame:CGRectMake(0, 0, 30, 30)];
//    [btnWifi addTarget:self action:@selector(gotoChecking) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:btnWifi];
//    item1.width = 100.0;
    
    UIButton *btnSetting = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSetting setImage:[UIImage imageNamed:@"settings"] forState:UIControlStateNormal];
    [btnSetting setFrame:CGRectMake(0, 0, 30, 30)];
    [btnSetting addTarget:self action:@selector(gotoSetting) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btnSetting];
    [self.toolbar setItems:[NSArray arrayWithObjects:item, nil]];
    
    UIButton *btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnRight setImage:[UIImage imageNamed:@"wifi"] forState:UIControlStateNormal];
    btnRight.frame = CGRectMake(0, 0, 30, 30);
    [btnRight addTarget:self action:@selector(gotoChecking) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btnRight];
    self.navigationItem.rightBarButtonItem = rightItem;
    
//    UIButton *btn = [UIButton buttonWithType:110];
//    [btn setTitle:@"Setting" forState:UIControlStateNormal];
//    btn.frame = CGRectMake(20, 353, 100, 40);
//    [btn addTarget:self action:@selector(gotoSetting) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
    
    [self getLightInfo];
    
    lightIndex = -1;
    cur_ip = @"";
    
//    [self.sliDimming addTarget:self action:@selector(dimmingChanged:) forControlEvents:UIControlEventValueChanged];
    [self.sliDimming addTarget:self action:@selector(dimmingChanged:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside];
    self.sliDimming.enabled = NO;
    lastDimmingValue = 110;
}

- (void)gotoChecking {
//    UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height - 44)];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
//    [vv release];
//    vv = nil;
//    [hud setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height - 44)];
    NSLog(@"view:%@",self.navigationController.view);
//    [self.view addSubview:hud];
    [self.navigationController.view addSubview:hud];
//    [[[UIApplication sharedApplication] keyWindow] addSubview:hud];
//    hud.center = CGPointMake(hud.center.x, hud.center.y - 50);
    [hud release];
//    [[[UIApplication sharedApplication] keyWindow] addSubview:hud];
    hud.dimBackground = YES;
    hud.labelText = @"Pairing...";
    [hud show:YES];
    
//    sleep(3);
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSLog(@"operation_count:%d",queue.operationCount);
    [queue setMaxConcurrentOperationCount:8];
    NSArray *arrayips = [NSArray arrayWithObjects:@"192.168.1.138",@"192.168.1.140",@"192.168.1.142",@"192.168.1.149", nil];
//    for (int i = 30; i < 65; i ++) {
//        CoAPProcessOperation *op = [[CoAPProcessOperation alloc] init];
//        op.theIP = [NSString stringWithFormat:@"192.168.11.%d",i];
//        [queue addOperation:op];
//        [op release];
//    }
    for (NSString *tmpip in arrayips) {
        CoAPProcessOperation *op = [[CoAPProcessOperation alloc] init];
        op.theIP = tmpip;
        [queue addOperation:op];
        [op release];
    }
//    [CoAPSocketUtils checkSocketWithIp:"192.168.11.61"];
    NSArray *array = [NSArray arrayWithObjects:hud, queue, nil];
    [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(checkComplete:) userInfo:array repeats:NO];
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
}

- (void)checkComplete:(NSTimer *)timer {
    NSArray *array = [timer userInfo];
    
    NSOperationQueue *quee = [array objectAtIndex:1];
    [quee cancelAllOperations];
    [quee release];
    quee = nil;    
    
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    
    MBProgressHUD *hud = [array objectAtIndex:0];
    [hud hide:YES];
    [hud release];
    hud = nil;
}

- (void)gotoSetting {
    
    if ([self.lblDevice.text isEqualToString:@""] || [self.lblDevice.text isEqualToString: @"Null"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please select a light ." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    DeviceConfigViewController *detailViewController = [[DeviceConfigViewController alloc] initWithNibName:@"DeviceConfigViewController" bundle:nil withLightName:self.lblDevice.text];
    [self presentViewController:detailViewController animated:YES completion:nil];
//    detailViewController.title = [[self.arrayMenu objectAtIndex:indexPath.row] objectForKey:OfficeNameKey];
//    detailViewController.roomIndex = indexPath.row;
    // ...
    // Pass the selected object to the new view controller.
//    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    
    
}

- (void)dimmingChanged:(id)sender {
    NSLog(@"dimming:%f",self.sliDimming.value);
    
    int value = self.sliDimming.value;
    lastDimmingValue = value;
    if (value == 0) {
        TurnOnOff(@"false", cur_ip);
//        [ConfigurationManager updateLastTurnOnTimeInterval:NO forLightName:self.title];
        isOn = NO;
    } else {
        if (!isOn) {
            TurnOnOff(@"true", cur_ip);
//            [ConfigurationManager updateLastTurnOnTimeInterval:YES forLightName:self.title];
            isOn = YES;
        }
        ChangeDimmingValue(value, cur_ip);
//        [ConfigurationManager changeLightDimming:[NSNumber numberWithInt:value] forLightName:self.title];
    }
    [self updateViewText];
    
    //todo to prevent change dimming value too fast
//    int currentDimmingValue = self.sliDimming.value;
//    if (currentDimmingValue - lastDimmingValue >= 10) {
//        
//    }
//    CoAPSocketUtils sendSocket:<#(const char *)#> withIP:<#(const char *)#>
}

- (void)viewWillDisappear:(BOOL)animated {
    [ConfigurationManager changeLightDimming:[NSNumber numberWithInt:lastDimmingValue] forLightName:self.lblDevice.text];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewText {
    self.lblDimming.text = [NSString stringWithFormat:@"%d%%",(int)(lastDimmingValue/MaxDimmingLevel*100)];
//    self.lblDimming.text = [NSString stringWithFormat:@"%d",lastDimmingValue];
    self.lblPower.text = [NSString stringWithFormat:@"%.2f(w)",CalculatePowerRate(lastDimmingValue)];
}

- (IBAction)lightButtonTapped:(id)sender {
    
    self.sliDimming.enabled = YES;
    UIButton *btn = (UIButton *)sender;
    if (self.lightArray.count < btn.tag) {
        return;
    }
    
    [self.btn1 setSelected:NO];
    [self.btn2 setSelected:NO];
    [self.btn3 setSelected:NO];
    [self.btn4 setSelected:NO];
    [btn setSelected:YES];
    
    if (lightIndex != -1 && lightIndex != btn.tag - 1) {
        [ConfigurationManager changeLightDimming:[NSNumber numberWithInt:lastDimmingValue] forLightName:self.lblDevice.text];
    }
    
//    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
//    hud.labelText = @"Loading...";
//    hud.dimBackground = YES;
//    [self.navigationController.view addSubview:hud];
//    [hud show:YES];
    
    lightIndex = btn.tag - 1;
    [self getLightInfo];
    
    self.lblDevice.text = [[self.lightArray objectAtIndex:lightIndex] objectForKey:DeviceNameKey];
    CGFloat dimming = [[[self.lightArray objectAtIndex:lightIndex] objectForKey:DimmingLevelKey] doubleValue];
    self.lblPower.text = [NSString stringWithFormat:@"%.2f(w)",CalculatePowerRate(dimming)];
//    self.lblDimming.text = [NSString stringWithFormat:@"%d",(int)dimming];
    self.lblDimming.text = [NSString stringWithFormat:@"%d%%",(int)(dimming/MaxDimmingLevel*100)];
    self.sliDimming.value = dimming;
    lastDimmingValue = dimming;
    cur_ip = [[self.lightArray objectAtIndex:lightIndex] objectForKey:DeviceIpKey];
    NSDictionary *info = [self getHardwareInfo:cur_ip];
//    NSLog(@"%@",info);
    
    if (!info) {
        return;
    }
    self.lblRunningTime.text = [NSString stringWithFormat:@"%dh %dm",[[info objectForKey:@"h"] intValue],[[info objectForKey:@"m"] intValue]];
    dimming = [[info objectForKey:@"b"] doubleValue];
    self.lblPower.text = [NSString stringWithFormat:@"%.2f(w)",CalculatePowerRate(dimming)];
    //    self.lblDimming.text = [NSString stringWithFormat:@"%d",(int)dimming];
    self.lblDimming.text = [NSString stringWithFormat:@"%d%%",(int)(dimming/MaxDimmingLevel*100)];
    self.sliDimming.value = dimming;
    
    int io = [[info objectForKey:@"o"] intValue];
    if (io == 0) {
        self.lblPower.text = @"0.00(w)";
        self.lblDimming.text = @"0%";
        self.sliDimming.value = 0;
    }
    
//    [hud hide:YES];
//    [hud removeFromSuperview];
//    [hud release];
//    hud = nil;
}

- (NSDictionary *)getHardwareInfo:(NSString *)ip_address {
    NSString *result = [CoAPSocketUtils statusSocketWithIp:[ip_address UTF8String]];
    //    NSLog(@"%@",result);
    if (result && result.length > 20) {
        NSRange range = [result rangeOfString:@"{\"h\":"];
        //        NSLog(@"location:%d,len:%d",range.location,range.length);
        if (range.length != 5) {
            return nil;
        }
        NSString *info = [result substringFromIndex:(range.location)];
        NSLog(@"ip:%@ and reslut:%@", ip_address, info);
        return [info JSONValue];
    }
    return nil;
}

@end
