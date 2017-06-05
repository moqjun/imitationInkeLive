//
//  SXTMeInfoView.m
//  bjsxt-inke
//
//  Created by 大欢 on 16/9/7.
//  Copyright © 2016年 大欢. All rights reserved.
//

#import "SXTMeInfoView.h"
#import "SXTUserHelper.h"

@interface SXTMeInfoView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation SXTMeInfoView

+ (instancetype)loadInfoView {
    
    return  [[[NSBundle mainBundle] loadNibNamed:@"SXTMeInfoView" owner:self options:nil] lastObject];
}

-(void) awakeFromNib
{
    NSLog(@"%@",IMAGE_HOST);
    NSString *iconUrl = [SXTUserHelper sharedUser].iconUrl;
    
    [self.imageView downloadImage:[NSString stringWithFormat:@"%@",iconUrl] placeholder:@"default_room"];
    
}

-(instancetype) init
{
    self = [super init];
    if(self)
    {
        
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
