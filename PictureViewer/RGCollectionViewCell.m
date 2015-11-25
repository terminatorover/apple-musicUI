//
//  RGCollectionViewCell.m
//  PictureViewer
//
//  Created by Robera Geleta on 11/25/15.
//  Copyright © 2015 ROBERA GELETA. All rights reserved.
//

#import "RGCollectionViewCell.h"

@implementation RGCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self  = [super initWithFrame:frame];
    if (self) {
        self.cellImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.cellImageView];
        self.cellImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.cellImageView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        self.cellImageView.clipsToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.cellImageView.frame = self.bounds;
    self.cellImageView.layer.cornerRadius = 8;//CGRectGetWidth(self.bounds)/2.0;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.cellImageView.image = nil;
}

@end
