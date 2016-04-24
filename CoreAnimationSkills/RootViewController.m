//
//  RootViewController.m
//  CALayerDemo
//
//  Created by MichaelMao on 16/4/8.
//  Copyright © 2016年 gegejia. All rights reserved.
//

#import "RootViewController.h"
@import AVFoundation;

@interface RootViewController ()

@property (weak, nonatomic) IBOutlet UIView *tableHeaderView;
@end

@implementation RootViewController

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    NSLog(@"viewWillAppear");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self playVideoLayer];
}

- (void)playVideoLayer{
    //get video URL
    NSURL *URL = [[NSBundle mainBundle] URLForResource:@"Starcraft2_HeartOfTheSwarmCG" withExtension:@"mp4"];
    
    //create player and player layer
    AVPlayer *player = [AVPlayer playerWithURL:URL];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    //set player layer frame and attach it to our view
    playerLayer.frame = self.tableHeaderView.bounds;
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.tableHeaderView.layer addSublayer:playerLayer];
    
    //play the video
    [player play];
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
