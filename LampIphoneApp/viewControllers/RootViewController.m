//
//  RootViewController.m
//  LampIphoneApp
//
//  Created by wangbo on 13-5-27.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import "RootViewController.h"

#import "SystemManagerViewController.h"

#import "OfficeListViewController.h"

#import "CoAPSocket.h"

#import "CoAPSocketUtils.h"

#import "ConfigurationManager.h"

#import "AppDelegate.h"

#import "JSON.h"

#import "PresetListViewController.h"

@interface RootViewController () {
    SystemManagerViewController *systemController;
    OfficeListViewController *officeController;
    UIButton *btnEnabled;
    OfficeDetailInfoView *detailView;
}

@end

@implementation RootViewController

@synthesize lights = _lights;
@synthesize sli = _sli;

@synthesize buttonMaskView = _buttonMaskView;

@synthesize sliderMaskView = _sliderMaskView;

- (void)dealloc {
    NSLog(@"root_view_controller_dealloc");
//    self.btn1 = nil;
//    self.btn2 = nil;
    self.btn3 = nil;
    self.btn4 = nil;
    self.btn5 = nil;
    self.btn6 = nil;
    self.lights = nil;
    self.sli = nil;
    self.buttonMaskView = nil;
    self.sliderMaskView = nil;
    
    self.btnPreset1 = nil;
    self.btnPreset2 = nil;
    self.btnPreset3 = nil;
    self.btnPreset4 = nil;
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

- (void)gotoPreviousViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"PHILIPS";
    
//    [self.navigationItem.backBarButtonItem setTitle:@"Back"];
    [self.navigationItem hidesBackButton];
    
    btnEnabled = [UIButton buttonWithType:UIButtonTypeCustom];
    btnEnabled.frame = CGRectMake(20, 381, 20, 20);
    [btnEnabled setImage:[UIImage imageNamed:@"cbx00"] forState:UIControlStateNormal];
    [btnEnabled setImage:[UIImage imageNamed:@"cbx01"] forState:UIControlStateSelected];
    [btnEnabled addTarget:self action:@selector(btnEnabledTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnEnabled];
    self.sli.enabled = NO;
    
    
    
    self.buttonMaskView.hidden = YES;
    self.sliderMaskView.hidden = NO;
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(gotoPreviousViewController)];
    
//    [UIBarButtonItem alloc] initWithTitle:<#(NSString *)#> style:UIBarButtonSystemItemUndo target:<#(id)#> action:<#(SEL)#>
    
    int cc = 145;
//    char p[8];
//    p = malloc(8*sizeof(char));
//    p[0] = 145;
    NSString *cs = [NSString stringWithFormat:@"%c",cc];
//    NSString *cs = [NSString stringWithCString:p encoding:NSASCIIStringEncoding];
    NSLog(@"%@,%d",cs,cs.length);
//    NSString *cs = [NSString stringWithFormat:@"%c",cc];
//    NSLog(@"%c and length:%lu",cc,strlen([cs cStringUsingEncoding:NSASCIIStringEncoding]));
    
//    int a = 97;
//    char b = 0x62;
//    char *p = NULL;
//    itoa(p,tmp,2);
//    NSLog(@"%@",p);
    
//    NSLog(@"%c,%c",a,b);
    
//    NSLog(@"%.2f",CalculatePowerRate(10));
    
//    self.lights = [ConfigurationManager getLightsInfoWithOfficeName:[Common currentOfficeName]];
    
//    self.title = @"PHILIPS";
    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings"] style:UIBarButtonItemStyleDone target:self action:@selector(gotoSettingView)];
//    self.navigationItem.rightBarButtonItem = item;
    
//    NSArray *array = [ConfigurationManager getLightsInfoWithPresetName:@"preset1"];
    
    /*on off button*/
    UIButton *btn = [UIButton buttonWithType:110];
    [btn setTitle:@"ON" forState:UIControlStateNormal];
    btn.frame = CGRectMake(9, 196, 145, 50);
    btn.titleLabel.font = app_philips_button_font_size;
    btn.tag = 111;
    [btn addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    btn = [UIButton buttonWithType:110];
    [btn setTitle:@"OFF" forState:UIControlStateNormal];
    btn.frame = CGRectMake(164, 196, 145, 50);
    btn.titleLabel.font = app_philips_button_font_size;
    btn.tag = 110;
    [btn addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    /*preset button*/
    btn = [UIButton buttonWithType:110];
    [btn setTitle:@"preset1" forState:UIControlStateNormal];
    btn.frame = CGRectMake(9, 250, 145, 50);
    btn.titleLabel.font = app_philips_button_font_size;
    btn.tag = 141;
    [btn addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.btnPreset1 = btn;
    
    btn = [UIButton buttonWithType:110];
    [btn setTitle:@"preset2" forState:UIControlStateNormal];
    btn.frame = CGRectMake(164, 250, 145, 50);
    btn.titleLabel.font = app_philips_button_font_size;
    btn.tag = 142;
    [btn addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.btnPreset2 = btn;
    
    btn = [UIButton buttonWithType:110];
    [btn setTitle:@"preset3" forState:UIControlStateNormal];
    btn.frame = CGRectMake(9, 304, 145, 50);
    btn.titleLabel.font = app_philips_button_font_size;
    btn.tag = 143;
    [btn addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.btnPreset3 = btn;
    
    btn = [UIButton buttonWithType:110];
    [btn setTitle:@"preset4" forState:UIControlStateNormal];
    btn.frame = CGRectMake(164, 304, 145, 50);
    btn.titleLabel.font = app_philips_button_font_size;
    btn.tag = 144;
    [btn addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.btnPreset4 = btn;
    
    /*4 light buttons*/
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"light_icon"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"light_icon_selected"] forState:UIControlStateSelected];
    btn.frame = CGRectMake(100, 43, 45, 45);
    btn.tag = 121;
    [btn addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"light_icon"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"light_icon_selected"] forState:UIControlStateSelected];
    btn.frame = CGRectMake(176, 43, 45, 45);
    btn.tag = 122;
    [btn addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"light_icon"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"light_icon_selected"] forState:UIControlStateSelected];
    btn.frame = CGRectMake(100, 110, 45, 45);
    btn.tag = 123;
    [btn addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"light_icon"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"light_icon_selected"] forState:UIControlStateSelected];
    btn.frame = CGRectMake(176, 110, 45, 45);
    btn.tag = 124;
    [btn addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    
//    btn = [UIButton buttonWithType:110];
//    btn.frame = CGRectMake(9, 250, 145, 50);
//    [btn setTintColor:[UIColor colorWithRed:156.0/255.0 green:193.0/255.0 blue:248.0/255.0 alpha:1.0f]];
//    [btn setTitle:@"Work" forState:UIControlStateNormal];
//    btn.titleLabel.font = app_philips_button_font_size;
//    btn.tag = 131;
//    [btn addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
//    
//    btn = [UIButton buttonWithType:110];
//    btn.frame = CGRectMake(164, 250, 145, 50);
////    [btn setTintColor:[UIColor colorWithRed:156.0/255.0 green:193.0/255.0 blue:248.0/255.0 alpha:1.0f]];
//    [btn setTintColor:[UIColor blueColor]];
//    [btn setTitle:@"preset1" forState:UIControlStateNormal];
//    btn.titleLabel.font = app_philips_button_font_size;
//    btn.tag = 131;
//    [btn addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
    
    [self.btn3 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.btn4 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.btn5 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.btn6 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
    self.btn3.titleLabel.font = app_philips_button_font_size;
    self.btn4.titleLabel.font = app_philips_button_font_size;
    self.btn5.titleLabel.font = app_philips_button_font_size;
    self.btn6.titleLabel.font = app_philips_button_font_size;
    
    UIButton *btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnRight setImage:[UIImage imageNamed:@"settings"] forState:UIControlStateNormal];
    btnRight.frame = CGRectMake(0, 0, 30, 30);
    [btnRight addTarget:self action:@selector(gotoSettingView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btnRight];
    self.navigationItem.rightBarButtonItem = item;
    
//    [self.sli addTarget:self action:@selector(dimmingChanged:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside];
    [self.sli addTarget:self action:@selector(dimmingChanged:) forControlEvents:UIControlEventValueChanged];
    
    [item release];
    
    detailView = [[OfficeDetailInfoView alloc] initWithFrame:CGRectMake(0, 196, 320, self.view.frame.size.height-196)];
    [self.view addSubview:detailView];
    detailView.delegate = self;
    [detailView hideWithAnimated:NO];
    
//    UIBarButtonItem *itemHome = [[UIBarButtonItem alloc] initWithTitle:@"Office List" style:UIBarButtonItemStyleDone target:self action:@selector(gotoOfficeList)];
//    self.navigationItem.leftBarButtonItem = itemHome;
//    [itemHome release];
    
//    NSLog(@"frame:%@",NSStringFromCGRect(self.view.bounds));
//    
//    UIView *viewBlack = [[UIView alloc] initWithFrame:CGRectMake(10, 10, self.view.bounds.size.width-20, self.view.bounds.size.height-40)];
//    
//    NSLog(@"frame:%@",NSStringFromCGRect(viewBlack.bounds));
//    
//    viewBlack.backgroundColor = [UIColor blackColor];
//    viewBlack.alpha = 0.5;
//    [self.view addSubview:viewBlack];
    
    [self.view bringSubviewToFront:self.buttonMaskView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSArray *presets = [ConfigurationManager objectForKey:PresetUserDefaultKey];
    
    [self.btn3 setTitle:[[presets objectAtIndex:0] objectForKey:PresetLabelNameKey] forState:UIControlStateNormal];
    [self.btn4 setTitle:[[presets objectAtIndex:1] objectForKey:PresetLabelNameKey] forState:UIControlStateNormal];
    [self.btn5 setTitle:[[presets objectAtIndex:2] objectForKey:PresetLabelNameKey] forState:UIControlStateNormal];
    [self.btn6 setTitle:[[presets objectAtIndex:3] objectForKey:PresetLabelNameKey] forState:UIControlStateNormal];
    
    [self.btnPreset1 setTitle:[[presets objectAtIndex:0] objectForKey:PresetLabelNameKey] forState:UIControlStateNormal];
    [self.btnPreset2 setTitle:[[presets objectAtIndex:1] objectForKey:PresetLabelNameKey] forState:UIControlStateNormal];
    [self.btnPreset3 setTitle:[[presets objectAtIndex:2] objectForKey:PresetLabelNameKey] forState:UIControlStateNormal];
    [self.btnPreset4 setTitle:[[presets objectAtIndex:3] objectForKey:PresetLabelNameKey] forState:UIControlStateNormal];
}

- (void)viewDidClose {
    [self unSelectAllLightButton];
}

- (void)dimmingDidChangeValue:(int)value forName:(NSString *)lightName {
    
}

- (void)btnEnabledTapped:(UIButton *)sender {
//    sender.selected = !sender.selected;
    [self updateControllerState:!sender.selected];
}

- (void)updateControllerState:(BOOL)selected {
    btnEnabled.selected = selected;
    if (btnEnabled.selected) {
        self.sli.enabled = YES;
        self.btn3.enabled = NO;
        self.btn4.enabled = NO;
        self.btn5.enabled = NO;
        self.btn6.enabled = NO;
        self.buttonMaskView.hidden = NO;
        self.sliderMaskView.hidden = YES;
    } else {
        self.sli.enabled = NO;
        self.btn3.enabled = YES;
        self.btn4.enabled = YES;
        self.btn5.enabled = YES;
        self.btn6.enabled = YES;
        self.buttonMaskView.hidden = YES;
        self.sliderMaskView.hidden = NO;
    }
}

- (void)dimmingChanged:(id)sender {
    int value = self.sli.value;
    NSArray *array = [ConfigurationManager getLightsInfoWithOfficeName:[Common currentOfficeName]];
    for (NSDictionary *dict in array) {
        ChangeDimmingValue(value, [dict objectForKey:DeviceIpKey]);
    }
}

- (IBAction)btnTapped:(id)sender {
//    [[CoAPSocket sharedInstance] openUDPServer];
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 111: {
            NSArray *array = [ConfigurationManager getLightsInfoWithOfficeName:[Common currentOfficeName]];
            for (NSDictionary *dict in array) {
                TurnOnOff(@"true", [dict objectForKey:DeviceIpKey]);
            }
            //            [CoAPSocketUtils sendSocket:"{\"o\":true}" withIP:ip_addr];
        }
        break;
        case 110: {
            NSArray *array = [ConfigurationManager getLightsInfoWithOfficeName:[Common currentOfficeName]];
            for (NSDictionary *dict in array) {
                TurnOnOff(@"false", [dict objectForKey:DeviceIpKey]);
            }
        }
            break;
        case 141: {
            [self updateControllerState:NO];
            NSArray *array = [ConfigurationManager getLightsInfoWithPresetName:@"preset1"];
            for (NSDictionary *dict in array) {
                ChangeDimmingValue([[dict objectForKey:DimmingLevelKey] intValue], [dict objectForKey:DeviceIpKey]);
            }
        }
//            [CoAPSocketUtils sendSocket:"{\"b\":55}" withIP:ip_addr];
            break;
        case 142: {
            [self updateControllerState:NO];
            NSArray *array = [ConfigurationManager getLightsInfoWithPresetName:@"preset2"];
            for (NSDictionary *dict in array) {
                ChangeDimmingValue([[dict objectForKey:DimmingLevelKey] intValue], [dict objectForKey:DeviceIpKey]);
            }
        }
//            ChangeDimmingValue(110, ip_addr);
//            [CoAPSocketUtils sendSocket:"{\"b\":110}" withIP:ip_addr];
            break;
        case 143: {
            [self updateControllerState:NO];
            NSArray *array = [ConfigurationManager getLightsInfoWithPresetName:@"preset3"];
            for (NSDictionary *dict in array) {
                ChangeDimmingValue([[dict objectForKey:DimmingLevelKey] intValue], [dict objectForKey:DeviceIpKey]);
            }
        }
//            ChangeDimmingValue(165, ip_addr);
//            [CoAPSocketUtils sendSocket:"{\"b\":165}" withIP:ip_addr];
            break;
        case 144: {
            [self updateControllerState:NO];
            NSArray *array = [ConfigurationManager getLightsInfoWithPresetName:@"preset4"];
            for (NSDictionary *dict in array) {
                ChangeDimmingValue([[dict objectForKey:DimmingLevelKey] intValue], [dict objectForKey:DeviceIpKey]);
            }
        }
//            ChangeDimmingValue(220, ip_addr);
//            [CoAPSocketUtils sendSocket:"{\"b\":220}" withIP:ip_addr];
            break;
        case 121: {
            if (btn.selected) {
                return;
            }
            [self unSelectAllLightButton];
            [btn setSelected:YES];
            [detailView updateControlInfo:[self getDetailInfo:light1]];
            [detailView showWithAnimated:YES];
        }
            break;
        case 122: {
            if (btn.selected) {
                return;
            }
            [self unSelectAllLightButton];
            [btn setSelected:YES];
            [detailView updateControlInfo:[self getDetailInfo:light2]];
            [detailView showWithAnimated:YES];
        }
            break;
        case 123: {
            if (btn.selected) {
                return;
            }
            [self unSelectAllLightButton];
            [btn setSelected:YES];
            [detailView updateControlInfo:[self getDetailInfo:light3]];
            [detailView showWithAnimated:YES];
        }
            break;
        case 124: {
            if (btn.selected) {
                return;
            }
            [self unSelectAllLightButton];
            [btn setSelected:YES];
            [detailView updateControlInfo:[self getDetailInfo:light4]];
            [detailView showWithAnimated:YES];
        }
            break;
        default:
            break;
    }
}

- (NSDictionary *)getDetailInfo:(NSString *)lightName {
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    NSArray *array = [ConfigurationManager objectForKey:DeviceUserDefaultKey];
    for (NSDictionary *dict in array) {
        if ([[dict objectForKey:DeviceNameKey] isEqualToString:lightName]) {
            [userInfo setObject:lightName forKey:DetailDeviceNameKey];
            [userInfo setObject:[dict objectForKey:DeviceIpKey] forKey:DetailIPKey];
            NSString *result = [CoAPSocketUtils statusSocketWithIp:[[dict objectForKey:DeviceIpKey] UTF8String]];
            if (result && result.length > 20) {
                NSRange range = [result rangeOfString:@"{\"h\":"];
                if (range.length != 5) {
                    return userInfo;
                }
                NSString *info = [result substringFromIndex:(range.location)];
                NSDictionary *jsonValue = [info JSONValue];
                if ([[jsonValue objectForKey:@"o"] intValue] == 0) {
                    [userInfo setObject:[NSNumber numberWithInt:0] forKey:DetailDimmingKey];
                } else {
                    [userInfo setObject:[jsonValue objectForKey:@"b"] forKey:DetailDimmingKey];
                }
                [userInfo setObject:[jsonValue objectForKey:@"h"] forKey:DetailRunningHourKey];
                [userInfo setObject:[jsonValue objectForKey:@"m"] forKey:DetailRunningMinuteKey];
                [userInfo setObject:[jsonValue objectForKey:@"o"] forKey:DetailIOKey];
            }
            break;
        }
    }
    return userInfo;
}

- (void)unSelectAllLightButton {
    UIButton *btn = (UIButton *)[self.view viewWithTag:121];
    [btn setSelected:NO];
    btn = (UIButton *)[self.view viewWithTag:122];
    [btn setSelected:NO];
    btn = (UIButton *)[self.view viewWithTag:123];
    [btn setSelected:NO];
    btn = (UIButton *)[self.view viewWithTag:124];
    [btn setSelected:NO];
}

- (void)gotoOfficeList {
    if (!officeController) {
        officeController = [[OfficeListViewController alloc] init];
    }
    [self.navigationController pushViewController:officeController animated:YES];
}

- (void)gotoSettingView {
    PresetListViewController *presetViewController = [[PresetListViewController alloc] init];
    [self.navigationController pushViewController:presetViewController animated:YES];
    [presetViewController release];
//    if (!systemController) {
//        systemController = [[SystemManagerViewController alloc] init];
//    }
//    [self.navigationController pushViewController:systemController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
