//
//  RGSeeView.h
//  PictureViewer
//
//  Created by ROBERA GELETA on 4/18/15.
//  Copyright (c) 2015 ROBERA GELETA. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RGSeeViewDelegate;

@interface RGSeeView : UIView

@property id<RGSeeViewDelegate> delegate;

//params to tweak interaction
@property (nonatomic) CGFloat treshold;
@property (nonatomic) CGFloat swingAngle;
@property (nonatomic) CGFloat minScale;
- (void)setImage:(UIImage *)image;
@property UIImageView *mainImageView;
@end


@protocol RGSeeViewDelegate <NSObject>
- (void)finsihedSeeing:(BOOL)value;
- (void)finishedDismissing:(BOOL)value;
@end
