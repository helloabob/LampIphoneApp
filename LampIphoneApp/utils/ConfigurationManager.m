//
//  ConfigurationManager.m
//  LampIphoneApp
//
//  Created by wangbo on 13-5-30.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import "ConfigurationManager.h"

@interface ConfigurationManager()

+ (void)registerObject:(id)object forKey:(NSString *)key;

@end

@implementation ConfigurationManager

+ (void)registerDefaultData {
    //init device list data.
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 4; i ++) {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSString stringWithFormat:@"light%d",i],
                              DeviceNameKey,
                              [NSNumber numberWithInt:0],
                              DimmingLevelKey,
                              [NSNumber numberWithInt:0],
                              LastOnTimeIntervalKey,
                              PowerBalanceTypeName,
                              DeviceTypeKey, nil];
        [array addObject:dict];
    }
    [self registerObject:array forKey:DeviceUserDefaultKey];
    
    
    //init office list data.
    NSMutableArray *arrayOffice = [NSMutableArray array];
    NSDictionary *office1 = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"myOffice",
                             OfficeNameKey,
                             [NSArray arrayWithObjects:@"light0",@"light1",@"light2",@"light3", nil],
                             OfficeDeviceNameKey, nil];
    [arrayOffice addObject:office1];
    
    NSDictionary *office2 = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"myOffice2",
                             OfficeNameKey,
                             [NSArray arrayWithObjects:nil],
                             OfficeDeviceNameKey, nil];
    [arrayOffice addObject:office2];
    
    [self registerObject:arrayOffice forKey:OfficeUserDefaultKey];
    
}

+ (void)registerObject:(id)object forKey:(NSString *)key {
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:key] == nil) {
//        [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filename = [path stringByAppendingPathComponent:@"db.plist"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:filename];
    if (dict == nil) {
        dict = [NSMutableDictionary dictionary];
    }
    if ([dict objectForKey:key] == nil) {
        [dict setObject:object forKey:key];
        [dict writeToFile:filename atomically:YES];
    }
//    NSLog(@"path:%@",path);
}

+ (id)objectForKey:(NSString *)key {
//    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filename = [path stringByAppendingPathComponent:@"db.plist"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:filename];
    return [dict objectForKey:key];
}

+ (void)setObject:(id)object forKey:(NSString *)key {
//    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filename = [path stringByAppendingPathComponent:@"db.plist"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:filename];
    [dict setObject:object forKey:key];
    [dict writeToFile:filename atomically:YES];
}

+ (void)changeLightDimming:(NSNumber *)value forLightName:(NSString *)lightName {
    NSArray *array = [self objectForKey:DeviceUserDefaultKey];
    for (NSMutableDictionary *dict in array) {
        if ([[dict objectForKey:DeviceNameKey] isEqualToString:lightName]) {
            NSLog(@"nsdictionary:%d",[dict isMemberOfClass:[NSDictionary class]]);
            NSLog(@"nsmutabledictionary:%d",[dict isMemberOfClass:[NSMutableDictionary class]]);
            [dict setObject:value forKey:DimmingLevelKey];
            break;
        }
    }
    [self setObject:array forKey:DeviceUserDefaultKey];
}

+ (void)updateLastTurnOnTimeInterval:(BOOL)onOrOff forLightName:(NSString *)lightName {
    NSArray *array = [self objectForKey:DeviceUserDefaultKey];
    for (NSMutableDictionary *dict in array) {
        if ([[dict objectForKey:DeviceNameKey] isEqualToString:lightName]) {
            NSTimeInterval lastTime = [[dict objectForKey:LastOnTimeIntervalKey] doubleValue];
            if (onOrOff) {
                if (lastTime > 0) {
                    return;
                }
                NSDate *dt = [NSDate date];
                [dict setObject:[NSNumber numberWithDouble:[dt timeIntervalSinceReferenceDate]] forKey:LastOnTimeIntervalKey];
            } else {
                if (lastTime <= 0) {
                    return;
                }
                [dict setObject:[NSNumber numberWithDouble:0] forKey:LastOnTimeIntervalKey];
            }
            break;
        }
    }
    [self setObject:array forKey:DeviceUserDefaultKey];
}



@end
