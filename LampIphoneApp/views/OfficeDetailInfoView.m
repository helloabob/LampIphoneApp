//
//  OfficeDetailInfoView.m
//  LampIphoneApp
//
//  Created by wangbo on 13-6-6.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import "OfficeDetailInfoView.h"

#import "CoAPSocketUtils.h"

@interface OfficeDetailInfoView() {
    int offsety;
    int cy;
    int flag;
}

@end

@implementation OfficeDetailInfoView

@synthesize ip_address = _ip_address;

- (void)dealloc {
    self.ip_address = nil;
    self.delegate = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        offsety = self.frame.size.height;
        cy = self.center.y;
        self.backgroundColor = [UIColor colorWithRed:225.0/255.0 green:235.0/255.0 blue:250.0/255.0 alpha:1];
        
//        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
//        line.backgroundColor = [UIColor blackColor];
//        [self addSubview:line];
//        [line release];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(47, 18, 107, 21)];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"Device Name:";
        label.font = app_philips_label_font_size;
//        label.textColor = [UIColor darkGrayColor];
        [self addSubview:label];
        [label release];
        
        lblDeviceName = [[UILabel alloc] initWithFrame:CGRectMake(175, 18, 100, 21)];
        lblDeviceName.text = @"NULL";
        lblDeviceName.font = app_philips_label_font_size;
        lblDeviceName.backgroundColor = [UIColor clearColor];
        [self addSubview:lblDeviceName];
        [lblDeviceName release];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(97, 47, 57, 21)];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"Power:";
        label.font = app_philips_label_font_size;
//        label.textColor = [UIColor darkGrayColor];
        [self addSubview:label];
        [label release];
        
        lblPower = [[UILabel alloc] initWithFrame:CGRectMake(175, 47, 160, 21)];
        lblPower.backgroundColor = [UIColor clearColor];
        lblPower.text = @"NULL";
        lblPower.font = app_philips_label_font_size;
        [self addSubview:lblPower];
        [lblPower release];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(36, 76, 118, 21)];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"Dimming Level:";
        label.font = app_philips_label_font_size;
//        label.textColor = [UIColor darkGrayColor];
        [self addSubview:label];
        [label release];
        
        lblDimming = [[UILabel alloc] initWithFrame:CGRectMake(175, 76, 60, 21)];
        lblDimming.backgroundColor = [UIColor clearColor];
        lblDimming.text = @"NULL";
        lblDimming.font = app_philips_label_font_size;
        [self addSubview:lblDimming];
        [lblDimming release];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(43, 105, 111, 21)];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"Running Time:";
        label.font = app_philips_label_font_size;
//        label.textColor = [UIColor darkGrayColor];
        [self addSubview:label];
        [label release];
        
        lblRunning = [[UILabel alloc] initWithFrame:CGRectMake(175, 105, 106, 21)];
        lblRunning.backgroundColor = [UIColor clearColor];
        lblRunning.text = @"NULL";
        lblRunning.font = app_philips_label_font_size;
        [self addSubview:lblRunning];
        [lblRunning release];
        
        slider = [[UISlider alloc] initWithFrame:CGRectMake(44, 136, 233, 23)];
        slider.minimumValue = 0;
        slider.maximumValue = MaxDimmingLevel;
        slider.value = 110;
        [slider addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventValueChanged];
//        [slider addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
        [self addSubview:slider];
        [slider release];
        
        UIButton *btn = [UIButton buttonWithType:110];
        btn.frame = CGRectMake(150, 170, 120, 35);
        [btn setTitle:@"Back" forState:UIControlStateNormal];
        btn.center = CGPointMake(self.center.x, btn.center.y);
        [btn addTarget:self action:@selector(btnCloseTapped) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    return self;
}

- (void)valueChanged {
//    [self.delegate dimmingDidChangeValue:slider.value forName:lblDeviceName.text];
    ChangeDimmingValue((int)slider.value, self.ip_address);
    int dimming = (int)slider.value;
    int rate = 100 * dimming / MaxDimmingLevel;
    lblDimming.text = [NSString stringWithFormat:@"%d%%",rate];
    if (flag == 1) {
        lblPower.text = [NSString stringWithFormat:@"%.2f(w)",CalculatePowerRate(dimming)];
    } else {
        lblPower.text = @"0.00(w)";
    }
}

- (void)btnCloseTapped {
    [self hideWithAnimated:YES];
    [self.delegate viewDidClose];
}

- (void)updateControlInfo:(NSDictionary *)userInfo {
    lblDeviceName.text = [userInfo objectForKey:DetailDeviceNameKey];
    self.ip_address = [userInfo objectForKey:DetailIPKey];
    int dimming = [[userInfo objectForKey:DetailDimmingKey] intValue];
    int rate = 100 * dimming / MaxDimmingLevel;
    lblDimming.text = [NSString stringWithFormat:@"%d%%",rate];
    slider.value = [[userInfo objectForKey:DetailDimmingKey] intValue];
    flag = [[userInfo objectForKey:DetailIOKey] intValue];
    if (flag == 1) {
        lblPower.text = [NSString stringWithFormat:@"%.2f(w)",CalculatePowerRate(dimming)];
        slider.enabled = YES;
    } else {
        lblPower.text = @"0.00(w)";
        slider.enabled = NO;
    }
    int hours = [[userInfo objectForKey:DetailRunningHourKey] intValue];
    int mins = [[userInfo objectForKey:DetailRunningMinuteKey] intValue];
    lblRunning.text = [NSString stringWithFormat:@"%dH %dM", hours, mins];
}

- (void)showWithAnimated:(BOOL)animated {
    if (animated) {
        if (self.hidden == YES) {
            self.hidden = NO;
            self.center = CGPointMake(self.center.x, cy + offsety);
//            NSLog(@"offsety:%d,oy:%d",offsety,c);
            [UIView animateWithDuration:0.3f animations:^{
                self.center = CGPointMake(self.center.x, cy);
            }];
        }
    } else {
        self.hidden = NO;
    }
}

- (void)hideWithAnimated:(BOOL)animated {
    if (animated) {
        if (self.hidden == NO) {
            self.center = CGPointMake(self.center.x, cy);
            [UIView animateWithDuration:0.3f animations:^{
                self.center = CGPointMake(self.center.x, cy + offsety);
            } completion:^(BOOL finished){
                self.hidden = YES;
            }];
        }
    } else {
        self.hidden = YES;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
