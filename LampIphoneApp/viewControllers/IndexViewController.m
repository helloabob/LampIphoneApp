//
//  IndexViewController.m
//  LampIphoneApp
//
//  Created by wangbo on 13-5-31.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import "IndexViewController.h"

#import "RootViewController.h"

@interface IndexViewController () {
    
}

@end

@implementation IndexViewController

@synthesize tblSystem = _tblSystem;

@synthesize arrayMenu = _arrayMenu;

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
    self.title = @"PHILIPS";
    self.view.backgroundColor = app_default_background_color;
    
    UIButton *btn = [UIButton buttonWithType:110];
    btn.tintColor = [UIColor blueColor];
    btn.frame = CGRectMake(100, 200, 120, 40);
//    btn.titleLabel.text = @"Start";
    [btn setTitle:@"Start" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    self.arrayMenu = [NSArray arrayWithObjects:@"my office",@"Electronics labs - lighting 2", nil];
    
    self.tblSystem.delegate = self;
    self.tblSystem.dataSource = self;
//    self.tblSystem.backgroundColor = app_default_background_color;
    
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
    cell.textLabel.text = [self.arrayMenu objectAtIndex:indexPath.row];
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 35.0f;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *_headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 35)];
//    _headerView.backgroundColor = [UIColor lightGrayColor];
//    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _headerView.frame.size.width, _headerView.frame.size.height)];
//    lbl.text = @"Office List";
//    [lbl setFont:[UIFont systemFontOfSize:13.0f]];
//    lbl.backgroundColor = [UIColor clearColor];
//    [lbl setTextAlignment:NSTextAlignmentCenter];
//    [lbl setTextColor:[UIColor whiteColor]];
//    [_headerView addSubview:lbl];
//    [lbl release];
//    return [_headerView autorelease];
//}

- (void)unselectCurrentRow {
    [self.tblSystem deselectRowAtIndexPath:[self.tblSystem indexPathForSelectedRow] animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    RootViewController *detailViewController = [[RootViewController alloc] init];
//    detailViewController.title = [[self.arrayMenu objectAtIndex:indexPath.row] objectForKey:OfficeNameKey];
    detailViewController.title = [self.arrayMenu objectAtIndex:indexPath.row];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    
    [self performSelector:@selector(unselectCurrentRow) withObject:nil afterDelay:0.5f];
}

@end
