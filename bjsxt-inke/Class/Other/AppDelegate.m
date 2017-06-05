//
//  AppDelegate.m
//  bjsxt-inke
//
//  Created by 大欢 on 16/9/1.
//  Copyright © 2016年 大欢. All rights reserved.
//

#import "AppDelegate.h"
#import "SXTTabBarViewController.h"
#import "SXTLocationManager.h"
#import "SXTAdvertiseView.h"
#import "AppDelegate+SXTUMeung.h"
#import "UMSocial.h"
#import "SXTLoginViewController.h"
#import "SXTUserHelper.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //初始化友盟控件
    [self setupUMeung];
    
    UIViewController * mainVC;
    
    if ([SXTUserHelper isAutoLogin]) {
        
        mainVC = [[SXTTabBarViewController alloc] init];
    } else {
        mainVC = [[SXTLoginViewController alloc] init];
    }
    
    self.window.rootViewController = mainVC;
    
    [self.window makeKeyAndVisible];
    
    SXTAdvertiseView * advertise = [SXTAdvertiseView loadAdvertiseView];
    [self.window addSubview:advertise];
    
    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logOut:) name:@"USER_LOGOUT" object:nil];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}

-(void) logOut:(NSNotification*) noti
{
    SXTLoginViewController* mainVC = [[SXTLoginViewController alloc] init];

    self.window.rootViewController = mainVC;

    [self.window makeKeyAndVisible];
}

@end
