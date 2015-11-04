//
//  RGSeeView.m
//  PictureViewer
//
//  Created by ROBERA GELETA on 4/18/15.
//  Copyright (c) 2015 ROBERA GELETA. All rights reserved.
//

#import "RGSeeView.h"

@interface RGSeeView()

@property UIPanGestureRecognizer *panRecognizer;

@end

@implementation RGSeeView
{
    CGFloat currentOffset;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self setupSubviews];
        [self setupGestureRecognizers];
        self.backgroundColor = [UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1];
        self.userInteractionEnabled = YES;
    }
    return self;
}


- (void)setupSubviews
{
    _mainImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    _mainImageView.layer.cornerRadius = 7;
    _mainImageView.layer.masksToBounds = YES;
    [self addSubview:_mainImageView];
    UIWindow *window = [[UIApplication sharedApplication]keyWindow];

    CGFloat width = CGRectGetWidth(window.bounds);
    CGFloat height = CGRectGetHeight(window.bounds);//self.bounds.size.height;

    CGRect mainFrame = CGRectMake(0,height/3,width, height/3) ;

    _mainImageView.frame = mainFrame;

}

- (void)setupGestureRecognizers
{
    _panRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanning:)];
    [self addGestureRecognizer:_panRecognizer];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

}


- (void)handlePanning:(UIPanGestureRecognizer *)panRecognizer
{
    CGFloat yMovt = [panRecognizer translationInView:self].y;
    //move the image view along (according to the gesture)

    switch (panRecognizer.state) {
        case UIGestureRecognizerStateBegan:
                self.mainImageView.layer.transform =  [self computedTransformForView:self.mainImageView withOffset:yMovt];
            break;
        case UIGestureRecognizerStateChanged:
                self.mainImageView.layer.transform =  [self computedTransformForView:self.mainImageView withOffset:yMovt];
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            CGFloat computedYPosition = [self yOffsetPercentageForView:self.mainImageView
                                                           inSuperView:self
                                                            withOffset:yMovt];
            if( fabs(computedYPosition - 50) > self.treshold)
            {
                BOOL up ;
                if(computedYPosition - 50 <= 0)
                {
                    up = YES;
                }else
                {
                    up = NO;
                }
        
                [self animateOutImage:up];
            }else
            {
                [self animateToCenter];
            }
            break;
        }

        default:
            break;
    }
    
    //rotate
    self.mainImageView.layer.transform =  [self computedTransformForView:self.mainImageView withOffset:yMovt];
    //fade
    CGFloat alphaChannel =[self opacityBasedOnMovingView:self.mainImageView withOffset:yMovt];
    self.backgroundColor = [UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:alphaChannel];
    
}

#pragma mark - Helpers
- (CGFloat)yOffsetPercentageForView:(UIView *)subView
                        inSuperView:(UIView *)superView
                         withOffset:(CGFloat)offset;
{
    CGFloat centerY = subView.center.y + offset;
    CGFloat superViewHeight = superView.bounds.size.height;
    return (centerY/superViewHeight) * 100;
}

- (CGFloat)opacityForYPercentage:(CGFloat)percent
{
    return 1 - fabs((percent - 50 )/ 50);
}

- (CGFloat)scaleFromYPercentageOffset:(CGFloat)percent
{
    CGFloat difference =  (fabs(percent) - 50);
    return MAX(1- (fabs(difference) * self.minScale/50),.9);
}

#pragma mark - Opacity Computer
- (CGFloat)opacityBasedOnMovingView:(UIView *)view
               withOffset:(CGFloat)offset
{
    CGFloat computedYPosition = [self yOffsetPercentageForView:view inSuperView:self withOffset:offset];
    return [self opacityForYPercentage:computedYPosition];
}


#pragma mark - Rotation Angle Computer
- (CGFloat)angleForYPercentage:(CGFloat)percent
{
    CGFloat finalAngle ;
    if(percent >= 80 || percent <= 20)
    {
        finalAngle = 0 ;
    }else if(percent <= 52 && percent >= 48.0)
    {
        finalAngle = 0;
    }
    else
    {
        CGFloat transAngle = M_PI *(percent - 50)/self.treshold;
        finalAngle = -1 * self.swingAngle * sin(transAngle);
    }
    
    return finalAngle;
}

#pragma mark - Transform Creator  

- (CATransform3D)computedTransformForView:(UIView *)view
                               withOffset:(CGFloat)offset
{
    CGFloat computedYPosition = [self yOffsetPercentageForView:view
                                                   inSuperView:self
                                                    withOffset:offset];
    //---->
    CGFloat computedAngle = [self angleForYPercentage:computedYPosition];
    CGFloat computedScale = [self scaleFromYPercentageOffset:computedYPosition];

    CATransform3D t = CATransform3DIdentity;
    t.m34 = 1.0/ -500;
    t = CATransform3DRotate(t, computedAngle, 1,0, 0);
    t = CATransform3DTranslate(t, 0, offset, 0 );
    t = CATransform3DScale(t, computedScale, computedScale, 0);
    return t;

}

- (CATransform3D)transformForYOffsetPercentage:(CGFloat)percent
{
    CGFloat computedAngle = [self angleForYPercentage:percent];
    CATransform3D t = CATransform3DIdentity;
    t.m34 = 1.0/ -500;
    t = CATransform3DRotate(t, computedAngle, 1,0, 0);
    return t;

}



- (void)animateToCenter
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.4
                              delay:0
             usingSpringWithDamping:.5
              initialSpringVelocity:6
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             NSLog(@"ANIMATED");
                             self.mainImageView.layer.transform = CATransform3DIdentity;
                             self.mainImageView.center = self.center;
                             self.backgroundColor = [UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1];
                         }
                         completion:^(BOOL finished) {
                             
                         }];
    });
}


#pragma mark - Lazy Loading
- (CGFloat)treshold
{
    if(_treshold == 0.0)
    {
        _treshold = 30.0;
    }
    return _treshold;
}

- (CGFloat)swingAngle
{
    if(_swingAngle == 0.0)
    {
        _swingAngle = 0.20;
    }
    return _swingAngle;
}

- (CGFloat)minScale
{
    if(_minScale == 0.0)
    {
        _minScale = .9;
    }
    return _minScale;
}


- (void)animateOutImage:(BOOL)up
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.03 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGRect nextFrame;
        CGFloat width = self.bounds.size.width;
        CGFloat height = self.bounds.size.height;
        if(up)
        {
            nextFrame = CGRectMake(0, -height/3,width, height/3);
        }else
        {
            nextFrame = CGRectMake(0, height,width, height/3);
        }
        
        [UIView animateWithDuration:1
                              delay:0
             usingSpringWithDamping:.4
              initialSpringVelocity:1
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.mainImageView.frame = nextFrame;
                         }
                         completion:^(BOOL finished) {
                             if(_delegate && [_delegate respondsToSelector:@selector(finishedDismissing:)])
                             {
                                 [_delegate finishedDismissing:YES];
                             }
                         }];
    });
 
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
