//
//  PairMacIPOperation.m
//  LampIphoneApp
//
//  Created by wangbo on 13-6-5.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import "PairMacIPOperation.h"

#import "ConfigurationManager.h"

@implementation PairMacIPOperation
@synthesize theIP = _theIP;
@synthesize theMAC = _theMAC;

- (void)dealloc {
    NSLog(@"PairMacIPOperation_dealloc");
    self.theIP = nil;
    self.theMAC = nil;
    [super dealloc];
}

- (void)main {
    if (!self.theIP ||
        !self.theMAC ||
        [self.theIP isEqualToString:@""] ||
        [self.theMAC isEqualToString:@""]) {
        return;
    }
    BOOL flag = NO;
    NSArray *devices = [ConfigurationManager objectForKey:DeviceUserDefaultKey];
    for (NSMutableDictionary *dict in devices) {
        if ([[dict objectForKey:DeviceMacKey] isEqualToString:self.theMAC]) {
            [dict setObject:self.theIP forKey:DeviceIpKey];
            flag = YES;
            break;
        }
    }
    if (flag) {
        [ConfigurationManager setObject:devices forKey:DeviceUserDefaultKey];
    }
}

@end
