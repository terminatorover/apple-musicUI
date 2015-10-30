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
@property UIImage *sourceImage;
@property UIImageView *sourceImageView;

@property CGRect finalVisualImageFrame;
@end

@implementation RGImageViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self){
        self.mainView.delegate = self;
        [self.view addSubview:self.mainView];


        if ([self.delegate respondsToSelector:@selector(sourceImageView)]) {
            self.sourceImageView = [self.delegate sourceImageView];
            self.sourceImage = self.sourceImageView.image;

            if ([self.delegate respondsToSelector:@selector(sourceImage)]) {//if the user of the api want's the final image to be different than what was in the orignal image view
                self.sourceImage = [self.delegate sourceImage];
            }
        }
        self.mainView.mainImageView.image = self.sourceImage;
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
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}


#pragma mark - Transitioning

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
    UIViewController <RGImageViewControllerDelegate> *fromViewController = (UIViewController <RGImageViewControllerDelegate>*) [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    RGImageViewController *toViewController = (RGImageViewController *) [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    
}

- (void)handlePresentation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    RGImageViewController *fromViewController = (RGImageViewController *) [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController <RGImageViewControllerDelegate> *toViewController = (UIViewController <RGImageViewControllerDelegate> *) [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];


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
