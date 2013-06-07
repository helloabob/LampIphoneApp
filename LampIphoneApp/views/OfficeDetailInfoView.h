//
//  OfficeDetailInfoView.h
//  LampIphoneApp
//
//  Created by wangbo on 13-6-6.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OfficeDetailInfoViewDelegate <NSObject>

@required
- (void)viewDidClose;

- (void)dimmingDidChangeValue:(int)value forName:(NSString *)lightName;

@end

@interface OfficeDetailInfoView : UIView {
    UILabel *lblDeviceName;
    UILabel *lblPower;
    UILabel *lblDimming;
    UILabel *lblRunning;
    UISlider *slider;
}

@property (strong, nonatomic) NSString *ip_address;

@property (nonatomic, assign) id<OfficeDetailInfoViewDelegate>delegate;

- (void)updateControlInfo:(NSDictionary *)userInfo;

- (void)showWithAnimated:(BOOL)animated;

- (void)hideWithAnimated:(BOOL)animated;

@end


