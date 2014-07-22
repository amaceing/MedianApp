//
//  AMMSchoolClassVC.m
//  MedianApp
//
//  Created by Anthony Mace on 7/21/14.
//  Copyright (c) 2014 Amaceing Studios. All rights reserved.
//

#import "AMMSchoolClassVC.h"
#import "UtilityMethods.h"

@interface AMMSchoolClassVC ()

@property (nonatomic, strong) IBOutlet UIView *header;
@property (nonatomic, strong) IBOutlet UILabel *schoolClassName;
@property (nonatomic, strong) IBOutlet UILabel *schoolClassGrade;
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

#pragma View Loading

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //Title
    self.navigationItem.title = [UtilityMethods determineSeasonAndYear];
    
    //Loading custom cells and registering for reuse
    UINib *nib = [UINib nibWithNibName:@"AMMCategoryCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"AMMCategoryCell"];
    
    //Header view
    UIView *header = self.header;
    [self.view addSubview:header];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)header
{
    if (!_header) {
        [[NSBundle mainBundle] loadNibNamed:@"AMMSemesterHeader" owner:self options:nil];
    }
    
    self.schoolClassName.font = [UtilityMethods latoLightFont:20.0];
    self.schoolClassName.textColor = [UIColor colorWithRed:30/255.0 green:178/255.0 blue:192/255.0 alpha:1];
    self.schoolClassName.text = self.schoolClass.name;
    
    self.schoolClassGrade.font = [UtilityMethods latoRegFont:29.0];
    self.schoolClassGrade.text = [NSString stringWithFormat:@"%0.1f", self.schoolClass.grade];
    self.schoolClassGrade.textColor = [UtilityMethods determineColorShown:self.schoolClass.grade];
    
    return  _header;
}

#pragma Logic



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.schoolClass.assignmentCategories count];
}


@end
