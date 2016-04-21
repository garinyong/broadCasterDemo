//
//  ViewController.m
//  broadCasterDemo
//
//  Created by garin on 16/4/20.
//  Copyright © 2016年 com.dangdang.com. All rights reserved.
//

#import "ViewController.h"
#import "VCSimpleSession.h"

@interface ViewController ()<VCSessionDelegate>
@property (nonatomic, retain) VCSimpleSession* session;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    NSLog(@"Screen rect:%@", NSStringFromCGRect(rect));
    [[NSUserDefaults standardUserDefaults] setValue:@"name_preference" forKey:@"test"];
    
    
    _session = [[VCSimpleSession alloc] initWithVideoSize:rect.size frameRate:30 bitrate:1000000 useInterfaceOrientation:YES];
    //    _session.orientationLocked = YES;
    [self.previewView addSubview:_session.previewView];
    _session.previewView.frame = self.previewView.bounds;
    _session.delegate = self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnConnectTouch:(id)sender {
    
    switch(_session.rtmpSessionState) {
        case VCSessionStateNone:
        case VCSessionStatePreviewStarted:
        case VCSessionStateEnded:
        case VCSessionStateError:
            [_session startRtmpSessionWithURL:@"rtmp://w.gslb.lecloud.com/live" andStreamKey:@"201604203000000yw99?sign=66d2f28a415565c0f2a56d6c7867db95&tm=20160420164247"];
            break;
        default:
            [_session endRtmpSession];
            break;
    }
    
}

- (IBAction)btnFilterTouch:(id)sender {
    
    switch (_session.filter) {
        case VCFilterNormal:
            [_session setFilter:VCFilterGray];
            break;
        case VCFilterGray:
            [_session setFilter:VCFilterInvertColors];
            break;
        case VCFilterInvertColors:
            [_session setFilter:VCFilterSepia];
            break;
        case VCFilterSepia:
            [_session setFilter:VCFilterGray];
            break;
//        case VCFilterFisheye:
//            [_session setFilter:VCFilterGlow];
//            break;
//        case VCFilterGlow:
//            [_session setFilter:VCFilterNormal];
            break;
        default:
            break;
    }
}

- (void) connectionStatusChanged:(VCSessionState) state
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        switch(state) {
            case VCSessionStateStarting:
                [self.btnConnect setTitle:@"Connecting" forState:UIControlStateNormal];
                break;
            case VCSessionStateStarted:
                [self.btnConnect setTitle:@"Disconnect" forState:UIControlStateNormal];
                break;
            default:
                [self.btnConnect setTitle:@"Connect" forState:UIControlStateNormal];
                break;
        }
        
    });
}

@end
