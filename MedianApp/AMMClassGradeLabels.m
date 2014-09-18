//
//  AMMClassGradeLabels.m
//  MedianApp
//
//  Created by Anthony Mace on 9/17/14.
//  Copyright (c) 2014 Amaceing Studios. All rights reserved.
//

#import "AMMClassGradeLabels.h"
#import "UtilityMethods.h"

@implementation AMMClassGradeLabels

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self AddUILabels];
    }
    return self;
}

- (void)viewWillAppear
{
    
}

- (void)AddUILabels
{
    [self.wholeNumberLabel setNeedsDisplay];
    [self.decNumberLabel setNeedsDisplay];
    [self addSubview:self.wholeNumberLabel];
    [self addSubview:self.decNumberLabel];
}

- (UILabel *)wholeNumberLabel
{
    CGRect wholeNumLabel = CGRectMake(15, 11, 143, 70);
    if (!_wholeNumberLabel) {
        _wholeNumberLabel = [[UILabel alloc] initWithFrame:wholeNumLabel];
    }
    _wholeNumberLabel.textAlignment = NSTextAlignmentRight;
    return  _wholeNumberLabel;
}

- (UILabel *)decNumberLabel
{
    CGRect decNumLabel = CGRectMake(157, 20, 77, 65);
    if (!_decNumberLabel) {
        _decNumberLabel = [[UILabel alloc] initWithFrame:decNumLabel];
    }
    _decNumberLabel.textAlignment = NSTextAlignmentLeft;
    return _decNumberLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
