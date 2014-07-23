//
//  AMMSchoolClassVC.m
//  MedianApp
//
//  Created by Anthony Mace on 7/22/14.
//  Copyright (c) 2014 Amaceing Studios. All rights reserved.
//

#import "AMMSchoolClassVC.h"
#import "UtilityMethods.h"

@interface AMMSchoolClassVC ()

@property (nonatomic, strong) IBOutlet UIView *header;
@property (nonatomic, strong) IBOutlet UILabel *schoolClassName;
@property (nonatomic, strong) IBOutlet UILabel *schoolClassGrade;
@property (nonatomic, strong) IBOutlet UIButton *addCat;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end

@implementation AMMSchoolClassVC

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
    // Do any additional setup after loading the view from its nib.
    
    //Header
    [self setHeader:self.header];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)header
{
    //Font
    self.schoolClassName.font = [UtilityMethods latoLightFont:20];
    self.schoolClassGrade.font = [UtilityMethods latoLightFont:30];
    
    //Text
    self.schoolClassName.text = self.schoolClass.name;
    self.schoolClassGrade.text = [NSString stringWithFormat:@"%0.1f", self.schoolClass.grade];
    
    //Color
    self.schoolClassName.textColor = [UIColor colorWithRed:30/255.0
                                                     green:178/255.0
                                                      blue:192/255.0
                                                     alpha:1];
    self.schoolClassGrade.textColor = [UtilityMethods determineColorShown:self.schoolClass.grade];
    [self.addCat setTitleColor:[UIColor colorWithRed:30/255.0
                                               green:178/255.0
                                                blue:192/255.0
                                               alpha:1] forState:UIControlStateNormal];
    
    return _header;
}

@end
