//
//  CoAPProcessOperation.m
//  LampIphoneApp
//
//  Created by wangbo on 13-6-4.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import "CoAPProcessOperation.h"

#import "CoAPSocketUtils.h"
#import "PairMacIPOperation.h"

@implementation CoAPProcessOperation
@synthesize theIP = _theIP;


- (void)dealloc {
    NSLog(@"CoAPProcessOperation_dealloc");
    self.theIP = nil;
    [super dealloc];
}

- (void)main {
    NSLog(@"connect to :%@",_theIP);
    NSString *result = [CoAPSocketUtils checkSocketWithIp:[_theIP UTF8String]];
//    NSLog(@"%@",result);
    if (result && result.length > 20) {
        NSRange range = [result rangeOfString:@"MAC:"];
//        NSLog(@"location:%d,len:%d",range.location,range.length);
        if (range.length != 4) {
            return;
        }
        NSString *mac_address = [result substringFromIndex:(range.location + range.length)];
        NSLog(@"ip:%@ and reslut:%@", _theIP, mac_address);
        
        PairMacIPOperation *op = [[PairMacIPOperation alloc] init];
        op.theIP = _theIP;
        op.theMAC = mac_address;
        [[NSOperationQueue mainQueue] addOperation:op];
        [op release];
    }
    
}

@end
