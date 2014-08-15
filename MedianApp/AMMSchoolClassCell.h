//
//  AMMSchoolClassCell.h
//  Curva
//
//  Created by Anthony Mace on 6/18/14.
//  Copyright (c) 2014 Amaceing Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMMSchoolClassCell : UITableViewCell

@property (nonatomic)  BOOL used;
@property (weak, nonatomic) IBOutlet UIView *circleView;
@property (weak, nonatomic) IBOutlet UILabel *schoolClassNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *schoolClassDetailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;
@property (weak, nonatomic) IBOutlet UILabel *decimalLabel;

@end
