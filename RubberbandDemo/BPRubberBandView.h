//
//  BPReverseRubberBandView.h
//  Blimp
//
//  Created by Christian Weyer on 24/04/14.
//  Copyright (c) 2014 Crispy Mountain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPRubberbandView : CAShapeLayer

@property (strong, nonatomic) CAShapeLayer* heartshapeLayer;
@property (assign, nonatomic) float offset;

- (CGPathRef)pathForOffset:(float)offset;
- (void)setOffset:(float)theOffset;
- (void)reset;

@end
