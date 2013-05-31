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

@interface RootViewController () {
    SystemManagerViewController *systemController;
    OfficeListViewController *officeController;
}

@end

@implementation RootViewController

- (void)dealloc {
    NSLog(@"root_view_controller_dealloc");
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
    
    int cc = 145;
//    char p[8];
//    p = malloc(8*sizeof(char));
//    p[0] = 145;
    NSString *cs = [NSString stringWithFormat:@"%c",cc];
//    NSString *cs = [NSString stringWithCString:p encoding:NSASCIIStringEncoding];
    NSLog(@"%@,%d",cs,cs.length);
//    NSString *cs = [NSString stringWithFormat:@"%c",cc];
//    NSLog(@"%c and length:%lu",cc,strlen([cs cStringUsingEncoding:NSASCIIStringEncoding]));
    
    int a = 97;
    char b = 0x62;
//    char *p = NULL;
//    itoa(p,tmp,2);
//    NSLog(@"%@",p);
    
    NSLog(@"%c,%c",a,b);
    
    NSLog(@"%.2f",CalculatePowerRate(10));
    
//    self.title = @"PHILIPS";
    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings"] style:UIBarButtonItemStyleDone target:self action:@selector(gotoSettingView)];
//    self.navigationItem.rightBarButtonItem = item;
    
    UIButton *btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnRight setImage:[UIImage imageNamed:@"settings"] forState:UIControlStateNormal];
    btnRight.frame = CGRectMake(0, 0, 30, 30);
    [btnRight addTarget:self action:@selector(gotoSettingView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btnRight];
    self.navigationItem.rightBarButtonItem = item;
    
    [item release];
    
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
}

- (IBAction)btnTapped:(id)sender {
//    [[CoAPSocket sharedInstance] openUDPServer];
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 1:
            TurnOnOff(@"true", ip_addr);
//            [CoAPSocketUtils sendSocket:"{\"o\":true}" withIP:ip_addr];
            break;
        case 2:
            TurnOnOff(@"false", ip_addr);
//            [CoAPSocketUtils sendSocket:"{\"o\":false}" withIP:ip_addr];
            break;
        case 3:
            ChangeDimmingValue(55, ip_addr);
//            [CoAPSocketUtils sendSocket:"{\"b\":55}" withIP:ip_addr];
            break;
        case 4:
            ChangeDimmingValue(110, ip_addr);
//            [CoAPSocketUtils sendSocket:"{\"b\":110}" withIP:ip_addr];
            break;
        case 5:
            ChangeDimmingValue(165, ip_addr);
//            [CoAPSocketUtils sendSocket:"{\"b\":165}" withIP:ip_addr];
            break;
        case 6:
            ChangeDimmingValue(220, ip_addr);
//            [CoAPSocketUtils sendSocket:"{\"b\":220}" withIP:ip_addr];
            break;
        default:
            break;
    }
}

- (void)gotoOfficeList {
    if (!officeController) {
        officeController = [[OfficeListViewController alloc] init];
    }
    [self.navigationController pushViewController:officeController animated:YES];
}

- (void)gotoSettingView {
    if (!systemController) {
        systemController = [[SystemManagerViewController alloc] init];
    }
    [self.navigationController pushViewController:systemController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
