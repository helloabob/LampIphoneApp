//
//  ConfigurationManager.m
//  LampIphoneApp
//
//  Created by wangbo on 13-5-30.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import "ConfigurationManager.h"

@implementation ConfigurationManager

+ (void)registerDefaultData {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 4; i ++) {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"PowerBalance",
                              DeviceNameKey,
                              [NSNumber numberWithInt:0],
                              DimmingLevelKey,
                              [NSNumber numberWithInt:0],
                              LastOnTimeIntervalKey, nil];
        [array addObject:dict];
    }
    [[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:
                                                             array,
                                                             DeviceUserDefaultKey, nil]];
    [[NSUserDefaults standardUserDefaults] setObject:@"aaa" forKey:@"bb"];
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"ccc"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"aaa");
}

@end
