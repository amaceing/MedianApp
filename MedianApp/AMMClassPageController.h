//
//  AMMClassPageController.h
//  MedianApp
//
//  Created by Anthony Mace on 7/22/14.
//  Copyright (c) 2014 Amaceing Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMMClassPageController : UIViewController
                    <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *pageController;
@property (nonatomic) NSInteger classIndex;


@end
