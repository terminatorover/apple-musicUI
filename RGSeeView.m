//
//  RGSeeView.m
//  PictureViewer
//
//  Created by ROBERA GELETA on 4/18/15.
//  Copyright (c) 2015 ROBERA GELETA. All rights reserved.
//

#import "RGSeeView.h"
@interface RGSeeView()
@property UIImageView *mainImageView;
@property UIPanGestureRecognizer *panRecognizer;
@end


@implementation RGSeeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self setupSubviews];
        [self setupGestureRecognizers];
    }
    return self;
}

- (void)setupSubviews
{
    _mainImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    [self addSubview:_mainImageView];
}

- (void)setupGestureRecognizers
{
    self.mainImageView.userInteractionEnabled = YES;
    _panRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanning:)];
    [self addGestureRecognizer:_panRecognizer];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _mainImageView.backgroundColor = [UIColor colorWithRed:0.32 green:0.26 blue:0.35 alpha:1];
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    CGRect mainFrame = CGRectMake(width/4, height/4, width/2, height/2);
    _mainImageView.frame = mainFrame;
    
}


- (void)handlePanning:(UIPanGestureRecognizer *)panRecognizer
{
    CGFloat yMovt = [panRecognizer translationInView:self].y;
    //move the image view along (according to the gesture)
//    self.mainImageView.center = CGPointMake(self.mainImageView.center.x, self.mainImageView.center.y + yMovt);
    switch (panRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            
            break;
        case UIGestureRecognizerStateChanged:
            
            break;
        case UIGestureRecognizerStateEnded:
            
            break;
        case UIGestureRecognizerStateCancelled:
            
            break;
        default:
            break;
    }
//    NSLog(@"%f",self.mainImageView.center.y);
//    CGFloat percentage = [self yOffsetPercentageForView:self.mainImageView inSuperView:self];
//    NSLog(@"%f",percentage);
//    [self computedTransformForView:self.mainImageView];
//    self.mainImageView.layer.transform = [self computedTransformForView:self.mainImageView];
    
      self.mainImageView.layer.transform =  [self computedTransformForView:self.mainImageView withOffset:yMovt];
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
    return 1 - ( (fabs(percent) - 50 )/ 50);
}

#pragma mark - Rotation Angle Computer
- (CGFloat)angleForYPercentage:(CGFloat)percent
{
    CGFloat finalAngle ;
    if(percent >= 80 || percent <= 20)
    {
        finalAngle = 0 ;
    }else
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
    CGFloat computedYPosition = [self yOffsetPercentageForView:view inSuperView:self withOffset:offset];
    //---->
    CGFloat computedAngle = [self angleForYPercentage:computedYPosition];
//    NSLog(@"%f : %f",computedAngle,computedYPosition);
    NSLog(@"%f, %f",computedAngle,computedYPosition);
    CATransform3D t = CATransform3DIdentity;
    t.m34 = 1.0/ -500;
    t = CATransform3DRotate(t, computedAngle, 1,0, 0);
    t = CATransform3DTranslate(t, 0, offset, 0 );
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
