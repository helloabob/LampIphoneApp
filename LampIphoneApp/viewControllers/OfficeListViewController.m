//
//  OfficeListViewController.m
//  LampIphoneApp
//
//  Created by wangbo on 13-5-27.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import "OfficeListViewController.h"

#import "OfficeDetailViewController.h"
#import "ConfigurationManager.h"

@interface OfficeListViewController () {
    NSArray *arrayMenu;
}

@end

@implementation OfficeListViewController

@synthesize tblSystem = _tblSystem;

- (void)dealloc {
    self.tblSystem = nil;
    [arrayMenu release];
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
    
    self.title = @"Office List";
    
//    arrayMenu = [[NSArray alloc] initWithObjects:@"My Office", @"Electronics Lab - Lighting 2", nil];
    
    arrayMenu = [ConfigurationManager objectForKey:OfficeUserDefaultKey];
    
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
    return arrayMenu.count;
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
    cell.textLabel.text = [[arrayMenu objectAtIndex:indexPath.row] objectForKey:OfficeNameKey];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
     OfficeDetailViewController *detailViewController = [[OfficeDetailViewController alloc] init];
    detailViewController.title = [[arrayMenu objectAtIndex:indexPath.row] objectForKey:OfficeNameKey];
    detailViewController.roomIndex = indexPath.row;
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
    
}

@end
