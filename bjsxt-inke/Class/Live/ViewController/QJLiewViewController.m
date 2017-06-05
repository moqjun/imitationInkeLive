//
//  QJLiewViewController.m
//  bjsxt-inke
//
//  Created by mac on 2017/5/26.
//  Copyright © 2017年 大欢. All rights reserved.
//

#import "QJLiewViewController.h"

#import <AVFoundation/AVFoundation.h>


@interface QJLiewViewController ()<AVCaptureAudioDataOutputSampleBufferDelegate,AVCaptureVideoDataOutputSampleBufferDelegate>

/**采集视频*/
//切换屏幕按钮
@property (nonatomic,weak) IBOutlet UIButton *changScreenBtn;
//采集视频总控制器
@property (nonatomic,strong) AVCaptureSession *captureSession;
//视频采集输入数据源
@property (nonatomic,strong)AVCaptureDeviceInput *currentVideoDeviceInput;
//将摄像头采集数据源显示在屏幕上
@property (nonatomic,weak)AVCaptureVideoPreviewLayer *previewLayer;
//采集的截取数据流，一般用于美颜等处理

@property (nonatomic,weak)AVCaptureConnection *videoConnection;

@end

@implementation QJLiewViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_captureSession) {
        [_captureSession startRunning];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (_captureSession) {
        [_captureSession stopRunning];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupCaptureVideo];
}

/**
 音视频捕获
 */
-(void)setupCaptureVideo{
    
    _captureSession = [[AVCaptureSession alloc] init];
    
    //获取摄像头和音频
    AVCaptureDevice *videoDevice =[self getVideoDevice:AVCaptureDevicePositionFront];
    AVCaptureDevice *audioDevice =[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
//    创建对应音视频设备输入对象
    AVCaptureDeviceInput *videoDeviceInput =[AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:nil];
    AVCaptureDeviceInput *audioDeviceInput =[AVCaptureDeviceInput deviceInputWithDevice:audioDevice error:nil];
    _currentVideoDeviceInput = videoDeviceInput;
    
    if ([_captureSession canAddInput:_currentVideoDeviceInput]) {
        [_captureSession addInput:_currentVideoDeviceInput];
    }
    
    if ([_captureSession canAddInput:audioDeviceInput]) {
        [_captureSession addInput:audioDeviceInput];
    }
    
    //获取系统输出的视频源
    AVCaptureVideoDataOutput *videoOutput =[[AVCaptureVideoDataOutput alloc] init];
    AVCaptureAudioDataOutput *audioOutput =[[AVCaptureAudioDataOutput alloc] init];
    
    dispatch_queue_t videoQueue = dispatch_queue_create("videoQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t audioQueue = dispatch_queue_create("audioQueue", DISPATCH_QUEUE_SERIAL);
    
    [videoOutput setSampleBufferDelegate:self queue:videoQueue];
    [audioOutput setSampleBufferDelegate:self queue:audioQueue];
    videoOutput.videoSettings = @{(NSString*)kCVPixelBufferPixelFormatTypeKey:@(kCVPixelFormatType_32BGRA)};
    if ([_captureSession canAddOutput:videoOutput]) {
        [_captureSession addOutput: videoOutput];
    }
    if ([_captureSession canAddOutput:audioOutput]) {
        [_captureSession addOutput:audioOutput];
    }
    
    //获取视频输入和输出的链接 用于分辨音视频数据 做处理时用到
    _videoConnection = [videoOutput connectionWithMediaType:AVMediaTypeVideo];
    
    
    //将视屏数据加入视图层 显示
    AVCaptureVideoPreviewLayer  *previedLayer = [AVCaptureVideoPreviewLayer layerWithSession:_captureSession];
    previedLayer.frame = [UIScreen mainScreen].bounds;
    [self.view.layer insertSublayer:previedLayer atIndex:0];
    [self.view.layer insertSublayer:_changScreenBtn.layer atIndex:1];
    _previewLayer = previedLayer;
    
    [_captureSession startRunning];
    
}

-(AVCaptureDevice*) getVideoDevice:(AVCaptureDevicePosition) position{
    
    NSArray *devices =[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if (device.position == position) {
            return device;
        }
    }
    
    return nil;
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
