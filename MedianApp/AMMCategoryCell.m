//
//  AMMCategoryCell.m
//  Median
//
//  Created by Anthony Mace on 7/10/14.
//  Copyright (c) 2014 Amaceing Studios. All rights reserved.
//

#import "AMMCategoryCell.h"
#import "AMMGradeBar.h"
#import "UtilityMethods.h"
#import "SlantyDashedView.h"

@implementation AMMCategoryCell

- (void)awakeFromNib
{
    // Initialization code
    self.catWeight.font = [UtilityMethods latoLightFont:12];
    self.catName.font = [UtilityMethods latoLightFont:17];
    self.catGrade.font = [UtilityMethods latoLightFont:17];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    for (UIView *view in [self.catGradeLine subviews]) {
        if ([view isKindOfClass:[SlantyDashedView class]]) {
            [view removeFromSuperview];
            [view setNeedsDisplay];
        }
    }
}

@end
