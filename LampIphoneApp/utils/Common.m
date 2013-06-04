//
//  Common.m
//  LampIphoneApp
//
//  Created by wangbo on 13-6-3.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import "Common.h"

#import "AppDelegate.h"

static NSString *officeName;

@implementation Common

+ (NSString *)currentOfficeName {
    return officeName;
}

+ (void)setCurrentOfficeName:(NSString *)value {
    officeName = value;
}

@end
