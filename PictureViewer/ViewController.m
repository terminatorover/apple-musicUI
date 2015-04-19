//
//  ViewController.m
//  PictureViewer
//
//  Created by ROBERA GELETA on 4/18/15.
//  Copyright (c) 2015 ROBERA GELETA. All rights reserved.
//

#import "ViewController.h"
#import "RGSeeView.h"
@interface ViewController ()<RGSeeViewDelegate>
@property RGSeeView *seeView;
@end

@implementation ViewController
{
    UIView *movtView;
    UIPanGestureRecognizer *panGesture;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.seeView = [[RGSeeView alloc]initWithFrame:self.view.bounds];
    self.seeView.delegate = self;
    [self.view addSubview:self.seeView];
}

- (void)finsihedSeeing:(BOOL)value
{
    [UIView animateWithDuration:.4
                          delay:.2
         usingSpringWithDamping:.4
          initialSpringVelocity:6
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.seeView.transform = CGAffineTransformMakeScale(.01, .01);
                     }
                     completion:^(BOOL finished) {
                         
                     }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.4
                              delay:.2
             usingSpringWithDamping:.4
              initialSpringVelocity:6
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.seeView.transform = CGAffineTransformIdentity;
                         }
                         completion:^(BOOL finished) {
                             
                         }];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
