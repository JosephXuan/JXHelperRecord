//
//  AppDelegate.h
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/2/23.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (assign,nonatomic)AFNetworkReachabilityStatus status;

@end

