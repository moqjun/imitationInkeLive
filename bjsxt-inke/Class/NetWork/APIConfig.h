//
//  APIConfig.h
//  bjsxt-inke
//
//  Created by 大欢 on 16/9/2.
//  Copyright © 2016年 大欢. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIConfig : NSObject

//信息类服务器地址
#define SERVER_HOST @"http://service.ingkee.com"

//图片服务器地址
#define IMAGE_HOST @"http://img.meelive.cn/"


//热门直播
#define API_HotLive @"api/live/gettop"
//http://www.inke.cn/hotlive_list.html

//附近的人
#define API_NearLive @"api/live/near_recommend" //?uid=5905554575&latitude=114.02921&longitude=22.654767

//114.02921,22.654767

//广告地址
#define API_Advertise @"advertise/get"


//欢哥直播地址
#define Live_Dahuan @"rtmp://live.hkstv.hk.lxdns.com:1935/live/dahuan"

//rtmp://istream7.a8.com/live/1494902704070388

@end
