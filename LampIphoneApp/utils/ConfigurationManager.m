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
                              DeviceTypeKey,
                              @"192.168.11.61",
                              DeviceIpKey, nil];
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
    
//    NSDictionary *office2 = [NSDictionary dictionaryWithObjectsAndKeys:
//                             @"myOffice2",
//                             OfficeNameKey,
//                             [NSArray arrayWithObjects:nil],
//                             OfficeDeviceNameKey, nil];
//    [arrayOffice addObject:office2];
    
    [self registerObject:arrayOffice forKey:OfficeUserDefaultKey];
    
    //init preset data.
    NSMutableArray *arrayPreset = [NSMutableArray array];
    NSDictionary *preset1 = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"preset1",
                             PresetNameKey,
                             [NSArray arrayWithObjects:@"light0:50",@"light1:100",@"light2:150",@"light3:200", nil],
                             PresetDeviceNameKey,nil];
    [arrayPreset addObject:preset1];
    
    NSDictionary *preset2 = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"preset2",
                             PresetNameKey,
                             [NSArray arrayWithObjects:@"light0:100",@"light1:100",@"light2:150",@"light3:200", nil],
                             PresetDeviceNameKey,nil];
    [arrayPreset addObject:preset2];
    
    NSDictionary *preset3 = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"preset3",
                             PresetNameKey,
                             [NSArray arrayWithObjects:@"light0:0",@"light1:100",@"light2:150",@"light3:200", nil],
                             PresetDeviceNameKey,nil];
    [arrayPreset addObject:preset3];
    
    NSDictionary *preset4 = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"preset4",
                             PresetNameKey,
                             [NSArray arrayWithObjects:@"light0:200",@"light1:100",@"light2:150",@"light3:200", nil],
                             PresetDeviceNameKey,nil];
    [arrayPreset addObject:preset4];
    
    [self registerObject:arrayPreset forKey:PresetUserDefaultKey];
}

+ (void)registerObject:(id)object forKey:(NSString *)key {
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:key] == nil) {
//        [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
//    NSArray *array = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
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

+ (NSArray *)getLightsInfoWithOfficeName:(NSString *)officeName {
    NSArray *array = [self objectForKey:OfficeUserDefaultKey];
    NSArray *arr = nil;
    for (NSDictionary *dict in array) {
        if ([[dict objectForKey:OfficeNameKey] isEqualToString:officeName]) {
            arr = [[dict objectForKey:OfficeDeviceNameKey] retain];
            break;
        }
    }
    
    NSArray *devices = [self objectForKey:DeviceUserDefaultKey];
    NSMutableArray *lights = [NSMutableArray array];
    for (NSString *lightName in arr) {
        for (NSDictionary *dict in devices) {
            if ([[dict objectForKey:DeviceNameKey] isEqualToString:lightName]) {
                [lights addObject:dict];
                break;
            }
        }
    }
    [arr release];
    
    return [NSArray arrayWithArray:lights];
}

+ (NSDictionary *)getLightInfoWithLightName:(NSString *)lightName {
    NSArray *devices = [self objectForKey:DeviceUserDefaultKey];
    NSDictionary *light = nil;
        for (NSDictionary *dict in devices) {
            if ([[dict objectForKey:DeviceNameKey] isEqualToString:lightName]) {
//                [lights addObject:dict];
                light = dict;
                break;
            }
        }
    
    return light;
}

+ (NSArray *)getLightsInfoWithPresetName:(NSString *)presetName {
    NSArray *array = [self objectForKey:PresetUserDefaultKey];
    NSArray *arr = nil;
    for (NSDictionary *dict in array) {
        if ([[dict objectForKey:PresetNameKey] isEqualToString:presetName]) {
            arr = [[dict objectForKey:PresetDeviceNameKey] retain];
            break;
        }
    }
    
    NSArray *devices = [self objectForKey:DeviceUserDefaultKey];
    NSMutableArray *lights = [NSMutableArray array];
    for (NSString *lightNameAndDimming in arr) {
        NSArray *arra = [lightNameAndDimming componentsSeparatedByString:@":"];
        NSString *lightName = [arra objectAtIndex:0];
        int dimming = [[arra objectAtIndex:1] intValue];
        for (NSDictionary *dict in devices) {
            if ([[dict objectForKey:DeviceNameKey] isEqualToString:lightName]) {
                NSDictionary *newDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                         lightName,
                                         DeviceNameKey,
                                         [dict objectForKey:DeviceIpKey],
                                         DeviceIpKey,
                                         [NSNumber numberWithInt:dimming],
                                         DimmingLevelKey, nil];
                [lights addObject:newDict];
                break;
            }
        }
    }
    [arr release];
    
    return [NSArray arrayWithArray:lights];
}

@end
