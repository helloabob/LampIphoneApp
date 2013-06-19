//
//  PresetListViewController.m
//  LampIphoneApp
//
//  Created by wangbo on 13-6-6.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import "PresetListViewController.h"

#import "PresetConfigViewController.h"

#import "ConfigurationManager.h"

#import "MBProgressHUD.h"

#import <QuartzCore/QuartzCore.h>

@interface PresetListViewController () {
}

@end

@implementation PresetListViewController

@synthesize tblSystem = _tblSystem;

- (void)dealloc {
    NSLog(@"presetlistViewController_dealloc");
    self.tblSystem = nil;
    self.arrayMenu = nil;
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
    self.title = @"Preset Config";
    
    
//    arrayMenu = [[NSArray alloc] initWithObjects:@"preset1", @"preset2", @"preset3", @"preset4", nil];
    
    self.tblSystem.delegate = self;
    self.tblSystem.dataSource = self;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor whiteColor]];
    btn.frame = CGRectMake(0, 0, 305, 45);
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"Reset All Presets" forState:UIControlStateNormal];
    [btn.titleLabel setFont:app_philips_label_font_size];
    btn.layer.cornerRadius = 15.0f;
    btn.layer.borderWidth = 1.0f;
    btn.layer.borderColor = [[UIColor colorWithRed:172.0/255.0 green:172.0/255.0 blue:172.0/255.0 alpha:1.0f] CGColor];
    btn.center = CGPointMake(self.view.center.x, self.view.bounds.size.height - 120);
    btn.tag = 111;
    [btn addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnTapped:(id)sender {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    hud.labelText = @"Reseting...";
    [self.navigationController.view addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:1.0f];
    [ConfigurationManager resetAllPresets];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSArray *presets = [ConfigurationManager objectForKey:PresetUserDefaultKey];
    self.arrayMenu = [NSMutableArray array];
    for (NSDictionary *dict in presets) {
        [self.arrayMenu addObject:dict];
    }
    [self.tblSystem reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.arrayMenu.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.row == self.arrayMenu.count) {
        cell.textLabel.text = @"Reset All Presets";
    } else {
        cell.textLabel.text = [[self.arrayMenu objectAtIndex:indexPath.row] objectForKey:PresetLabelNameKey];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
//    if (indexPath.row == DeviceConfigRow) {
        //        DeviceListViewController *deviceViewController = [[DeviceListViewController alloc] init];
        //        [self.navigationController pushViewController:deviceViewController animated:YES];
        //        [deviceViewController release];
    if (indexPath.row == self.arrayMenu.count) {
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        hud.labelText = @"Reseting...";
        [self.navigationController.view addSubview:hud];
        [hud show:YES];
        [hud hide:YES afterDelay:1.0f];
        [ConfigurationManager resetAllPresets];
    } else {
        PresetConfigViewController *detailViewController = [[PresetConfigViewController alloc] init];
        detailViewController.title = [[self.arrayMenu objectAtIndex:indexPath.row] objectForKey:PresetNameKey];
        [Common setCurrentConfigPresetName:[[self.arrayMenu objectAtIndex:indexPath.row] objectForKey:PresetNameKey]];
        //        detailViewController.title = [[self.arrayMenu objectAtIndex:indexPath.row] objectForKey:OfficeNameKey];
        //        detailViewController.roomIndex = indexPath.row;
        // ...
        // Pass the selected object to the new view controller.
        [self.navigationController pushViewController:detailViewController animated:YES];
        [detailViewController release];
    }
    
//
//    }
    
    [self performSelector:@selector(unselectCurrentRow) withObject:nil afterDelay:0.5f];
}

- (void)unselectCurrentRow {
    [self.tblSystem deselectRowAtIndexPath:[self.tblSystem indexPathForSelectedRow] animated:YES];
}

@end
