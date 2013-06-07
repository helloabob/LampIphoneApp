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

static NSString *configPresetName;

@implementation Common

+ (NSString *)currentOfficeName {
    return officeName;
}

+ (void)setCurrentOfficeName:(NSString *)value {
    officeName = value;
}

+ (NSString *)currentConfigPresetName {
    return configPresetName;
}

+ (void)setCurrentConfigPresetName:(NSString *)value {
    configPresetName = value;
}

@end
