//
//  CoAPSocket.h
//  LampIphoneApp
//
//  Created by wangbo on 13-5-28.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AsyncUdpSocket.h"
#import "IPAddress.h"

@interface CoAPSocket : NSObject {
    AsyncUdpSocket *_udpSocket;
}

@property (nonatomic, retain) NSString *myIP;

@property (nonatomic, strong) AsyncUdpSocket *udpSocket;

- (void)switchLamp:(BOOL)OnOrOff;

+ (id)sharedInstance;

-(void)sendMassage:(NSString *)message;

-(void)openUDPServer;

@end
