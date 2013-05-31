//
//  IndexViewController.h
//  LampIphoneApp
//
//  Created by wangbo on 13-5-31.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndexViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tblSystem;

@property (strong, nonatomic) NSArray *arrayMenu;

@end
