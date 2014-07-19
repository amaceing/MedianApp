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
#import "AMMClassVC.h"
#import "UtilityMethods.h"

@interface AMMSemesterTVC ()

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Custom viewDidLoad methods
    self.navigationItem.title = @"Classes";
    
    //Loading custom cells and registering for reuse
    UINib *nib = [UINib nibWithNibName:@"AMMSchoolClassCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"AMMSchoolClassCell"];
    
    //Color Setup
    [self setColorValuesForNavBar];

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)setColorValuesForNavBar
{
    self.navigationController.navigationBar.barTintColor =
    [UIColor colorWithRed:30/255.0 green:178/255.0 blue:192/255.0 alpha:1];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor whiteColor], NSForegroundColorAttributeName,
                                                                     [UtilityMethods latoBoldFont:21.0], NSFontAttributeName,
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

- (void)addSchoolClass:(id)sender
{
    //Adding class
    SchoolClass *dummy = [[SchoolClass alloc] initWithName:@"Add" daysOfWeek:@"Days" timeOfDay:@"Time"];
    [[AMMClassStore classStore] addClass:dummy];
    
    //Popping VC
    AMMNewClass *ncvc = [[AMMNewClass alloc] initWithNibName:@"AMMNewClass" bundle:nil];
    ncvc.classToAdd = dummy;
    // Setting done button
    [self setUpDoneButton];
    [self.navigationController pushViewController:ncvc animated:YES];
    
    //Inserting into table
    NSInteger row = [[[AMMClassStore classStore] allClasses] indexOfObject:dummy];
    NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView reloadData];
    self.editing = YES;
    self.tableView.allowsSelectionDuringEditing = YES;
}

- (void)doneEditing:(id)sender
{
    self.editing = NO;
    [self setUpEditButton];
}

- (void)setUpEditButton
{
    UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(addSchoolClass:)];
    self.navigationItem.rightBarButtonItem = edit;
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
    return [[[AMMClassStore classStore] allClasses] count];
}

- (void)setUpCellFonts:(AMMSchoolClassCell *)cell
{
    cell.schoolClassNameLabel.font = [UtilityMethods latoRegFont:20];
    cell.schoolClassDetailsLabel.font = [UtilityMethods latoLightFont:10];
    cell.gradeLabel.font = [UtilityMethods latoRegFont:18];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AMMSchoolClassCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AMMSchoolClassCell" forIndexPath:indexPath];
    SchoolClass *display = [[[AMMClassStore classStore] allClasses] objectAtIndex:indexPath.row];
    
    // Configure the cell...
    
    //Creating circle
    AMMClassCircle *classCirc = [self makeCircleForCell:display.grade];
    [cell.contentView addSubview:classCirc];
    
    //Font
    [self setUpCellFonts:cell];
    
    //Content
    cell.schoolClassNameLabel.text = display.name;
    cell.schoolClassDetailsLabel.text = [NSString stringWithFormat:@"%@ • %@", display.daysOfWeek, display.timeOfDay];
    cell.gradeLabel.text = [NSString stringWithFormat:@"%.0f", display.grade];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SchoolClass *sc = [[[AMMClassStore classStore] allClasses] objectAtIndex:indexPath.row];
    if (self.editing) {
        AMMNewClass *ncvc = [[AMMNewClass alloc] initWithNibName:@"AMMNewClass" bundle:nil];
        ncvc.classToAdd = sc;
        [self setUpBackButton];
        [self.navigationController pushViewController:ncvc animated:YES];
    } else {
        AMMClassVC *cvc = [[AMMClassVC alloc] initWithNibName:@"AMMClassVC" bundle:nil];
        cvc.schoolClass = sc;
        [self setUpBackButton];
        [self.navigationController pushViewController:cvc animated:YES];
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
        SchoolClass *dummy = [[SchoolClass alloc] initWithName:@"Add" daysOfWeek:@"Days" timeOfDay:@"Time"];
        [[AMMClassStore classStore] addClass:dummy];
        NSInteger row = [[[AMMClassStore classStore] allClasses] indexOfObject:dummy];
        NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView reloadData];
    }   
}


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
