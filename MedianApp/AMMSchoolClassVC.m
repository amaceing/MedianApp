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

@interface AMMSchoolClassVC ()

@property (nonatomic, strong) IBOutlet UIView *header;
@property (nonatomic, strong) IBOutlet UILabel *schoolClassName;
@property (nonatomic, strong) IBOutlet UILabel *schoolClassGrade;
@property (nonatomic, strong) IBOutlet UILabel *schoolClassGradeDec;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIButton *edit;

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

#pragma Loading View

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //Header
    [self setHeader:self.header];
    
    //Table view
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self setUpEditButton];
    
    //Spaces for separator lines
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 23, 0, 27)];
    
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
    [self gradeTextSetUp];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)gradeTextSetUp
{
    //Text
    self.schoolClassGrade.text = [NSString stringWithFormat:@"%.0f", [self getGradeWholeNumber]];
    //Decimal
    double decToDisplay = [self getGradeDecimal] * 10;
    self.schoolClassGradeDec.text = [NSString stringWithFormat:@".%.0f", decToDisplay];
    
    //Color
    self.schoolClassGrade.textColor = [UtilityMethods determineColorShown:self.schoolClass.grade];
    self.schoolClassGradeDec.textColor = [UtilityMethods determineColorShown:self.schoolClass.grade];
}

- (UIView *)header
{
    //Font
    self.schoolClassName.font = [UtilityMethods latoLightFont:20];
    self.schoolClassGrade.font = [UtilityMethods latoLightFont:65];
    self.schoolClassGradeDec.font = [UtilityMethods latoLightFont:45];
    self.edit.titleLabel.font = [UtilityMethods latoLightFont:14];
    
    //Text
    self.schoolClassName.text = self.schoolClass.name;
    
    //Color
    self.schoolClassName.textColor = [UIColor blackColor];
    [self.edit setTitleColor:[UIColor colorWithRed:38/255.0
                                        green:172/255.0
                                         blue:198/255.0
                                        alpha:1] forState:UIControlStateNormal];

    return _header;
}

- (void)setUpBackButton
{
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@""
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:nil];
    self.navigationItem.backBarButtonItem = back;
}

- (void)setUpDoneButton
{
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = done;
}


#pragma Logic

- (double)getGradeWholeNumber
{
    double wholeNum = self.schoolClass.grade;
    double dec = [self getGradeDecimal];
    return wholeNum - dec;
}

- (double)getGradeDecimal
{
    double dec = self.schoolClass.grade - floor(self.schoolClass.grade);
    return dec;
}

- (void)setUpEditButton
{
    [self.edit setTitle:@"Edit" forState:UIControlStateNormal];
    if (self.tableView.editing) {
       [self.edit removeTarget:self action:@selector(doneEditing) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.edit addTarget:self action:@selector(addAssignCat) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setUpDoneEditingButton
{
    [self.edit setTitle:@"Done" forState:UIControlStateNormal];
    if (self.tableView.editing) {
        [self.edit removeTarget:self action:@selector(addAssignCat) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.edit addTarget:self action:@selector(doneEditing) forControlEvents:UIControlEventTouchUpInside];
    [self.edit setNeedsDisplay];
}

- (void)addAssignCat
{
    AssignmentCategory *assignCatToAdd = [[AssignmentCategory alloc] initWithName:@"Click to Add" withWeight:0];
    [self.schoolClass addAssignmentCategory:assignCatToAdd];
    
    self.tableView.editing = YES;
    self.tableView.allowsSelectionDuringEditing = YES;
    [self.tableView reloadData];
    [self setUpDoneEditingButton];
}

- (void)doneEditing
{
    AssignmentCategory *dummy = [self.schoolClass assignmentCategoryAtIndex:0];
    if ([dummy.name isEqualToString:@"Click to Add"]) {
        [self.schoolClass removeAssignmentCategory:dummy];
    }
    [self setUpEditButton];
    self.tableView.editing = NO;
    [self.tableView reloadData];
}

- (UIColor *)grade:(double)grade
{
    if (grade >= 85) {
        return [UIColor colorWithRed:128/255.0 green:209/255.0 blue:37/255.0 alpha:1];
    } else if (grade >= 70) {
        return [UIColor colorWithRed:243/255.0 green:172/255.0 blue:54/255.0 alpha:1];
    } else {
        return [UIColor colorWithRed:208/255.0 green:69/255.0 blue:89/255.0 alpha:1];
    }
}

#pragma Table View 

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
    cell.catName.font = [UtilityMethods latoLightFont:20];
    cell.catGrade.font = [UtilityMethods latoLightFont:17];
    cell.catWeight.font = [UtilityMethods latoLightFont:12];
}

- (void)addGradeBarToCell:(AMMCategoryCell *)cell catGrade:(double)grade
{
    [cell.catGradeLine setNeedsDisplay];
    CGRect rect = CGRectMake(0, 0,
                            (cell.catGradeLine.bounds.size.width / 100) * grade,
                             cell.catGradeLine.bounds.size.height);
    
    SlantyDashedView *gradeBar = [[SlantyDashedView alloc] initWithFrame:rect];
    gradeBar.backgroundColor = [UtilityMethods determineColorShown:grade];
    gradeBar.dashColor = [self grade:grade];
    gradeBar.dashWidth = 10.0;
    gradeBar.dashSpacing = 10.0;
    gradeBar.horizontalTranslation = 10.0;
    
    [cell.catGradeLine addSubview:gradeBar];
    
    /*
    AMMGradeBar *gradeBar = [[AMMGradeBar alloc] initWithFrame:cell.catGradeLine.bounds];
    gradeBar.grade = grade;
    [cell.catGradeLine addSubview:gradeBar];
     */
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AMMCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AMMCategoryCell" forIndexPath:indexPath];
    AssignmentCategory *cat = [self.schoolClass.assignmentCategories objectAtIndex:indexPath.row];
    
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
            UIActionSheet *editDeleteSheet = [[UIActionSheet alloc] initWithTitle:@"Edit or Delete" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete Category" otherButtonTitles:@"Edit Category", nil];
            [editDeleteSheet showInView:self.view];
        }
    } else {
        AMMAssignCatTVC *actvc = [[AMMAssignCatTVC alloc] init];
        actvc.assignCat = cat;
        actvc.schoolClass = self.schoolClass;
        [self.navigationController pushViewController:actvc animated:YES];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    AssignmentCategory *cat = [self.schoolClass.assignmentCategories objectAtIndex:selectedIndexPath.row];
    if (buttonIndex == actionSheet.destructiveButtonIndex) {
        [self.schoolClass removeAssignmentCategory:cat];
        [self.tableView reloadData];
        [self.schoolClassName setNeedsDisplay];
    } else if (buttonIndex == 1) {
        AMMNewAssignmentCat *navc = [[AMMNewAssignmentCat alloc] init];
        navc.assignCat = cat;
        [self.navigationController pushViewController:navc animated:YES];
        [self.tableView reloadData];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

@end
