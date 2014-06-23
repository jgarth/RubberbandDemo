//
//  MTNViewController.m
//  RubberbandDemo
//
//  Created by Joachim Garth on 20/06/2014.
//  Copyright (c) 2014 Crispy Mountain. All rights reserved.
//

#import "MTNViewController.h"
#import "BPRubberBandView.h"

@interface MTNViewController ()

@end

@implementation MTNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    BPRubberbandView *rubberBand = [[BPRubberbandView alloc] initWithLayer:nil];
    rubberBand.position = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    rubberBand.bounds = CGRectMake(50, 50, 100, 300);
//    rubberBand.backgroundColor = UIColor.blackColor.CGColor;
    [self.view.layer addSublayer:rubberBand];

//    [rubberBand setOffset:75.0f];

    NSMutableArray *rubberBandKeyFrames = [NSMutableArray array];

    for(double j = 80.0f; j >= 0.0f; j -= 1) {
        [rubberBandKeyFrames addObject:CFBridgingRelease([rubberBand pathForOffset:j])];
    }

    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    anim.values = rubberBandKeyFrames;
    anim.repeatCount = INT_MAX;
    anim.autoreverses = YES;
    anim.duration = 1.0f;

    rubberBand.path = [rubberBand pathForOffset:0.0f];

    [rubberBand addAnimation:anim forKey:@"offsetAnimation"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
