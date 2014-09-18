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
        
    }
    return self;
}

- (void)AddUILabels
{
    CGRect wholeNumLabel = CGRectMake(self.bounds.origin.x + 5, self.bounds.origin.y + 5, self.bounds.size.width / 3, self.bounds.size.height - 10);
    CGRect decNumLabel = CGRectMake(self.bounds.origin.x + 50, self.bounds.origin.y + 10, self.bounds.size.width / 4, self.bounds.size.height - 20);
    
    self.wholeNumberLabel.frame = wholeNumLabel;
    self.decNumberLabel.frame = decNumLabel;
    
    [self addSubview:self.wholeNumberLabel];
    [self addSubview:self.decNumberLabel];
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
