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

@interface AMMSchoolClassVC ()

@property (nonatomic, strong) IBOutlet UIView *header;
@property (nonatomic, strong) IBOutlet UILabel *schoolClassName;
@property (nonatomic, strong) IBOutlet UILabel *schoolClassGrade;
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
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 25, 0, 43)];
    
    //Loading custom cells and registering for reuse
    UINib *nib = [UINib nibWithNibName:@"AMMCategoryCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"AMMCategoryCell"];
    
    //Empty Footer
    [self.tableView setTableFooterView:[[UIView alloc] init]];
    
    //Long press
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 2.0; //seconds
    lpgr.delegate = self;
    [self.tableView addGestureRecognizer:lpgr];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
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
    self.edit.titleLabel.font = [UtilityMethods latoLightFont:14];
    
    //Text
    self.schoolClassName.text = self.schoolClass.name;
    self.schoolClassGrade.text = [NSString stringWithFormat:@"%0.1f", self.schoolClass.grade];
    
    //Color
    self.schoolClassName.textColor = [UIColor colorWithRed:30/255.0
                                                     green:178/255.0
                                                      blue:192/255.0
                                                     alpha:1];
    [self.edit setTitleColor:[UIColor colorWithRed:30/255.0
                                        green:178/255.0
                                         blue:192/255.0
                                        alpha:1] forState:UIControlStateNormal];
    self.schoolClassGrade.textColor = [UtilityMethods determineColorShown:self.schoolClass.grade];
    
    return _header;
}

- (void)setUpBackButton
{
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = back;
}


#pragma Logic

- (void)setUpEditButton
{
    if (self.tableView.editing) {
       [self.edit removeTarget:self action:@selector(doneEditing) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.edit addTarget:self action:@selector(addAssignCat) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setUpDoneEditingButton
{
    self.edit.titleLabel.text = @"Done";
    if (self.tableView.editing) {
        [self.edit removeTarget:self action:@selector(addAssignCat) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.edit addTarget:self action:@selector(doneEditing) forControlEvents:UIControlEventTouchUpInside];
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
    return 75;
}

- (void)setUpCellFonts:(AMMCategoryCell *)cell
{
    cell.catName.font = [UtilityMethods latoLightFont:17];
    cell.catGrade.font = [UtilityMethods latoLightFont:17];
    cell.catWeight.font = [UtilityMethods latoLightFont:12];
}

- (void)addGradeBarToCell:(AMMCategoryCell *)cell catGrade:(double)grade
{
    AMMGradeBar *gradeBar = [[AMMGradeBar alloc] initWithFrame:cell.catGradeLine.bounds];
    gradeBar.grade = grade;
    [cell.catGradeLine addSubview:gradeBar];
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
        AMMNewAssignmentCat *navc = [[AMMNewAssignmentCat alloc] init];
        navc.assignCat = cat;
        [self.navigationController pushViewController:navc animated:YES];
        [self.tableView reloadData];
    } else {
        
    }
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    CGPoint p = [gestureRecognizer locationInView:self.tableView];
    
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:p];
    if (indexPath == nil) {
        NSLog(@"long press on table view but not on a row");
    } else {
        AssignmentCategory *delete = [self.schoolClass.assignmentCategories objectAtIndex:indexPath.row];
        [self.schoolClass removeAssignmentCategory:delete];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView reloadData];
    }
}

@end
