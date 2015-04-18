//
//  ViewController.m
//  PictureViewer
//
//  Created by ROBERA GELETA on 4/18/15.
//  Copyright (c) 2015 ROBERA GELETA. All rights reserved.
//

#import "ViewController.h"
#import "RGSeeView.h"
@interface ViewController ()
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
    [self.view addSubview:self.seeView];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self animate];
    });
//   movtView = [[UIView alloc]initWithFrame:CGRectMake(30, 0, 200, 200)];
//   [self.view addSubview:movtView];
//   movtView.backgroundColor = [UIColor colorWithRed:0.35 green:0.35 blue:0.35 alpha:1];
   
   panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanning:)];
}

- (void)animate
{
    CATransform3D t = CATransform3DIdentity;
    t.m34 = 1.0/ -500;
    t = CATransform3DRotate(t, 45.0f * M_PI / 180.0f, 0, 1, 0);
    t = CATransform3DTranslate(t, 150, 0, 0);
    
    [UIView animateWithDuration:.4
                          delay:.2
         usingSpringWithDamping:.4
          initialSpringVelocity:6
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         movtView.layer.transform = t;
//                         movtView.center = CGPointMake(100, 300);
//                         movtView.frame = CGRectMake(100, 300, 200, 200);
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}
- (IBAction)slider:(UISlider *)sender {
    
    CGFloat floater = sender.value;
    CGFloat angleValue = floater * 45.0;
    CGFloat translate = 200 * floater;
    CATransform3D t = CATransform3DIdentity;
    t.m34 = 1.0/ -500;
    t = CATransform3DRotate(t, angleValue * M_PI / 180.0f, 0, 1, 0);
    t = CATransform3DTranslate(t, translate, 0, 0);
    
    movtView.layer.transform = t;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
