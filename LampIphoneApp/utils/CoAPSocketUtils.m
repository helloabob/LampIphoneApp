//
//  CoAPSocketUtils.m
//  LampIphoneApp
//
//  Created by wangbo on 13-5-28.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import "CoAPSocketUtils.h"

#import "sys/socket.h"
#import "netinet/in.h"

const int server_port = 5683;

@implementation CoAPSocketUtils

static void TCPServerConnectCallBack(CFSocketRef socket, CFSocketCallBackType type, CFDataRef address, const void *data, void *info) {
    if (data != NULL) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"连接失败" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }
}

- (void) doConnect {
    // CFSocketContext存放一些CFSocketRef的相关信息
    CFSocketContext CTX = {0, self, NULL, NULL, NULL};
    // CFSocketCreate函数是用来创建一个CFSocketRef，第一个参数是表示由系统默认的allocator来为CFSocketRef分配一个内存空间。
    // 第二个参数表示profocolFamily（协议簇）
    // 第三个参数表示socketType（socket的类型流、数据段、顺序包...）
    // 第四个参数表示protocol（协议tcp、udp...）
    // 第五个参数表示当socket的某个类型activity时，调用第六个参数的函数
    // 第六个参数表示当socket发生第五个参数的类型的动作时，调用的函数
    // 第七个参数表示一个保存CFSocket object对象的一些相关信息
    _socket = CFSocketCreate(kCFAllocatorDefault, AF_INET, SOCK_DGRAM, IPPROTO_UDP, kCFSocketConnectCallBack, TCPServerConnectCallBack, &CTX);
    if (NULL == _socket) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"创建套接字失败" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    // sockaddr_in 是一个struct，里面包含ip、端口等
    struct sockaddr_in addr4;
    memset(&addr4, 0, sizeof(addr4));// memset表示将地址addr4结构里面的前sizeof（）个内存地址里面的内容设置成int 0
    addr4.sin_len = sizeof(addr4);
    addr4.sin_family = AF_INET;
    addr4.sin_port = htons(5683);
    char *addr = "192.168.11.61";
    addr4.sin_addr.s_addr = inet_addr(addr);
    // CFDataCreate()是用来将一个申请一个sizeof()大小的内存空间，并将一个buffer中的数据拷贝到新申请的内存空间中
    CFDataRef address = CFDataCreate(kCFAllocatorDefault, (UInt8 *)&addr4, sizeof(addr4));
    CFSocketConnectToAddress(_socket, address, -1);
    
    CFRunLoopRef cfrl = CFRunLoopGetCurrent();
    CFRunLoopSourceRef source = CFSocketCreateRunLoopSource(kCFAllocatorDefault, _socket, 0);
    CFRunLoopAddSource(cfrl, source, kCFRunLoopCommonModes);
    CFRelease(source);
}

+ (void)sendSocket:(const char *)payload withIP:(const char *)ip {
    int sockfd;
    struct sockaddr_in addr;
    char buffer[256];
    memset(buffer, 0, 256);
    buffer[0] = 0x42;
    buffer[1] = 0x03;
    buffer[2] = 0x27;
    buffer[3] = 0x10;
    buffer[4] = 145;
    buffer[5] = 'l';
    buffer[6] = 1;
    buffer[7] = '0';
    
    char *point = (char *)(buffer+8);
    strcpy(point, payload);

    sockfd = socket(AF_INET,SOCK_DGRAM,0);
    NSLog(@"result:%lu",strlen(buffer));
    if( sockfd< 0){
//    　　 NSLog(@"error");
        NSLog(@"aaaaaa");
        return;
    }
    bzero(&addr, sizeof(addr));
    addr.sin_family = AF_INET;
    addr.sin_port = htons(server_port);
    addr.sin_addr.s_addr = inet_addr(ip);
    int res = sendto(sockfd,buffer,strlen(buffer),0,(struct sockaddr *)&addr,sizeof(addr));
    if (res == -1) {
        NSLog(@"error in sendto");
    }
    NSLog(@"has sended");
}

- (void) sendMessage {
//    NSString *stringToSend = [chatController.textField.text stringByAppendingString:@"\n"];
//    const char *data = [stringToSend UTF8String];
//    send(CFSocketGetNative(_socket), data, strlen(data) + 1, 0);
    
    const char *data = "aaaaa";
    // sockaddr_in 是一个struct，里面包含ip、端口等
    struct sockaddr_in addr4;
    memset(&addr4, 0, sizeof(addr4));// memset表示将地址addr4结构里面的前sizeof（）个内存地址里面的内容设置成int 0
    addr4.sin_len = sizeof(addr4);
    addr4.sin_family = AF_INET;
    addr4.sin_port = htons(server_port);
    char *addr = "192.168.11.61";
    addr4.sin_addr.s_addr = inet_addr(addr);
    sendto(CFSocketGetNative(_socket), data, strlen(data), 0, (struct sockaddr *)&addr4, sizeof(addr4) == -1);
  }

@end
