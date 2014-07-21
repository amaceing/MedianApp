//
//  AMMClassVC.m
//  MedianApp
//
//  Created by Anthony Mace on 7/16/14.
//  Copyright (c) 2014 Amaceing Studios. All rights reserved.
//

#import "AMMClassVC.h"
#import "UtilityMethods.h"
#import "AssignmentCategory.h"
#import "AMMCategoryCell.h"
#import "AMMNewAssignmentCat.h"

@interface AMMClassVC ()

@property (nonatomic, strong) IBOutlet UIView *header;
@property (nonatomic, strong) IBOutlet UILabel *schoolClassName;
@property (nonatomic, strong) IBOutlet UILabel *schoolClassGrade;

@end

@implementation AMMClassVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Title
    self.navigationItem.title = [UtilityMethods determineSeasonAndYear];
    
    //Loading custom cells and registering for reuse
    UINib *nib = [UINib nibWithNibName:@"AMMCategoryCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"AMMCategoryCell"];
    
    //Header view
    UIView *header = self.header;
    [self.tableView setTableHeaderView:header];
    
    //Adding
    [self setUpAddCategoryButton];
    
    //Empty footer view for no lines after cells
    [self.tableView setTableFooterView:[[UIView alloc] init]];
    
    //Spaces for separator lines
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 25, 0, 25)];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)setUpAddCategoryButton
{
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(addCat:)];
    self.navigationItem.rightBarButtonItem = add;
}

- (void)addCat:(id)sender
{
    //Adding category
    AssignmentCategory *cat = [[AssignmentCategory alloc] init];
    AMMNewAssignmentCat *newCat = [[AMMNewAssignmentCat alloc] init];
    newCat.cat = cat;
    
    //Popping view
    [self setUpBackButton];
    [self.navigationController pushViewController:newCat animated:YES];
    
    //Inserting category
    [self.schoolClass addAssignmentCategory:cat];
    NSInteger row = [[self.schoolClass assignmentCategories] indexOfObject:cat];
    NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView reloadData];
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

- (UIView *)header
{
    if (!_header) {
        [[NSBundle mainBundle] loadNibNamed:@"AMMSemesterHeader" owner:self options:nil];
    }
    
    self.schoolClassName.font = [UtilityMethods latoLightFont:18.0];
    self.schoolClassName.textColor = [UIColor colorWithRed:30/255.0 green:178/255.0 blue:192/255.0 alpha:1];
    self.schoolClassName.text = self.schoolClass.name;

    self.schoolClassGrade.font = [UtilityMethods latoRegFont:29.0];
    self.schoolClassGrade.text = [NSString stringWithFormat:@"%0.1f", self.schoolClass.grade];
    self.schoolClassGrade.textColor = [UtilityMethods determineColorShown:self.schoolClass.grade];
    
    return  _header;
}

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AMMCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AMMCategoryCell" forIndexPath:indexPath];
    AssignmentCategory *cat = [self.schoolClass assignmentCategoryAtIndex:indexPath.row];
    
    // Configure the cell...
    cell.catGrade.text = [NSString stringWithFormat:@"%0.1f", cat.average];
    cell.catName.text = cat.name;
    cell.catWeight.text = [NSString stringWithFormat:@"%.0f/100", cat.weight * 100];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

@end
