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

    UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithTitle:@"E" style:UIBarButtonItemStylePlain target:self action:@selector(editTable:)];
    self.navigationItem.rightBarButtonItem = edit;
    
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
                                                                     [UIFont fontWithName:@"Lato-Light" size:21.0], NSFontAttributeName,
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

- (void)editTable:(id)sender
{
    SchoolClass *dummy = [[SchoolClass alloc] initWithName:@"Add" daysOfWeek:@"Days" timeOfDay:@"Time"];
    [[AMMClassStore classStore] addClass:dummy];
    NSInteger row = [[[AMMClassStore classStore] allClasses] indexOfObject:dummy];
    NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView reloadData];
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AMMSchoolClassCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AMMSchoolClassCell" forIndexPath:indexPath];
    SchoolClass *display = [[[AMMClassStore classStore] allClasses] objectAtIndex:indexPath.row];
    
    // Configure the cell...
    
    //Creating circle
    AMMClassCircle *classCirc = [self makeCircleForCell:display.grade];
    [cell.contentView addSubview:classCirc];
    
    cell.schoolClassNameLabel.text = display.name;
    cell.schoolClassDetailsLabel.text = [NSString stringWithFormat:@"%@ • %@", display.daysOfWeek, display.timeOfDay];
    cell.gradeLabel.text = [NSString stringWithFormat:@"%.0f", display.grade];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
