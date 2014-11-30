//
//  AMMSchoolClassVC.m
//  MedianApp
//
//  Created by Anthony Mace on 7/22/14.
//  Copyright (c) 2014 Amaceing Studios. All rights reserved.
//

#import "AMMSchoolClassVC.h"
#import "UtilityMethods.h"
#import "AMMNewAssignmentCat.h"
#import "AMMCategoryCell.h"
#import "AMMGradeBar.h"
#import "AMMAssignCatTVC.h"
#import "SlantyDashedView.h"
#import "AMMClassGradeLabels.h"
#import "AMMTriangleView.h"
#import "UIColor+AMMDetermineColorsShown.h"
#import "UIFont+AMMLatoFonts.h"

@interface AMMSchoolClassVC ()

@property (nonatomic, strong) IBOutlet UIView *header;
@property (nonatomic, strong) IBOutlet UILabel *footer;
@property (nonatomic, strong) IBOutlet UILabel *schoolClassName;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIButton *edit;
@property (weak, nonatomic) IBOutlet UILabel *sectionHeader;
@property (weak, nonatomic) IBOutlet UILabel *daysHeader;
@property (weak, nonatomic) IBOutlet UILabel *timesHeader;
@property (weak, nonatomic) IBOutlet UILabel *sectionInfo;
@property (weak, nonatomic) IBOutlet UILabel *daysInfo;
@property (weak, nonatomic) IBOutlet UILabel *timesInfo;

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

#pragma-mark Loading View

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //Header
    [self setHeader:self.header];
    //Footer
    [self classDetailsLabels];
    
    //Table view
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self setUpEditButton];
    
    //Spaces for separator lines
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 22, 0, 22)];
    
    //Loading custom cells and registering for reuse
    UINib *nib = [UINib nibWithNibName:@"AMMCategoryCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"AMMCategoryCell"];
    
    //Empty Footer
    [self.tableView setTableFooterView:[[UIView alloc] init]];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    [self.view reloadInputViews];
    [self removeGradeLabels];
    [self gradeTextSetUp];
}

- (void)removeGradeLabels
{
    for (UIView *view in [self.header subviews]) {
        if ([view isKindOfClass:[AMMClassGradeLabels class]]) {
            [view removeFromSuperview];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGRect)determineGradeLabelsFrameWithGrade:(double)grade
{
    CGRect gradeLabelsRect;
    if (self.schoolClass.grade >= 99.95) {
        gradeLabelsRect = CGRectMake(57, 84, 280, 80);
    } else {
        gradeLabelsRect = CGRectMake(22, 84, 280, 80);
    }
    return gradeLabelsRect;
}

- (void)gradeTextSetUp
{
    //GradeLabels rect
    CGRect gradeLabelsRect = [self determineGradeLabelsFrameWithGrade:self.schoolClass.grade];
    AMMClassGradeLabels *gradeLabels = [[AMMClassGradeLabels alloc] initWithFrame:gradeLabelsRect];
    [self.header addSubview:gradeLabels];
    gradeLabels.contentMode = UIViewContentModeRedraw;
    
    [gradeLabels.wholeNumberLabel setNeedsDisplay];
    [gradeLabels.decNumberLabel setNeedsDisplay];
    
    //Text
    gradeLabels.wholeNumberLabel.font = [UIFont amm_latoLightFont:65];
    gradeLabels.decNumberLabel.font = [UIFont amm_latoLightFont:45];
    
    //Whole Number
    double wholeNum = [UtilityMethods getGradeWholeNumber:self.schoolClass.grade];
    gradeLabels.wholeNumberLabel.text = [NSString stringWithFormat:@"%.0f", wholeNum];
    
    //Decimal Number
    if (self.schoolClass.grade >= 99.95) {
        gradeLabels.decNumberLabel.text = @"";
    } else {
        double decToDisplay = [UtilityMethods getGradeDecimal:self.schoolClass.grade] * 10;
        gradeLabels.decNumberLabel.text = [NSString stringWithFormat:@".%.0f", decToDisplay];
    }
    
    //Color
    gradeLabels.wholeNumberLabel.textColor = [UIColor amm_determineColorShown:self.schoolClass.grade];
    gradeLabels.decNumberLabel.textColor = [UIColor amm_determineColorShown:self.schoolClass.grade];
}

- (NSString *)schoolClassNameTextSetUp
{
    NSString *className = self.schoolClass.name;
    if ([className length] > 18) {
        className = [className substringToIndex: MIN(15, [className length])];
    }
    return className;
}

- (UIView *)header
{
    //Triangle
    AMMTriangleView *tri = [[AMMTriangleView alloc] initWithFrame:CGRectMake(120, 53, 65, 45)];
    [_header addSubview:tri];

    //Font
    self.schoolClassName.font = [UIFont amm_latoRegFont:18];
    self.edit.titleLabel.font = [UIFont amm_latoLightFont:14];
    
    //Text
    self.schoolClassName.text = [self schoolClassNameTextSetUp];
    
    //Color
    self.schoolClassName.textColor = [UIColor colorWithRed:38/255.0
                                                     green:172/255.0
                                                      blue:198/255.0
                                                     alpha:1];
    
    [self.edit setTitleColor:[UIColor colorWithRed:38/255.0
                                        green:172/255.0
                                         blue:198/255.0
                                        alpha:1] forState:UIControlStateNormal];
    
    // Add a bottomBorder.
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, 63.0f, self.schoolClassName.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1].CGColor;
    [self.schoolClassName.layer addSublayer:bottomBorder];

    return _header;
}

- (void)classDetailsLabels
{
    //Header fonts
    self.sectionHeader.font = [UIFont amm_latoRegFont:18];
    self.daysHeader.font = [UIFont amm_latoRegFont:18];
    self.timesHeader.font = [UIFont amm_latoRegFont:18];
    
    //Header colors
    self.sectionHeader.textColor = [UIColor colorWithRed:38/255.0
                                                   green:172/255.0
                                                    blue:198/255.0
                                                   alpha:1];
    self.daysHeader.textColor = [UIColor colorWithRed:38/255.0
                                                green:172/255.0
                                                 blue:198/255.0
                                                alpha:1];
    self.timesHeader.textColor = [UIColor colorWithRed:38/255.0
                                                 green:172/255.0
                                                  blue:198/255.0
                                                 alpha:1];
    
    //Info fonts
    self.sectionInfo.font = [UIFont amm_latoLightFont:14];
    self.daysInfo.font = [UIFont amm_latoLightFont:14];
    self.timesInfo.font = [UIFont amm_latoLightFont:14];
    
    //Info colors
    self.sectionInfo.textColor = [UIColor colorWithRed:38/255.0
                                                   green:172/255.0
                                                    blue:198/255.0
                                                   alpha:1];
    self.daysInfo.textColor = [UIColor colorWithRed:38/255.0
                                                green:172/255.0
                                                 blue:198/255.0
                                                alpha:1];
    self.timesInfo.textColor = [UIColor colorWithRed:38/255.0
                                                 green:172/255.0
                                                  blue:198/255.0
                                                 alpha:1];
    
    //Content
    self.sectionInfo.text = self.schoolClass.section;
    self.daysInfo.text = self.schoolClass.daysOfWeek;
    self.timesInfo.text = self.schoolClass.timeOfDay;
    
    //Add a top border
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, 0.0f, self.footer.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1].CGColor;
    [self.footer.layer addSublayer:bottomBorder];
}

- (void)setUpEditButton
{
    [self.edit setTitle:nil forState:UIControlStateNormal];
    UIImage *pencil = [[UIImage imageNamed:@"pencil6.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.edit setImage:pencil forState:UIControlStateNormal];
    if (self.tableView.editing) {
        [self.edit removeTarget:self action:@selector(doneEditing) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.edit addTarget:self action:@selector(addAssignCat) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setUpDoneEditingButton
{
    [self.edit setImage:nil forState:UIControlStateNormal];
    [self.edit setTitle:@"Done" forState:UIControlStateNormal];
    if (self.tableView.editing) {
        [self.edit removeTarget:self action:@selector(addAssignCat) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.edit addTarget:self action:@selector(doneEditing) forControlEvents:UIControlEventTouchUpInside];
    [self.edit setNeedsDisplay];
}


#pragma-mark Logic

- (void)addAssignCat
{
    AssignmentCategory *assignCatToAdd = [[AssignmentCategory alloc] initWithName:@"Click to Add" withWeight:0];
    [self.schoolClass addAssignmentCategory:assignCatToAdd];
    
    //Insertion animation
    NSInteger row = 0;
    NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
    
    self.tableView.editing = YES;
    self.tableView.allowsSelectionDuringEditing = YES;
    [self setUpDoneEditingButton];
}

- (void)doneEditing
{
    AssignmentCategory *dummy = [self.schoolClass assignmentCategoryAtIndex:0];
    if ([dummy.name isEqualToString:@"Click to Add"]) {
        [self.schoolClass removeAssignmentCategory:dummy];
        //Deletion animation
        NSInteger row = 0;
        NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:0];
        [self.tableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
    }
    [self setUpEditButton];
    self.tableView.editing = NO;
}

- (UIColor *)determineDashColor:(double)grade
{
    if (grade >= 85) {
        return [UIColor colorWithRed:144/255.0 green:218/255.0 blue:37/255.0 alpha:1];
    } else if (grade >= 70) {
        return [UIColor colorWithRed:244/255.0 green:184/255.0 blue:60/255.0 alpha:1];
    } else {
        return [UIColor colorWithRed:273/255.0 green:78/255.0 blue:108/255.0 alpha:1];
    }
}

#pragma-mark Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.schoolClass.assignmentCategories count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

- (void)setUpCellFonts:(AMMCategoryCell *)cell
{
    cell.catName.font = [UIFont amm_latoLightFont:20];
    cell.catGrade.font = [UIFont amm_latoLightFont:17];
    cell.catWeight.font = [UIFont amm_latoLightFont:12];
}

- (void)addGradeBarToCell:(AMMCategoryCell *)cell catGrade:(double)grade
{
    [cell.catGradeLine setNeedsDisplay];
    
    double length = (cell.catGradeLine.bounds.size.width / 100) * grade;
    if (length >= 263) {
        length = cell.catGradeLine.bounds.size.width;
    }
    CGRect rect = CGRectMake(0, 0, length, cell.catGradeLine.bounds.size.height);
    
    SlantyDashedView *gradeBar = [[SlantyDashedView alloc] initWithFrame:rect];
    gradeBar.backgroundColor = [UIColor amm_determineColorShown:grade];
    gradeBar.dashColor = [self determineDashColor:grade];
    gradeBar.dashWidth = 10.0;
    gradeBar.dashSpacing = 10.0;
    gradeBar.horizontalTranslation = 10.0;
    
    [cell.catGradeLine addSubview:gradeBar];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AMMCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AMMCategoryCell" forIndexPath:indexPath];
    AssignmentCategory *cat = [self.schoolClass.assignmentCategories objectAtIndex:indexPath.row];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    //Fonts
    [self setUpCellFonts:cell];
    
    //Content
    cell.catName.text = cat.name;
    cell.catGrade.text = [NSString stringWithFormat:@"%0.1f", cat.average];
    cell.catWeight.text = [NSString stringWithFormat:@"%.0f/100", cat.weight * 100];
    
    //Grade Bar
    [self addGradeBarToCell:cell catGrade:cat.average];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AssignmentCategory *cat = [self.schoolClass assignmentCategoryAtIndex:indexPath.row];
    if (self.tableView.editing) {
        if ([cat.name isEqualToString:@"Click to Add"]) {
            AMMNewAssignmentCat *navc = [[AMMNewAssignmentCat alloc] init];
            navc.assignCat = cat;
            [self.navigationController pushViewController:navc animated:YES];
            [self.tableView reloadData];
            [self.schoolClassName setNeedsDisplay];
        } else {
            //New UIAlertController
            UIAlertController *editDeleteController = [UIAlertController alertControllerWithTitle:@"Edit or Delete" message:@"Deleting categories cannot be undone" preferredStyle:UIAlertControllerStyleActionSheet];
            [self addActionsToAlertController:editDeleteController];
            [self presentViewController:editDeleteController animated:YES completion:nil];
            [self.tableView reloadData];
        }
    } else {
        AMMAssignCatTVC *actvc = [[AMMAssignCatTVC alloc] init];
        actvc.assignCat = cat;
        actvc.schoolClass = self.schoolClass;
        [self.navigationController pushViewController:actvc animated:YES];
    }
}

- (void)addActionsToAlertController:(UIAlertController *)controller
{
    //Row for actions
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    AssignmentCategory *cat = [self.schoolClass.assignmentCategories objectAtIndex:selectedIndexPath.row];
    
    //UIAlertActions
    UIAlertAction *delete = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive
                                                   handler:^(UIAlertAction *action) {
                                                       [self.schoolClass removeAssignmentCategory:cat];
                                                       [self.tableView deleteRowsAtIndexPaths:@[selectedIndexPath] withRowAnimation:UITableViewRowAnimationFade];
                                                       [self removeGradeLabels];
                                                       [self gradeTextSetUp];
                                                   }];
    UIAlertAction *edit = [UIAlertAction actionWithTitle:@"Edit" style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction *action) {
                                                     AMMNewAssignmentCat *navc = [[AMMNewAssignmentCat alloc] init];
                                                     navc.assignCat = cat;
                                                     [self.navigationController pushViewController:navc animated:YES];
                                                 }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction *action) {
                                                       [controller dismissViewControllerAnimated:YES completion:nil];
                                                   }];
    [controller addAction:delete];
    [controller addAction:edit];
    [controller addAction:cancel];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

@end
