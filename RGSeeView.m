//
//  RGSeeView.m
//  PictureViewer
//
//  Created by ROBERA GELETA on 4/18/15.
//  Copyright (c) 2015 ROBERA GELETA. All rights reserved.
//

#import "RGSeeView.h"
@interface RGSeeView()
@property UIView *mainImageView;
@end


@implementation RGSeeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _mainImageView = [[UIView alloc]initWithFrame:CGRectZero];
        [self addSubview:_mainImageView];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    _mainImageView.backgroundColor = [UIColor colorWithRed:0.32 green:0.26 blue:0.35 alpha:1];
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    CGRect mainFrame = CGRectMake(0, height/4, width, height/2);
    _mainImageView.frame = mainFrame;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
