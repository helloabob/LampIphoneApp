//
//  OfficeDetailViewController.m
//  LampIphoneApp
//
//  Created by wangbo on 13-5-27.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import "OfficeDetailViewController.h"

@interface OfficeDetailViewController ()

@end

@implementation OfficeDetailViewController

@synthesize lblDevice = _lblDevice;
@synthesize lblPower = _lblPower;

- (void)dealloc {
    self.lblPower = nil;
    self.lblDevice = nil;
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
    self.title = @"Office Layout";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)lightButtonTapped:(id)sender {
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 1:
            //first light.
            self.lblDevice.text = @"PowerBalance";
            self.lblPower.text = [NSString stringWithFormat:@"%.2f(w)", CalculatePowerRate(100)];
            break;
            
        default:
            break;
    }
}

@end
