//
//  AMMSchoolClassVC.h
//  MedianApp
//
//  Created by Anthony Mace on 7/22/14.
//  Copyright (c) 2014 Amaceing Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SchoolClass.h"

@interface AMMSchoolClassVC : UIViewController
        <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate,
         UIActionSheetDelegate>

@property (nonatomic) SchoolClass *schoolClass;
@property (nonatomic) NSInteger index;

@end
