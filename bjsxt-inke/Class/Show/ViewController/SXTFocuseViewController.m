//
//  SXTFocuseViewController.m
//  bjsxt-inke
//
//  Created by 大欢 on 16/9/1.
//  Copyright © 2016年 大欢. All rights reserved.
//

#import "SXTFocuseViewController.h"
#import "SXTLiveCell.h"
#import "SXTPlayerViewController.h"

#import "SXTUserHelper.h"

static NSString * identifier = @"focuse";

@interface SXTFocuseViewController ()

@property (nonatomic, strong) NSArray * datalist;

@end

@implementation SXTFocuseViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SXTLiveCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.live = self.datalist[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70 + SCREEN_WIDTH;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SXTLive * live = self.datalist[indexPath.row];
    
    SXTPlayerViewController * playerVC = [[SXTPlayerViewController alloc] init];
    playerVC.live = live;
    [self.navigationController pushViewController:playerVC animated:YES];
    
    
    /*系统自带的播放器播放不了直播内容
     
     MPMoviePlayerViewController * movieVC = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:live.streamAddr]];
     
     [self presentViewController:movieVC animated:YES completion:nil];
     */
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self loadData];
}

- (void)initUI {
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SXTLiveCell" bundle:nil] forCellReuseIdentifier:identifier];
    
}

- (void)loadData {
    
    NSString *iconUrl = [SXTUserHelper sharedUser].iconUrl;
    
   // [self.imageView downloadImage:[NSString stringWithFormat:@"%@",iconUrl] placeholder:@"default_room"];

    SXTLive * live = [[SXTLive alloc] init];
    live.city = @"深圳";
    live.onlineUsers = 1000;
    live.streamAddr = Live_Dahuan;
    
    SXTCreator * create = [[SXTCreator alloc] init];
    live.creator = create;
    
    create.nick = [SXTUserHelper sharedUser].nickName;
    create.portrait = @"default";
    
    self.datalist = @[live];
    
    [self.tableView reloadData];
}


@end
