//
//  AMMCategoryCell.h
//  Median
//
//  Created by Anthony Mace on 7/10/14.
//  Copyright (c) 2014 Amaceing Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMMCategoryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *catName;
@property (weak, nonatomic) IBOutlet UILabel *catGrade;
@property (weak, nonatomic) IBOutlet UILabel *catWeight;
@property (weak, nonatomic) IBOutlet UIView *catGradeLine;

@end
