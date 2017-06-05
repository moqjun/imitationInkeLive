//
//  AppDelegate+SXTUMeung.m
//  bjsxt-inke
//
//  Created by 大欢 on 16/9/7.
//  Copyright © 2016年 大欢. All rights reserved.
//

#import "AppDelegate+SXTUMeung.h"
#import "UMSocial.h"
#import "UMSocialSinaSSOHandler.h"

@implementation AppDelegate (SXTUMeung)

- (void)setupUMeung {
    
    //设置umengkey
    [UMSocialData setAppKey:@"57a5581267e58e2557001639"];
    
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"2849260331"
                                              secret:@"918a9660e4078a2c19146bec93a7b767"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];

    
}

@end
