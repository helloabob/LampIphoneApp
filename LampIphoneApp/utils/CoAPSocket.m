//
//  CoAPSocket.m
//  LampIphoneApp
//
//  Created by wangbo on 13-5-28.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import "CoAPSocket.h"

const int port = 5683;

static CoAPSocket *_shared;

@implementation CoAPSocket

@synthesize udpSocket = _udpSocket;

+ (id)sharedInstance {
    if (!_shared) {
        _shared = [[self alloc] init];
    }
    return _shared;
}

//建立基于UDP的Socket连接
-(void)openUDPServer{
	//初始化udp
	AsyncUdpSocket *tempSocket=[[AsyncUdpSocket alloc] initWithDelegate:self];
	self.udpSocket = tempSocket;
	[tempSocket release];
    
    self.myIP = [self deviceIPAdress];
    
	//绑定端口
	NSError *error = nil;
//	[self.udpSocket bindToPort:port error:&error];
    
    if (error) {
        NSLog(@"error:%@",error);
    }
    //发送广播设置
//    [self.udpSocket enableBroadcast:YES error:&error];
    
    //加入群里，能接收到群里其他客户端的消息
//    [self.udpSocket joinMulticastGroup:@"224.0.0.2" error:&error];
    
   	//启动接收线程
	[self.udpSocket receiveWithTimeout:-1 tag:0];
    
    
}

- (NSString *)coAPHeader {
    int request[3];
    request[0] = 0x42;
    request[1] = 0x03;
    request[2] = 0xC7;
//    return [NSString stringWithUTF8String:(char *)request];
    char a = 0x42;
    char b = 0x03;
    

    char m1 = 0x27;
    
    int m2 = 0x10;
   
    unsigned char s1 = 145;
//    return [NSString stringWithFormat:@"%c%c%c%c%c", a, b, m1,m2, s1];
    char s2 = 'l';
    int s3 = 1;
    char s4 = '0';
    return [NSString stringWithFormat:@"%c%c%c%c%c%c%c%c",a,b,m1,m2,s1,s2,s3,s4];
    
//    char pHead[8];
//    pHead[0] = 0x42;
//    pHead[1] = 0x03;
//    pHead[2] = 0x27;
//    pHead[3] = 0x10;
//    pHead[4] = 145;
//    pHead[5] = 'l';
//    pHead[6] = 1;
//    pHead[7] = '0';
//    return [NSString stringWithCString:pHead encoding:NSASCIIStringEncoding];
}

//通过UDP,发送消息
-(void)sendMassage:(NSString *)message
{
    
//	NSDate *nowTime = [NSDate date];
	
	NSMutableString *sendString=[NSMutableString string];
//    long long header = 0x4203C75B916C0130;
    [sendString appendString:[self coAPHeader]];
//	[sendString appendString:message];
    
    NSLog(@"%@;length:%d",sendString,sendString.length);
    
//    NSLog(@"message:%x",(int)[sendString string]);
	//开始发送
//	BOOL res = [self.udpSocket sendData:[sendString dataUsingEncoding:NSUTF8StringEncoding]
//								 toHost:@"224.0.0.2"
//								   port:port
//							withTimeout:-1
//                                    tag:0];
    BOOL res = [self.udpSocket sendData:[sendString dataUsingEncoding:NSUTF8StringEncoding]
								 toHost:@"192.168.11.61"
								   port:port
							withTimeout:-1
                                    tag:0];
    
    
   	if (!res) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning"
														message:@"error occurs"
													   delegate:self
											  cancelButtonTitle:@"Cancel"
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}

#pragma mark -
#pragma mark UDP Delegate Methods
- (BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port
{
    
    [self.udpSocket receiveWithTimeout:-1 tag:0];
    NSLog(@"host---->%@",host);
    
    
    //收到自己发的广播时不显示出来
    NSMutableString *tempIP = [NSMutableString stringWithFormat:@"::ffff:%@",self.myIP];
    if ([host isEqualToString:self.myIP]||[host isEqualToString:tempIP])
    {
        //        return YES;
    }
    
   	//接收到数据回调，用泡泡VIEW显示出来
	
	NSString *info=[[[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding] autorelease];
	
    NSLog(@"%@",info);
    
	//已经处理完毕
	return YES;
}

- (void)onUdpSocket:(AsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error
{
	//无法发送时,返回的异常提示信息
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
													message:[error description]
												   delegate:self
										  cancelButtonTitle:@"取消"
										  otherButtonTitles:nil];
	[alert show];
	[alert release];
	
}

- (void)onUdpSocket:(AsyncUdpSocket *)sock didSendDataWithTag:(long)tag {
    NSLog(@"didSendDataWithTag");
}

- (void)onUdpSocketDidClose:(AsyncUdpSocket *)sock {
    NSLog(@"onUdpSocketDidClose");
}

- (void)onUdpSocket:(AsyncUdpSocket *)sock didNotReceiveDataWithTag:(long)tag dueToError:(NSError *)error
{
	//无法接收时，返回异常提示信息
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
													message:[error description]
												   delegate:self
										  cancelButtonTitle:@"取消"
										  otherButtonTitles:nil];
	[alert show];
	[alert release];
}

//得到本机IP
-(NSString *) deviceIPAdress
{
    InitAddresses();
    GetIPAddresses();
    GetHWAddresses();
    return [NSString stringWithFormat:@"%s",ip_names[1]];
}

- (void)switchLamp:(BOOL)OnOrOff {
    
}

@end
