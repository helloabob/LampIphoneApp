//
//  ConfigurationManager.h
//  LampIphoneApp
//
//  Created by wangbo on 13-5-30.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfigurationManager : NSObject

+ (void)registerDefaultData;

+ (id)objectForKey:(NSString *)key;

+ (void)setObject:(id)object forKey:(NSString *)key;

+ (void)changeLightDimming:(NSNumber *)value forLightName:(NSString *)lightName;

+ (void)updateLastTurnOnTimeInterval:(BOOL)onOrOff forLightName:(NSString *)lightName;
@end
