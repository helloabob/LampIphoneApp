//
//  OfficeListViewController.h
//  LampIphoneApp
//
//  Created by wangbo on 13-5-27.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OfficeListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tblSystem;

@property (strong, nonatomic) NSArray *arrayMenu;

@end
