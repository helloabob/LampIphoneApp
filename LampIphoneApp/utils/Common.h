//
//  Common.h
//  LampIphoneApp
//
//  Created by wangbo on 13-6-3.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Common : NSObject

+ (NSString *)currentOfficeName;

+ (void)setCurrentOfficeName:(NSString *)value;

+ (NSString *)currentConfigPresetName;

+ (void)setCurrentConfigPresetName:(NSString *)value;

@end
