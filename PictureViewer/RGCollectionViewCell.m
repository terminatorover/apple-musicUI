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
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.cellImageView.frame = self.bounds;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.cellImageView.image = nil;
}

@end
