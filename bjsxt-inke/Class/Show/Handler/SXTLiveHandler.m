//
//  SXTLiveHandler.m
//  bjsxt-inke
//
//  Created by 大欢 on 16/9/2.
//  Copyright © 2016年 大欢. All rights reserved.
//

#import "SXTLiveHandler.h"
#import "HttpTool.h"
#import "SXTLive.h"
#import "SXTLocationManager.h"
#import "SXTAdvertise.h"

@implementation SXTLiveHandler

+ (void)executeGetNearLiveTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed {
    
    SXTLocationManager * manager = [SXTLocationManager sharedManager];
    
    [manager getGps:^(NSString *lat, NSString *lon) {
        
        NSDictionary * params = @{@"uid":@"5905554575",
                                  @"latitude":lat,
                                  @"longitude":lon
                                  };
        
        [HttpTool getWithPath:API_NearLive params:params success:^(id json) {
            
            if ([json[@"dm_error"] integerValue]) {
                
                failed(json);
                
            } else {
                //如果返回信息正确
                //数据解析
                NSArray * lives =  [SXTLive mj_objectArrayWithKeyValuesArray:json[@"lives"]];
                
                success(lives);
                
            }
            
        } failure:^(NSError *error) {
            
            failed(error);
            
        }];
    }];
    //uid=5905554575&latitude=114.02921&longitude=22.654767
    
    
}

+ (void)executeGetHotLiveTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed {
    
    [HttpTool getWithPath:API_HotLive params:nil success:^(id json) {
        
        if ([json[@"dm_error"] integerValue]) {
            
            failed(json);
            
        } else {
            //如果返回信息正确
            //数据解析
            NSArray * lives =  [SXTLive mj_objectArrayWithKeyValuesArray:json[@"lives"]];

            success(lives);

        }

    } failure:^(NSError *error) {
        
        failed(error);
        
    }];
    
}

+ (void)executeGetAdvertiseTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed {
    
    [HttpTool getWithPath:API_Advertise params:nil success:^(id json) {
        
        if ([json[@"dm_error"] integerValue]) {
            
            failed(json);
            
        } else {
            //如果返回信息正确
            //数据解析
            SXTAdvertise * advertise =  [SXTAdvertise mj_objectWithKeyValues:json[@"resources"][0]];
            
            success(advertise);
        }
    } failure:^(NSError *error) {
        
        failed(error);

    }];
}

@end
