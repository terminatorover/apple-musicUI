//
//  ViewController.m
//  PictureViewer
//
//  Created by ROBERA GELETA on 4/18/15.
//  Copyright (c) 2015 ROBERA GELETA. All rights reserved.
//

#import "ViewController.h"
#import "RGSeeView.h"
#import "RGImageViewController.h"
@interface ViewController ()<RGImageViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *demoImageView;
@property RGImageViewController *vc;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.vc =  [[RGImageViewController alloc]init];
        self.vc.transitioningDelegate = self.vc;
        self.vc.isPresenting = YES;
        self.vc.delegate = self;
        [self presentViewController:self.vc animated:YES completion:^{
        }];
    });

}



//- (UIImage *)sourceImage
//{
//
//}

- (UIImageView *)sourceImageView
{
    return self.demoImageView;
}

- (void)finsihedSeeing:(BOOL)value
{
//    [UIView animateWithDuration:.4
//                          delay:.2
//         usingSpringWithDamping:.4
//          initialSpringVelocity:6
//                        options:UIViewAnimationOptionCurveEaseInOut
//                     animations:^{
//                         self.seeView.transform = CGAffineTransformMakeScale(.01, .01);
//                     }
//                     completion:^(BOOL finished) {
//                         
//                     }];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [UIView animateWithDuration:.4
//                              delay:.2
//             usingSpringWithDamping:.4
//              initialSpringVelocity:6
//                            options:UIViewAnimationOptionCurveEaseInOut
//                         animations:^{
//                             self.seeView.transform = CGAffineTransformIdentity;
//                         }
//                         completion:^(BOOL finished) {
//                             
//                         }];
//    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)present:(id)sender {
    self.vc =  [[RGImageViewController alloc]init];
    [self presentViewController:self.vc animated:NO completion:^{
    }];
}

@end
