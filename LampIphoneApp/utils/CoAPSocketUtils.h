//
//  CoAPSocketUtils.h
//  LampIphoneApp
//
//  Created by wangbo on 13-5-28.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoAPSocketUtils : NSObject {
    CFSocketRef _socket;
}

- (void)sendMessage;


+ (void)sendSocket:(const char *)payload withIP:(const char *)ip;

+ (NSString *)checkSocketWithIp:(const char *)ip;

+ (NSString *)statusSocketWithIp:(const char *)ip;

@end
