//
//  AMMSchoolClassCell.m
//  Curva
//
//  Created by Anthony Mace on 6/18/14.
//  Copyright (c) 2014 Amaceing Studios. All rights reserved.
//

#import "AMMSchoolClassCell.h"
#import "AMMClassCircle.h"

@implementation AMMSchoolClassCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    for (UIView *view in [self.contentView subviews]) {
        if ([view isKindOfClass:[AMMClassCircle class]]) {
           [view removeFromSuperview];
        }
    }
}

@end
