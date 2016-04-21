//
//  ViewController.h
//  broadCasterDemo
//
//  Created by garin on 16/4/20.
//  Copyright © 2016年 com.dangdang.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *previewView;
@property (weak, nonatomic) IBOutlet UIButton *btnConnect;
- (IBAction)btnConnectTouch:(id)sender;

- (IBAction)btnFilterTouch:(id)sender;
@end

