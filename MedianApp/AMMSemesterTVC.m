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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (UIView *)header
{
    if (!_header) {
        [[NSBundle mainBundle] loadNibNamed:@"AMMSeasonTitle" owner:self options:nil];
    }
    self.seasonTitle.text = [UtilityMethods determineSeasonAndYear];
    self.seasonTitle.font = [UtilityMethods latoRegFont:17];
    self.seasonTitle.textColor = [UIColor colorWithRed:30/255.0
                                                 green:178/255.0
                                                  blue:192/255.0
                                                 alpha:1];
    // Add a bottomBorder to season title
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, 63.0f, self.seasonTitle.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1].CGColor;
    [self.seasonTitle.layer addSublayer:bottomBorder];
    
    return _header;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)setColorValuesForNavBar
{
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:30/255.0
                                                                           green:178/255.0
                                                                            blue:192/255.0
                                                                           alpha:1];
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor whiteColor], NSForegroundColorAttributeName,
                                                                     [UtilityMethods latoRegFont:21.0], NSFontAttributeName,
                                                                     nil]];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor lightGrayColor];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Adding a class

- (void)setUpEditButton
{
    UIImage *pencil = [[UIImage imageNamed:@"pencil3.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithImage:pencil
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(addSchoolClass:)];
    
    [edit setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                  [UtilityMethods latoLightFont:16], NSFontAttributeName, nil]
                                  forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = edit;
}

- (void)addSchoolClass:(id)sender
{
    SchoolClass *dummy = [[SchoolClass alloc] initWithName:@"Click to Add" section:@"101" daysOfWeek:@"Days" timeOfDay:@"Time"];
    [[AMMClassStore classStore] addClass:dummy atIndex:0];
    
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
    SchoolClass *dummy = [[[AMMClassStore classStore] allClasses] objectAtIndex:0];
    if ([dummy.name isEqualToString:@"Click to Add"]) {
        [[AMMClassStore classStore] removeClass:dummy];
        
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
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneEditing:)];
    self.navigationItem.rightBarButtonItem = done;
}

- (void)setUpBackButton
{
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = back;
}

#pragma mark - Table view data source

- (AMMClassCircle *)makeCircleForCell:(double)grade
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
    cell.schoolClassNameLabel.font = [UtilityMethods latoRegFont:20];
    cell.schoolClassDetailsLabel.font = [UtilityMethods latoLightFont:14];
    cell.gradeLabel.font = [UtilityMethods latoLightFont:18];
    cell.decimalLabel.font = [UtilityMethods latoLightFont:13];
}

- (CGRect)determineGradeLabelFrameWithGrade:(double)grade
{
    CGRect gradeRect;
    if (grade >= 100) {
        gradeRect = CGRectMake(20, 34, 41, 25);
    } else {
        gradeRect = CGRectMake(11, 34, 41, 25);
    }
    return gradeRect;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AMMSchoolClassCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AMMSchoolClassCell" forIndexPath:indexPath];
    
    //Font
    [self setUpCellFonts:cell];
    
    //SchoolClass
    SchoolClass *display = [[[AMMClassStore classStore] allClasses] objectAtIndex:indexPath.row];
    
    //Creating circle
    AMMClassCircle *classCirc = [self makeCircleForCell:display.grade];
    [cell.contentView addSubview:classCirc];
    
    //GradeLabel
    cell.gradeLabel.frame = [self determineGradeLabelFrameWithGrade:display.grade];
    
    //Content
    cell.schoolClassNameLabel.text = display.name;
    cell.schoolClassDetailsLabel.text = [NSString stringWithFormat:@"%@  ∙  %@  ∙  %@", display.section, display.daysOfWeek, display.timeOfDay];
    cell.gradeLabel.text = [NSString stringWithFormat:@"%.0f", [UtilityMethods getGradeWholeNumber:display.grade]];
    
    if (display.grade >= 100) {
        cell.decimalLabel.text = @"";
        cell.decimalLabel = nil;
    } else {
        if (!cell.decimalLabel) {
            UILabel *decLabel = [[UILabel alloc] initWithFrame:CGRectMake(52, 38, 27, 21)];
            cell.decimalLabel = decLabel;
        }
        cell.decimalLabel.text = [NSString stringWithFormat:@".%.0f", [UtilityMethods getGradeDecimal:display.grade] * 10];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SchoolClass *sc = [[[AMMClassStore classStore] allClasses] objectAtIndex:indexPath.row];
    
    if (self.editing) {
        AMMNewClass *ncvc = [[AMMNewClass alloc] initWithNibName:@"AMMNewClass" bundle:nil];
        ncvc.classToAdd = sc;
        [self setUpDoneButton];
        [self.navigationController pushViewController:ncvc animated:YES];
        [self.tableView reloadData];
    } else {
        //Push School Class
        NSInteger classIndex  = indexPath.row;
        AMMClassPageController *cpvc = [[AMMClassPageController alloc] init];
        cpvc.classIndex = classIndex;
        [self setUpBackButton];
        [self.navigationController pushViewController:cpvc animated:YES];
    }
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
        [self.tableView reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.editing && indexPath.row == 0) {
        return UITableViewCellEditingStyleInsert;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
}*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
