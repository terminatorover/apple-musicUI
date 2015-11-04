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
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.finalVisualImageFrame = [self.view convertRect:self.mainView.mainImageView.frame
                                               fromView:self.mainView.mainImageView.superview];
}



- (void)finishedDismissing:(BOOL)value
{
    self.isPresenting = NO;
    [self dismissViewControllerAnimated:NO completion:^{

    }];
}


- (void)retainImagesAndImageView
{

    if ([self.delegate respondsToSelector:@selector(sourceImageView)]) {
        self.sourceImageView = [self.delegate sourceImageView];
        self.sourceImage = self.sourceImageView.image;
        self.finalImage = self.sourceImageView.image;

        if ([self.delegate respondsToSelector:@selector(finalImage)]) {//if the user of the api want's the final image to be different than what was in the orignal image view
            self.finalImage = [self.delegate sourceImage];
        }
    }
    self.mainView.mainImageView.image = self.finalImage;
}

#pragma mark - Transitioning Delegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return self ;
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
    RGImageViewController *fromViewController = (RGImageViewController *) [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController <RGImageViewControllerDelegate> *toViewController = (UIViewController <RGImageViewControllerDelegate> *) [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [self retainImagesAndImageView];

}

- (void)handlePresentation:(id<UIViewControllerContextTransitioning>)transitionContext
{

    UIView *containerView = [transitionContext containerView];

    UIViewController <RGImageViewControllerDelegate> *fromViewController = (UIViewController <RGImageViewControllerDelegate>*) [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    RGImageViewController *toViewController = (RGImageViewController *) [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [self retainImagesAndImageView];

    self.sourceImageView.hidden = YES;
    self.mainView.mainImageView.hidden = YES;

    UIView *snapShotOfOriginalImageView = [self.sourceImageView snapshotViewAfterScreenUpdates:NO];
    snapShotOfOriginalImageView.frame = [containerView convertRect:self.sourceImageView.frame fromView:self.sourceImageView.superview];

    CGRect finalImageFrame = [containerView convertRect:self.mainView.mainImageView.frame fromView:self.mainView.mainImageView.superview];

    [containerView addSubview:toViewController.view];
    [containerView addSubview:snapShotOfOriginalImageView];

    [UIView animateWithDuration:kRGImageViewControllerPresentationTime
                          delay:0
         usingSpringWithDamping:.4
          initialSpringVelocity:.6
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
                         snapShotOfOriginalImageView.frame = finalImageFrame;
                     }
                     completion:^(BOOL finished) {
                         self.mainView.mainImageView.hidden = NO;
                         [snapShotOfOriginalImageView removeFromSuperview];
                         [transitionContext completeTransition:YES];
                     }];

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
