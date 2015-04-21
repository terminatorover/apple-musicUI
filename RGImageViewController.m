//
//  RGImageViewController.m
//  PictureViewer
//
//  Created by ROBERA GELETA on 4/21/15.
//  Copyright (c) 2015 ROBERA GELETA. All rights reserved.
//

#import "RGImageViewController.h"
#import "RGSeeView.h"
@interface RGImageViewController ()<RGSeeViewDelegate>
@property RGSeeView *mainView;
@end

@implementation RGImageViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 
    if(self){
       
        [self  setModalPresentationStyle:UIModalPresentationOverCurrentContext];
        self.mainView = [[RGSeeView alloc]init];
        self.mainView.delegate = self;
        [self.view addSubview:self.mainView];
        
        //TODO - REMOVE and expose api to set image for the view controller
        UIImage *image = [UIImage imageNamed:@"i3"];
        [self.mainView setImage:image];

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
    self.mainView.frame = self.view.bounds;
    self.mainView.transform = CGAffineTransformMakeScale(0.001, 0.001);
    [UIView animateWithDuration:.4
                          delay:.2
         usingSpringWithDamping:.4
          initialSpringVelocity:6
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                        self.view.backgroundColor = [UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1];
                         self.mainView.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                         self.view.backgroundColor = [UIColor clearColor];
                     }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)finsihedSeeing:(BOOL)value
//{
//    [self dismissViewControllerAnimated:NO completion:^{
//        
//    }];
//}

- (void)finishedDismissing:(BOOL)value
{
    [self dismissViewControllerAnimated:NO completion:^{
        
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
