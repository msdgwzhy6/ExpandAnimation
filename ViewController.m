//
//  ViewController.m
//  ExpandAnimation
//
//  Created by wuxueying on 8/17/15.
//  Copyright (c) 2015 xueying wu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) CAShapeLayer *shapeCircle;
@property (weak, nonatomic) IBOutlet UIButton *button;
@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addShapeCircle];
}

- (IBAction)show:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    if (sender.isSelected) {
        [CATransaction begin];
        [_shapeCircle removeAnimationForKey:@"scaleDown"];
        
        CABasicAnimation *scaleAnimation = [self animateKeyPath:@"transform.scale"
                                                      fromValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0001, 0.0001, 0.0001)]
                                                        toValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]
                                                         timing:kCAMediaTimingFunctionEaseIn];
        [_shapeCircle addAnimation:scaleAnimation forKey:@"scaleUp"];
        [CATransaction commit];
    } else {
        [CATransaction begin];
        [_shapeCircle removeAnimationForKey:@"scaleUp"];
        
        CABasicAnimation *scaleAnimation = [self animateKeyPath:@"transform.scale"
                                                      fromValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]
                                                        toValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0001, 0.0001, 0.0001)]
                                                         timing:kCAMediaTimingFunctionEaseOut];
        [_shapeCircle addAnimation:scaleAnimation forKey:@"scaleDown"];
        [CATransaction commit];
    }
}

- (void)addShapeCircle {
    _shapeCircle = [CAShapeLayer layer];
    _shapeCircle.fillColor = [UIColor colorWithRed:0.078 green:0.196 blue:0.314 alpha:1.000].CGColor;
    _shapeCircle.transform = CATransform3DMakeScale(0.0001, 0.0001, 0.0001);
    [self.view.layer insertSublayer:_shapeCircle atIndex:0];
    
    CGFloat x = CGRectGetWidth(self.view.frame);
    CGFloat y = CGRectGetHeight(self.view.frame);
    CGFloat radius = sqrt(x * x + y * y);
    
    _shapeCircle.frame = CGRectMake(x/2 - radius,
                                    y - 65 - radius,
                                    radius * 2,
                                    radius * 2);
    
    _shapeCircle.anchorPoint = CGPointMake(0.5, 0.5);
    _shapeCircle.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,
                                                                          0,
                                                                          radius * 2,
                                                                          radius * 2)].CGPath;
}

- (CABasicAnimation *)animateKeyPath:(NSString *)keyPath fromValue:(id)from toValue:(id)to timing:(NSString *)timing {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.fromValue = from;
    animation.toValue = to;
    animation.repeatCount = 1;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:timing];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 0.6;
    return animation;
}

@end
