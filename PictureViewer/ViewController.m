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
@property RGSeeView *mainView;
@end

@implementation ViewController
{
    BOOL tapped;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:0.25 green:0.36 blue:0.62 alpha:1];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped)];
    [self.view addGestureRecognizer:tapGesture];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.demoImageView.frame = CGRectMake(0, 0, 150, 150);
    });
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)tapped
{
    self.vc =  [[RGImageViewController alloc] init];
    self.vc.transitioningDelegate = self.vc;
    self.vc.isPresenting = YES;
    self.vc.delegate = self;
    [self presentViewController:self.vc animated:YES completion:^{
    }];

}

- (UIImageView *)sourceImageView
{
    return self.demoImageView;
}

- (void)finsihedSeeing:(BOOL)value
{

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
