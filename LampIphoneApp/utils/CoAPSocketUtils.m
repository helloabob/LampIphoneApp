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

//void mytimeout();

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
    const char *addr = "192.168.11.61";
    addr4.sin_addr.s_addr = inet_addr(addr);
    // CFDataCreate()是用来将一个申请一个sizeof()大小的内存空间，并将一个buffer中的数据拷贝到新申请的内存空间中
    CFDataRef address = CFDataCreate(kCFAllocatorDefault, (UInt8 *)&addr4, sizeof(addr4));
    CFSocketConnectToAddress(_socket, address, -1);
    
    CFRunLoopRef cfrl = CFRunLoopGetCurrent();
    CFRunLoopSourceRef source = CFSocketCreateRunLoopSource(kCFAllocatorDefault, _socket, 0);
    CFRunLoopAddSource(cfrl, source, kCFRunLoopCommonModes);
    CFRelease(source);
}

+ (NSString *)statusSocketWithIp:(const char *)ip {
    //aE'{"h":0,"m":25,"o":true,"b":128}
    if (ip == NULL || strlen(ip) < 5) {
        return nil;
    }
    int sockfd;
    sockfd = socket(AF_INET,SOCK_DGRAM,0);
    if(sockfd< 0){
        NSLog(@"error in creating socket:%d.",sockfd);
        return nil;
    }
    struct sockaddr_in addr;
    char buffer[256];
    memset(buffer, 0, 256);
    buffer[0] = 0x43;
    buffer[1] = 0x01;
    buffer[2] = 0x27;
    buffer[3] = 0x10;
    buffer[4] = 0x91;
    buffer[5] = 0x6C;
    buffer[6] = 0x01;
    buffer[7] = 0x30;
    
    buffer[8] = 0x01;
    buffer[9] = 0x73;
    
    //    char *point = (char *)(buffer+8);
    //    strcpy(point, payload);
    
    bzero(&addr, sizeof(addr));
    addr.sin_family = AF_INET;
    addr.sin_port = htons(server_port);
    addr.sin_addr.s_addr = inet_addr(ip);
    int res = sendto(sockfd,buffer,strlen(buffer),0,(struct sockaddr *)&addr,sizeof(addr));
    if (res == -1) {
        NSLog(@"error in sendto");
    }
    
    memset(buffer, 0, 255);
    //    printf("buffer%s",buffer);
    
    socklen_t addr_len = sizeof(addr);
    
//    res = recvfrom(sockfd, buffer, 255, 0, (struct sockaddr *)&addr, &addr_len);
    
    struct timeval tv;
    fd_set readfds;
    FD_ZERO(&readfds);
    FD_SET(sockfd, &readfds);
    tv.tv_sec = 1;
    tv.tv_usec = 1;
    select(sockfd+1, &readfds, NULL, NULL, &tv);
    if (FD_ISSET(sockfd, &readfds)) {
        if ((res = recvfrom(sockfd, buffer, 255, 0, (struct sockaddr *)&addr, &addr_len)) >= 0) {
        }
    }
    printf("buffer:%s",buffer);
    
    //    free(buffer);
    //    point = NULL;
    close(sockfd);
    return [NSString stringWithFormat:@"%s",buffer];
}

void mytimeout() {
    NSLog(@"aaaaa");
}

+ (NSString *)checkSocketWithIp:(const char *)ip {
    if (ip == NULL || strlen(ip) < 5) {
        return nil;
    }
    int sockfd;
    sockfd = socket(AF_INET,SOCK_DGRAM,0);
    if(sockfd< 0){
        NSLog(@"error in creating socket:%d.",sockfd);
        return nil;
    }
    struct sockaddr_in addr;
    char buffer[256];
    memset(buffer, 0, 256);
    buffer[0] = 0x42;
    buffer[1] = 0x01;
    buffer[2] = 0x27;
    buffer[3] = 0x10;
    buffer[4] = 0x9B;
    buffer[5] = 0x2E;
    buffer[6] = 0x77;
    buffer[7] = 0x65;
    
    buffer[8] = 0x6C;
    buffer[9] = 0x6C;
    buffer[10] = 0x2D;
    buffer[11] = 0x6B;
    buffer[12] = 0x6E;
    buffer[13] = 0x6F;
    buffer[14] = 0x77;
    
    buffer[15] = 0x6E;
    buffer[16] = 0x04;
    buffer[17] = 0x63;
    buffer[18] = 0x6F;
    buffer[19] = 0x72;
    buffer[20] = 0x65;
    
//    char *point = (char *)(buffer+8);
//    strcpy(point, payload);
    
    bzero(&addr, sizeof(addr));
    addr.sin_family = AF_INET;
    addr.sin_port = htons(server_port);
    addr.sin_addr.s_addr = inet_addr(ip);
    int res = sendto(sockfd,buffer,strlen(buffer),0,(struct sockaddr *)&addr,sizeof(addr));
    if (res == -1) {
        NSLog(@"error in sendto");
    }
    memset(buffer, 0, 255);
//    printf("buffer%s",buffer);
    NSLog(@"has sent message.");
    socklen_t addr_len = sizeof(addr);
//    fcntl(sockfd ,F_SETFL, O_NONBLOCK);
//    int time_out = 2000;
//    setsockopt(sockfd, SOL_SOCKET, SO_RCVTIMEO, (char *)&time_out, sizeof(time_out));
//    signal(SIGALRM, mytimeout);
    struct timeval tv;
    fd_set readfds;
    FD_ZERO(&readfds);
    FD_SET(sockfd, &readfds);
    tv.tv_sec = 1;
    tv.tv_usec = 1;
    select(sockfd+1, &readfds, NULL, NULL, &tv);
    if (FD_ISSET(sockfd, &readfds)) {
        if ((res = recvfrom(sockfd, buffer, 255, 0, (struct sockaddr *)&addr, &addr_len)) >= 0) {
        } else {
        }
    }
//    res = recvfrom(sockfd, buffer, 255, 0, (struct sockaddr *)&addr, &addr_len);
    printf("buffer:%s",buffer);
    
    //    free(buffer);
//    point = NULL;
    close(sockfd);
    return [NSString stringWithFormat:@"%s",buffer];

}



+ (void)sendSocket:(const char *)payload withIP:(const char *)ip {
    NSLog(@"operation:payload:%s and ip:%s",payload,ip);
    if (ip == NULL || strlen(ip) < 7 || payload == NULL) {
        return;
    }
    int sockfd;
    sockfd = socket(AF_INET,SOCK_DGRAM,0);
    if(sockfd< 0){
        NSLog(@"error in creating socket:%d.",sockfd);
        return;
    }
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
    
    bzero(&addr, sizeof(addr));
    addr.sin_family = AF_INET;
    addr.sin_port = htons(server_port);
    addr.sin_addr.s_addr = inet_addr(ip);
    int res = sendto(sockfd,buffer,strlen(buffer),0,(struct sockaddr *)&addr,sizeof(addr));
    if (res == -1) {
        NSLog(@"error in sendto");
    }
//    free(buffer);
    point = NULL;
    close(sockfd);
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
