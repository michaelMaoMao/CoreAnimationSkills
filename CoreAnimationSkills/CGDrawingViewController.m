//
//  CGDrawingViewController.m
//  CoreAnimationSkills
//
//  Created by MichaelMao on 16/4/9.
//  Copyright © 2016年 MichaelMao. All rights reserved.
//

#import "CGDrawingViewController.h"
#import "CGDrawingView.h"
#import "CGBrushStrokeView.h"

@interface CGDrawingViewController ()

@property (nonatomic, strong) UIBezierPath *path;

@property (weak, nonatomic) IBOutlet CGDrawingView *drawingView;

@property (weak, nonatomic) IBOutlet CGBrushStrokeView *brushDrawingView;

@end

@implementation CGDrawingViewController

-(void)viewDidLoad{

    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
