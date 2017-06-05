//
//  SXTLaunchViewController.m
//  bjsxt-inke
//
//  Created by 大欢 on 16/9/1.
//  Copyright © 2016年 大欢. All rights reserved.
//

#import "SXTLaunchViewController.h"
#import "LFLivePreview.h"

#import "QJLiewViewController.h"

@interface SXTLaunchViewController ()

@end

@implementation SXTLaunchViewController

- (IBAction)closeLaunch:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)startLive:(id)sender {
    
    UIView * backview = [[UIView alloc] initWithFrame:self.view.bounds];
    backview.backgroundColor = [UIColor blackColor];
    [self.view addSubview:backview];
    
    LFLivePreview * preView = [[LFLivePreview alloc] initWithFrame:self.view.bounds];
    preView.vc = self;
    [self.view addSubview:preView];
    //开启直播
    [preView startLive];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
