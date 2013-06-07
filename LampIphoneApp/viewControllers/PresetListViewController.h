//
//  PresetListViewController.h
//  LampIphoneApp
//
//  Created by wangbo on 13-6-6.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PresetListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tblSystem;

@property (strong, nonatomic) NSMutableArray *arrayMenu;

@end
