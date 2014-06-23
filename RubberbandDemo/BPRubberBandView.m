//
//  BPReverseRubberBandView.m
//  Blimp
//
//  Created by Christian Weyer on 24/04/14.
//  Copyright (c) 2014 Crispy Mountain. All rights reserved.
//

#import "BPRubberBandView.h"
#define SCALE 1.5

@interface BPRubberbandView ()
{
    float _offset;
}

@end

@implementation BPRubberbandView

@dynamic offset;

static inline CGFloat lerp(CGFloat a, CGFloat b, CGFloat p)
{
    return a + (b - a) * p;
}

+ (BOOL)needsDisplayForKey:(NSString *)key
{
    if([key isEqualToString:@"offset"]) {
        return YES;
    } else {
        return [super needsDisplayForKey:key];
    }
}

- (id)initWithLayer:(id)layer
{
    if(self = [super initWithLayer:layer]) {
        self.fillColor = [UIColor redColor].CGColor;
        self.strokeColor = [[UIColor redColor] CGColor];
        self.position = CGPointMake(CGRectGetMidX(self.bounds), 17);
        self.opacity = 1;
        // Hole
        [self setFillRule:kCAFillRuleEvenOdd];

    }

    return self;
}

- (void)display
{
    NSLog(@"DISPLAYING! Offset: %g - bounds: %@", [self.presentationLayer offset], NSStringFromCGRect(self.bounds));
}

//    self.heartshapeLayer = [CAShapeLayer layer];
//    self.heartshapeLayer.fillColor = [[UIColor redColor] CGColor];
//    self.heartshapeLayer.strokeColor = [[UIColor redColor] CGColor];
//    self.heartshapeLayer.lineWidth = 0;
//    self.heartshapeLayer.position = CGPointMake(CGRectGetMidX(self.bounds), 17);
//    self.heartshapeLayer.opacity = 1;
//

- (float)offset
{
    return _offset;
}

- (void)setOffset:(float)offset
{
    _offset = offset;
    NSLog(@"%@ setting offset: %g", self, offset);
}

- (CGPathRef)pathForOffset:(float)offset
{
    float morphOffset;
    offset = offset / 3.5;
    morphOffset = offset;

//    self.opacity = MIN(offset, 0.85f) / 2;

    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPoint top = CGPointMake(0, 0);
    CGPoint bottom = CGPointMake(0, (morphOffset * 4.5 * SCALE));
    
    CGFloat topRadius = (15 * SCALE) - (morphOffset * 0.6 * SCALE);
    CGFloat bottomRadius =  (15 * SCALE) - (morphOffset * 0.2 * SCALE);

    // Top
    CGPathAddArc(path, NULL, top.x, top.y, topRadius, 0, M_PI, YES);
    
    // Left Curve
    CGPoint leftCp1 = CGPointMake(lerp((top.x - topRadius), (bottom.x - bottomRadius), 0.3), lerp(top.y, bottom.y, 0.8));
    CGPoint leftCp2 = CGPointMake(lerp((top.x - topRadius), (bottom.x - bottomRadius), 0.7), lerp(top.y, bottom.y, 0.8));
    CGPoint leftDestination = CGPointMake(bottom.x - bottomRadius, bottom.y);
    
    CGPathAddCurveToPoint(path, NULL, leftCp1.x, leftCp1.y, leftCp2.x, leftCp2.y, leftDestination.x, leftDestination.y);
    
    // Bottom
    CGPathAddArc(path, NULL, bottom.x, bottom.y, bottomRadius, M_PI, 0, YES);
    
    //Right curve
    CGPoint rightCp2 = CGPointMake(lerp((top.x + topRadius), (bottom.x + bottomRadius), 0.7), lerp(top.y, bottom.y, 0.8));
    CGPoint rightCp1 = CGPointMake(lerp((top.x + topRadius), (bottom.x + bottomRadius), 0.3), lerp(top.y, bottom.y, 0.8));
    CGPoint rightDestination = CGPointMake(top.x + topRadius, top.y);
    
    CGPathAddCurveToPoint(path, NULL, rightCp2.x, rightCp2.y, rightCp1.x, rightCp1.y, rightDestination.x, rightDestination.y);
    
    // The Heart
    CGFloat hs = (SCALE / 6) - (morphOffset / 300); // SCALE
    CGFloat hoX = -12 + (morphOffset / 8.5 * SCALE);  // Horizontal offset
    CGFloat hoY = -11 + (morphOffset * 4.5 * SCALE);  // Vertical offset
    
    CGPathMoveToPoint(path, NULL, 70.664001 * hs + hoX, 0.000000 * hs + hoY);
    CGPathAddLineToPoint(path, NULL, 70.493004 * hs + hoX, 0.001000 * hs + hoY);
    CGPathAddCurveToPoint(path, NULL, 62.847000 * hs + hoX, 0.037000 * hs + hoY, 55.534000 * hs + hoX, 3.563000 * hs + hoY, 50.000000 * hs + hoX, 10.937000 * hs + hoY);
    CGPathAddCurveToPoint(path, NULL, 44.466999 * hs + hoX, 3.563000 * hs + hoY, 37.153999 * hs + hoX, 0.037000 * hs + hoY, 29.507999 * hs + hoX, 0.001000 * hs + hoY);
    CGPathAddLineToPoint(path, NULL, 29.337000 * hs + hoX, 0.000000 * hs + hoY);
    CGPathAddCurveToPoint(path, NULL, 11.377000 * hs + hoX, 0.000000 * hs + hoY, 0.000000 * hs + hoX, 13.369000 * hs + hoY, 0.000000 * hs + hoX, 32.509998 * hs + hoY);
    CGPathAddCurveToPoint(path, NULL, 0.000000 * hs + hoX, 47.168999 * hs + hoY, 12.511000 * hs + hoX, 63.885998 * hs + hoY, 27.292000 * hs + hoX, 76.339996 * hs + hoY);
    CGPathAddCurveToPoint(path, NULL, 38.873001 * hs + hoX, 86.098999 * hs + hoY, 47.346001 * hs + hoX, 98.646004 * hs + hoY, 50.000000 * hs + hoX, 100.000000 * hs + hoY);
    CGPathAddCurveToPoint(path, NULL, 52.653000 * hs + hoX, 98.646004 * hs + hoY, 61.127998 * hs + hoX, 86.098999 * hs + hoY, 72.709000 * hs + hoX, 76.339996 * hs + hoY);
    CGPathAddCurveToPoint(path, NULL, 87.489998 * hs + hoX, 63.887001 * hs + hoY, 100.000000 * hs + hoX, 47.168999 * hs + hoY, 100.000000 * hs + hoX, 32.509998 * hs + hoY);
    CGPathAddCurveToPoint(path, NULL, 100.000000 * hs + hoX, 13.369000 * hs + hoY, 88.621002 * hs + hoX, 0.000000 * hs + hoY, 70.664001 * hs + hoX, 0.000000 * hs + hoY);
    CGPathCloseSubpath(path);
    CGPathMoveToPoint(path, NULL, 27.355000 * hs + hoX, 12.076000 * hs + hoY);
    CGPathAddCurveToPoint(path, NULL, 18.429001 * hs + hoX, 12.076000 * hs + hoY, 11.629000 * hs + hoX, 20.896000 * hs + hoY, 11.629000 * hs + hoX, 29.880001 * hs + hoY);
    CGPathAddLineToPoint(path, NULL, 11.629000 * hs + hoX, 29.887001 * hs + hoY);
    CGPathAddCurveToPoint(path, NULL, 11.629000 * hs + hoX, 30.856001 * hs + hoY, 10.815000 * hs + hoX, 31.646002 * hs + hoY, 9.815000 * hs + hoX, 31.646002 * hs + hoY);
    CGPathAddCurveToPoint(path, NULL, 8.817000 * hs + hoX, 31.646000 * hs + hoY, 8.000000 * hs + hoX, 30.855000 * hs + hoY, 8.000000 * hs + hoX, 29.886999 * hs + hoY);
    CGPathAddLineToPoint(path, NULL, 8.000000 * hs + hoX, 29.879999 * hs + hoY);
    CGPathAddCurveToPoint(path, NULL, 8.000000 * hs + hoX, 19.771000 * hs + hoY, 14.180000 * hs + hoX, 8.557000 * hs + hoY, 27.355000 * hs + hoX, 8.557000 * hs + hoY);
    CGPathAddCurveToPoint(path, NULL, 28.355999 * hs + hoX, 8.557000 * hs + hoY, 29.168999 * hs + hoX, 9.347000 * hs + hoY, 29.168999 * hs + hoX, 10.316000 * hs + hoY);
    CGPathAddCurveToPoint(path, NULL, 29.170000 * hs + hoX, 11.289000 * hs + hoY, 28.356001 * hs + hoX, 12.076000 * hs + hoY, 27.355000 * hs + hoX, 12.076000 * hs + hoY);
    CGPathCloseSubpath(path);
    
    return path;
}

- (void)completeDragWithOffset:(float)offset
{
    // The Heart
    offset = offset / 3.5;
    
    CGFloat hs = (SCALE / 6) - (offset / 300);  // SCALE
    CGFloat hoX = -12 + (offset / 8.5 * SCALE); // Horizontal offset
    CGFloat hoY = -11 + (offset * 4.5 * SCALE); // Vertical offset
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, 70.664001 * hs + hoX, 0.000000 * hs + hoY);
    CGPathAddLineToPoint(path, NULL, 70.493004 * hs + hoX, 0.001000 * hs + hoY);
    CGPathAddCurveToPoint(path, NULL, 62.847000 * hs + hoX, 0.037000 * hs + hoY, 55.534000 * hs + hoX, 3.563000 * hs + hoY, 50.000000 * hs + hoX, 10.937000 * hs + hoY);
    CGPathAddCurveToPoint(path, NULL, 44.466999 * hs + hoX, 3.563000 * hs + hoY, 37.153999 * hs + hoX, 0.037000 * hs + hoY, 29.507999 * hs + hoX, 0.001000 * hs + hoY);
    CGPathAddLineToPoint(path, NULL, 29.337000 * hs + hoX, 0.000000 * hs + hoY);
    CGPathAddCurveToPoint(path, NULL, 11.377000 * hs + hoX, 0.000000 * hs + hoY, 0.000000 * hs + hoX, 13.369000 * hs + hoY, 0.000000 * hs + hoX, 32.509998 * hs + hoY);
    CGPathAddCurveToPoint(path, NULL, 0.000000 * hs + hoX, 47.168999 * hs + hoY, 12.511000 * hs + hoX, 63.885998 * hs + hoY, 27.292000 * hs + hoX, 76.339996 * hs + hoY);
    CGPathAddCurveToPoint(path, NULL, 38.873001 * hs + hoX, 86.098999 * hs + hoY, 47.346001 * hs + hoX, 98.646004 * hs + hoY, 50.000000 * hs + hoX, 100.000000 * hs + hoY);
    CGPathAddCurveToPoint(path, NULL, 52.653000 * hs + hoX, 98.646004 * hs + hoY, 61.127998 * hs + hoX, 86.098999 * hs + hoY, 72.709000 * hs + hoX, 76.339996 * hs + hoY);
    CGPathAddCurveToPoint(path, NULL, 87.489998 * hs + hoX, 63.887001 * hs + hoY, 100.000000 * hs + hoX, 47.168999 * hs + hoY, 100.000000 * hs + hoX, 32.509998 * hs + hoY);
    CGPathAddCurveToPoint(path, NULL, 100.000000 * hs + hoX, 13.369000 * hs + hoY, 88.621002 * hs + hoX, 0.000000 * hs + hoY, 70.664001 * hs + hoX, 0.000000 * hs + hoY);
    CGPathCloseSubpath(path);
    CGPathMoveToPoint(path, NULL, 27.355000 * hs + hoX, 12.076000 * hs + hoY);
    CGPathAddCurveToPoint(path, NULL, 18.429001 * hs + hoX, 12.076000 * hs + hoY, 11.629000 * hs + hoX, 20.896000 * hs + hoY, 11.629000 * hs + hoX, 29.880001 * hs + hoY);
    CGPathAddLineToPoint(path, NULL, 11.629000 * hs + hoX, 29.887001 * hs + hoY);
    CGPathAddCurveToPoint(path, NULL, 11.629000 * hs + hoX, 30.856001 * hs + hoY, 10.815000 * hs + hoX, 31.646002 * hs + hoY, 9.815000 * hs + hoX, 31.646002 * hs + hoY);
    CGPathAddCurveToPoint(path, NULL, 8.817000 * hs + hoX, 31.646000 * hs + hoY, 8.000000 * hs + hoX, 30.855000 * hs + hoY, 8.000000 * hs + hoX, 29.886999 * hs + hoY);
    CGPathAddLineToPoint(path, NULL, 8.000000 * hs + hoX, 29.879999 * hs + hoY);
    CGPathAddCurveToPoint(path, NULL, 8.000000 * hs + hoX, 19.771000 * hs + hoY, 14.180000 * hs + hoX, 8.557000 * hs + hoY, 27.355000 * hs + hoX, 8.557000 * hs + hoY);
    CGPathAddCurveToPoint(path, NULL, 28.355999 * hs + hoX, 8.557000 * hs + hoY, 29.168999 * hs + hoX, 9.347000 * hs + hoY, 29.168999 * hs + hoX, 10.316000 * hs + hoY);
    CGPathAddCurveToPoint(path, NULL, 29.170000 * hs + hoX, 11.289000 * hs + hoY, 28.356001 * hs + hoX, 12.076000 * hs + hoY, 27.355000 * hs + hoX, 12.076000 * hs + hoY);
    CGPathCloseSubpath(path);
    
    // Draw the heart where it currently is as a separate path
    self.heartshapeLayer.path = path;
    CGPathRelease(path);

    CGMutablePathRef thePath = CGPathCreateMutable();
    CGPathMoveToPoint(thePath, NULL, CGRectGetMidX([self bounds]), offset);
    CGPathAddLineToPoint(thePath, NULL, CGRectGetMidX([self bounds]), 520);

    self.heartshapeLayer.anchorPoint = CGPointMake(CGRectGetMidX([self frame]), 800);

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    animation.fromValue = [NSNumber numberWithFloat:1.00];
    animation.toValue = [NSNumber numberWithFloat:100.00];
    [animation setDuration:10.0f];
    
    [animation setFillMode:kCAFillModeForwards];
    [animation setRemovedOnCompletion:NO];
    
    [self.heartshapeLayer  addAnimation:animation forKey:@"transform.scale"];

}

- (void)reset
{
    CABasicAnimation *flash = [CABasicAnimation animationWithKeyPath:@"opacity"];
    flash.fromValue = @(self.opacity);
    flash.toValue = [NSNumber numberWithFloat:0.0];
    flash.duration = 1.0;        // 1 second
    flash.autoreverses = NO;     // Back
    flash.repeatCount = 0;       // Or whatever

    self.opacity = 0.0f;

    [self addAnimation:flash forKey:@"opacity"];
}

@end