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
@end


@protocol RGSeeViewDelegate <NSObject>
- (void) finsihedSeeing:(BOOL)value;
@end
