//
//  AMMClassPageController.m
//  MedianApp
//
//  Created by Anthony Mace on 7/22/14.
//  Copyright (c) 2014 Amaceing Studios. All rights reserved.
//

#import "AMMClassPageController.h"
#import "AMMSchoolClassVC.h"
#import "AMMClassStore.h"
#import "UtilityMethods.h"

@interface AMMClassPageController ()

@end

@implementation AMMClassPageController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //Title
    self.navigationItem.title = [UtilityMethods determineSeasonAndYear];
    
    //Page View Controller
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
                                                          navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                        options:nil];
    self.pageController.dataSource = self;
    self.pageController.delegate = self;
    
    AMMSchoolClassVC *initialViewController = [self viewControllerAtIndex:self.classIndex];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpBackButton
{
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = back;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //Done button setup
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = doneButton;
}

#pragma PageViewController

- (AMMSchoolClassVC *)viewControllerAtIndex:(NSUInteger)index
{
    AMMSchoolClassVC *childViewController = [[AMMSchoolClassVC alloc] initWithNibName:@"AMMSchoolClassVC" bundle:nil];
    SchoolClass *sc = [[[AMMClassStore classStore] allClasses] objectAtIndex:index];
    childViewController.schoolClass = sc;
    childViewController.index = index;
    return childViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(AMMSchoolClassVC *)viewController index];
    
    if (index == 0) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(AMMSchoolClassVC *)viewController index];
    NSInteger classCount = [[[AMMClassStore classStore] allClasses] count];
    
    index++;
    
    if (index == classCount) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
