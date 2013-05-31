//
//  DeviceListViewController.m
//  LampIphoneApp
//
//  Created by wangbo on 13-5-31.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import "DeviceListViewController.h"

#import "DeviceConfigViewController.h"

#import "ConfigurationManager.h"

@interface DeviceListViewController ()

@end

@implementation DeviceListViewController

@synthesize tblSystem = _tblSystem;
@synthesize arrayMenu = _arrayMenu;

- (void)dealloc {
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
    self.title = @"Device Config";
    
    //    arrayMenu = [[NSArray alloc] initWithObjects:@"My Office", @"Electronics Lab - Lighting 2", nil];
    
    self.arrayMenu = [ConfigurationManager objectForKey:DeviceUserDefaultKey];
    
    self.tblSystem.delegate = self;
    self.tblSystem.dataSource = self;
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
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = [[self.arrayMenu objectAtIndex:indexPath.row] objectForKey:DeviceNameKey];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push anothqer view controller.
    
    DeviceConfigViewController *detailViewController = [[DeviceConfigViewController alloc] init];
    detailViewController.title = [[self.arrayMenu objectAtIndex:indexPath.row] objectForKey:DeviceNameKey];
//    detailViewController.roomIndex = indexPath.row;
    // ...
    // Pass the selected object to the new view controller.
//    [self.navigationController presentViewController:detailViewController animated:YES completion:nil];
    [self presentViewController:detailViewController animated:YES completion:nil];
    [detailViewController release];
    
}

@end
