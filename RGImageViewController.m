//
//  RGImageViewController.m
//  PictureViewer
//
//  Created by ROBERA GELETA on 4/21/15.
//  Copyright (c) 2015 ROBERA GELETA. All rights reserved.
//

#import "RGImageViewController.h"
#import "RGSeeView.h"

static NSInteger kRGImageViewControllerPresentationTime = 1;

@interface RGImageViewController ()<RGSeeViewDelegate>

@property RGSeeView *mainView;
@property UIImage *finalImage;
@property UIImage *sourceImage;
@property UIImageView *sourceImageView;

@property CGRect finalVisualImageFrame;

@property (nonatomic) UIImageView *movingImageView;

@end

@implementation RGImageViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self){
        self.mainView = [[RGSeeView alloc]initWithFrame:self.view.bounds];
        self.mainView.delegate = self;
        [self.view addSubview:self.mainView];

    }
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.finalVisualImageFrame = [self.view convertRect:self.mainView.mainImageView.frame
                                               fromView:self.mainView.mainImageView.superview];
}



#pragma mark - RGSeeView Delegate 

- (void)finishedDismissing:(BOOL)value
{
    [self dismissSelf];
}

- (void)finsihedSeeing:(BOOL)value
{
    [self dismissSelf];
}

- (void)dismissSelf
{
    self.isPresenting = NO;
    [self.presentingViewController  dismissViewControllerAnimated:YES
                                                       completion:^{
                                                           ///TODO:expose the completion block for the user of the API
                                                       }];
}

- (void)retainImagesAndImageView
{
    if ([self.delegate respondsToSelector:@selector(sourceImageView)]) {
        self.sourceImageView = [self.delegate sourceImageView];
        self.sourceImage = self.sourceImageView.image;
        self.finalImage = self.sourceImageView.image;
        self.sourceImageView.contentMode = UIViewContentModeScaleAspectFill;
        if ([self.delegate respondsToSelector:@selector(finalImage)]) {//if the user of the api want's the final image to be different than what was in the orignal image view
            self.finalImage = [self.delegate sourceImage];
        }
    }
    self.mainView.mainImageView.image = self.finalImage;
    self.movingImageView.image = self.finalImage;
}

#pragma mark - Transitioning Delegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return self ;
}


- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed;
{
    return self;
}

#pragma mark - Animated Transitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return kRGImageViewControllerPresentationTime;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.isPresenting) {
        [self handlePresentation:transitionContext];
    }
    else {
        [self handleDismissal:transitionContext];
    }
}


- (void)handleDismissal:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    RGImageViewController *fromViewController = (RGImageViewController *) [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController <RGImageViewControllerDelegate> *toViewController = (UIViewController <RGImageViewControllerDelegate> *) [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    [self retainImagesAndImageView];

    self.movingImageView.frame = [containerView convertRect:self.mainView.mainImageView.frame
                                                           fromView:self.mainView.mainImageView.superview];
    fromViewController.mainView.mainImageView.hidden = YES;

    [containerView addSubview:self.movingImageView];

    CGRect finalFrameInContainerView = [containerView  convertRect:self.sourceImageView.frame
                                                          fromView:self.sourceImageView.superview];

    [UIView animateWithDuration:kRGImageViewControllerPresentationTime
                          delay:0
         usingSpringWithDamping:.4
          initialSpringVelocity:.6
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.movingImageView.frame = finalFrameInContainerView;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                         self.sourceImageView.hidden = NO;
                         [self.movingImageView removeFromSuperview];

                     }];
}

- (void)handlePresentation:(id<UIViewControllerContextTransitioning>)transitionContext
{

    UIView *containerView = [transitionContext containerView];

    UIViewController <RGImageViewControllerDelegate> *fromViewController = (UIViewController <RGImageViewControllerDelegate>*) [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    RGImageViewController *toViewController = (RGImageViewController *) [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    //TODO:
    [self retainImagesAndImageView];//note calling this allows us to get the new frame of the image view dispalyed.

    self.sourceImageView.hidden = YES;
    self.mainView.mainImageView.hidden = YES;

    self.movingImageView.frame = [containerView convertRect:self.sourceImageView.frame
                                                          fromView:self.sourceImageView.superview];

    CGRect finalImageFrame = [containerView convertRect:self.mainView.mainImageView.frame
                                               fromView:self.mainView.mainImageView.superview];


    [containerView addSubview:toViewController.view];
    [containerView addSubview:self.movingImageView];

    [UIView animateWithDuration:kRGImageViewControllerPresentationTime
                          delay:0
         usingSpringWithDamping:.4
          initialSpringVelocity:.6
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.movingImageView.frame = finalImageFrame;
                         self.movingImageView.layer.cornerRadius = 7;
                         toViewController.view.backgroundColor = [UIColor clearColor];
                     }
                     completion:^(BOOL finished) {
                         self.mainView.mainImageView.hidden = NO;
                         [self.movingImageView removeFromSuperview];
                         [transitionContext completeTransition:YES];
                     }];

}


- (UIImageView *)movingImageView
{
    if (!_movingImageView) {
        _movingImageView = [[UIImageView alloc] init];
        _movingImageView.contentMode = UIViewContentModeScaleAspectFill;
        _movingImageView.clipsToBounds = YES;
    }
    return _movingImageView;
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
