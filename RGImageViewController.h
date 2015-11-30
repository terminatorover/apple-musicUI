//
//  RGImageViewController.h
//  PictureViewer
//
//  Created by ROBERA GELETA on 4/21/15.
//  Copyright (c) 2015 ROBERA GELETA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RGImageViewControllerDelegate <NSObject>

- (UIImageView *)sourceImageView;
@optional
- (UIImage *)sourceImage;

@end

@interface RGImageViewController : UIViewController <UIViewControllerTransitioningDelegate,
                                                    UIViewControllerAnimatedTransitioning>

@property BOOL isPresenting;
@property id<RGImageViewControllerDelegate> delegate;
@end


