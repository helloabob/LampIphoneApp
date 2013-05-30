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

const char *ip_addr = "192.168.11.52";

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
    
    self.title = @"PHILIPS";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings"] style:UIBarButtonItemStyleDone target:self action:@selector(gotoSettingView)];
    self.navigationItem.rightBarButtonItem = item;
    [item release];
    
    UIBarButtonItem *itemHome = [[UIBarButtonItem alloc] initWithTitle:@"Office List" style:UIBarButtonItemStyleDone target:self action:@selector(gotoOfficeList)];
    self.navigationItem.leftBarButtonItem = itemHome;
    [itemHome release];
    
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
            [CoAPSocketUtils sendSocket:"{\"o\":true}" withIP:ip_addr];
            break;
        case 2:
            [CoAPSocketUtils sendSocket:"{\"o\":false}" withIP:ip_addr];
            break;
        case 3:
            [CoAPSocketUtils sendSocket:"{\"b\":55}" withIP:ip_addr];
            break;
        case 4:
            [CoAPSocketUtils sendSocket:"{\"b\":110}" withIP:ip_addr];
            break;
        case 5:
            [CoAPSocketUtils sendSocket:"{\"b\":165}" withIP:ip_addr];
            break;
        case 6:
            [CoAPSocketUtils sendSocket:"{\"b\":220}" withIP:ip_addr];
            break;
        default:
            break;
    }
    
//    [[CoAPSocket sharedInstance] sendMassage:@"{\"b\":220}"];
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
