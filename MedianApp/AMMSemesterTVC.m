//
//  AMMSemesterTVC.m
//  MedianApp
//
//  Created by Anthony Mace on 7/16/14.
//  Copyright (c) 2014 Amaceing Studios. All rights reserved.
//

#import "AMMSemesterTVC.h"
#import "AMMClassStore.h"
#import "AMMSchoolClassCell.h"
#import "AMMClassCircle.h"
#import "AMMNewClass.h"
#import "UtilityMethods.h"
#import "AMMClassPageController.h"
#import "NSString+AMMSeasonAndYear.h"
#import "UIFont+AMMLatoFonts.h"


@interface AMMSemesterTVC ()

@property (nonatomic, strong) IBOutlet UIView *header;
@property (nonatomic, strong) IBOutlet UILabel *seasonTitle;

@end

@implementation AMMSemesterTVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View loading methods

- (void)viewDidLoad
{
    [super viewDidLoad];

    //Custom viewDidLoad methods
    self.navigationItem.title = @"Classes";
    
    //Header
    UIView *h = self.header;
    [self.tableView setTableHeaderView:h];
    
    //Loading custom cells and registering for reuse
    UINib *nib = [UINib nibWithNibName:@"AMMSchoolClassCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"AMMSchoolClassCell"];
    
    //Color Setup
    [self setColorValuesForNavBar];
    
    //Edit Button set up
    [self setUpEditButton];
    
    //Empty footer to not have empty cells
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    //Spaces for separator lines
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 15)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (UIView *)header
{
    if (!_header) {
        [[NSBundle mainBundle] loadNibNamed:@"AMMSeasonTitle" owner:self options:nil];
    }
    
    [self setSeasonTitleTextAndFont];
    [self addBottomBorderToSeasonTitle];
    
    return _header;
}

- (void)setSeasonTitleTextAndFont
{
    self.seasonTitle.text = [NSString amm_determineSeasonAndYear];
    self.seasonTitle.font = [UIFont amm_latoRegFont:18];
    self.seasonTitle.textColor = [UIColor colorWithRed:30/255.0
                                                 green:178/255.0
                                                  blue:192/255.0
                                                 alpha:1];
}

- (void)addBottomBorderToSeasonTitle
{
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, 63.0f, self.seasonTitle.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1].CGColor;
    [self.seasonTitle.layer addSublayer:bottomBorder];
}

- (void)setColorValuesForNavBar
{
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:30/255.0
                                                                           green:178/255.0
                                                                            blue:192/255.0
                                                                           alpha:1];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor whiteColor], NSForegroundColorAttributeName,
                                                                     [UIFont amm_latoRegFont:24.0], NSFontAttributeName,
                                                                     nil]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor lightGrayColor];
}

- (void)setUpEditButton
{
    UIImage *pencil = [[UIImage imageNamed:@"pencil3.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *pencilEditButton = [[UIBarButtonItem alloc] initWithImage:pencil
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(addSchoolClass:)];
    
    [pencilEditButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                  [UIFont amm_latoLightFont:16], NSFontAttributeName, nil]
                        forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = pencilEditButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Adding a class

- (void)addSchoolClass:(id)sender
{
    SchoolClass *clickToAdd = [[SchoolClass alloc] initWithName:@"Click to Add" section:@"101" daysOfWeek:@"Days" timeOfDay:@"Time"];
    [[AMMClassStore classStore] addClass:clickToAdd atIndex:0];
    
    //Insertion Animation
    NSInteger row = 0;
    NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
    
    self.editing = YES;
    self.tableView.allowsSelectionDuringEditing = YES;
    
    [self setUpDoneButton];
}

- (void)doneEditing:(id)sender
{
    SchoolClass *clickToAdd = [[[AMMClassStore classStore] allClasses] objectAtIndex:0];
    if ([clickToAdd.name isEqualToString:@"Click to Add"]) {
        [[AMMClassStore classStore] removeClass:clickToAdd];
        
        //Deletion animation
        NSInteger row = 0;
        NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:0];
        [self.tableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationTop];
    }
    self.editing = NO;
    [self setUpEditButton];
}

- (void)setUpDoneButton
{
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneEditing:)];
    self.navigationItem.rightBarButtonItem = doneButton;
}

- (void)setUpBackButton
{
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = backButton;
}

#pragma mark - Table view data source

- (AMMClassCircle *)makeCircleForCellWithGrade:(double)grade
{
    CGRect circleRect = CGRectMake(5, 20, 85, 85);
    AMMClassCircle *classCircle = [[AMMClassCircle alloc] initWithFrame:circleRect];
    classCircle.grade = grade;
    return classCircle;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSInteger numRows = [[[AMMClassStore classStore] allClasses] count];
    
    return numRows;
}

- (void)setUpCellFonts:(AMMSchoolClassCell *)cell
{
    cell.schoolClassNameLabel.font = [UIFont amm_latoRegFont:20];
    cell.schoolClassDetailsLabel.font = [UIFont amm_latoLightFont:14];
    cell.gradeLabel.font = [UIFont amm_latoLightFont:18];
    cell.decimalLabel.font = [UIFont amm_latoLightFont:13];
}

- (CGRect)determineGradeLabelFrameWithGrade:(double)grade
{
    //Changes the frame of the grade label
    //so it centers if it's over or under 100
    CGRect gradeRect;
    if (grade >= 100) {
        gradeRect = CGRectMake(20, 35, 41, 25);
    } else {
        gradeRect = CGRectMake(11, 35, 41, 25);
    }
    return gradeRect;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AMMSchoolClassCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AMMSchoolClassCell" forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    [self setUpCellFonts:cell];

    SchoolClass *classDisplayed = [[[AMMClassStore classStore] allClasses] objectAtIndex:indexPath.row];
    
    //Creating circle
    AMMClassCircle *classCirc = [self makeCircleForCellWithGrade:classDisplayed.grade];
    [cell.contentView addSubview:classCirc];
    
    //Determine which frame to have for grade label
    cell.gradeLabel.frame = [self determineGradeLabelFrameWithGrade:classDisplayed.grade];
    
    [self fillCell:cell withContentFromClass:classDisplayed];

    return cell;
}

- (void)fillCell:(AMMSchoolClassCell *)cell withContentFromClass:(SchoolClass *)classDisplayed
{
    cell.schoolClassNameLabel.text = classDisplayed.name;
    cell.schoolClassDetailsLabel.text = [NSString stringWithFormat:@"%@  ∙  %@  ∙  %@", classDisplayed.section,
                                         classDisplayed.daysOfWeek, classDisplayed.timeOfDay];
    cell.gradeLabel.text = [NSString stringWithFormat:@"%.0f", [UtilityMethods getGradeWholeNumber:classDisplayed.grade]];
    if (classDisplayed.grade >= 100) {
        cell.decimalLabel.text = @"";
    } else {
        cell.decimalLabel.text = [NSString stringWithFormat:@".%.0f", [UtilityMethods getGradeDecimal:classDisplayed.grade] * 10];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SchoolClass *schoolClassToPresent = [[[AMMClassStore classStore] allClasses] objectAtIndex:indexPath.row];
    NSInteger classIndex = indexPath.row;
    
    if (self.editing) {
        [self pushAMMNewClassVCWithClass:schoolClassToPresent];
    } else {
        [self pushSchoolClassWithIndex:classIndex];
    }
}

- (void)pushAMMNewClassVCWithClass:(SchoolClass *)schoolClassToPresent
{
    AMMNewClass *ncvc = [[AMMNewClass alloc] initWithNibName:@"AMMNewClass" bundle:nil];
    ncvc.classToAdd = schoolClassToPresent;
    [self setUpDoneButton];
    [self.navigationController pushViewController:ncvc animated:YES];
    [self.tableView reloadData];
}

- (void)pushSchoolClassWithIndex:(NSInteger)index
{
    NSInteger classIndex = index;
    AMMClassPageController *cpvc = [[AMMClassPageController alloc] init];
    cpvc.classIndex = classIndex;
    [self setUpBackButton];
    [self.navigationController pushViewController:cpvc animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        SchoolClass *delete = [[[AMMClassStore classStore] allClasses] objectAtIndex:indexPath.row];
        [[AMMClassStore classStore] removeClass:delete];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

@end
