//
//  AMMAssignCatTVC.m
//  MedianApp
//
//  Created by Anthony Mace on 7/26/14.
//  Copyright (c) 2014 Amaceing Studios. All rights reserved.
//

#import "AMMAssignCatTVC.h"
#import "UtilityMethods.h"
#import "AMMNewAssignment.h"

@interface AMMAssignCatTVC ()

@property (nonatomic, strong) IBOutlet UIView *header;
@property (nonatomic, strong) IBOutlet UILabel *assignCatName;
@property (nonatomic, strong) IBOutlet UIButton *editButton;

@end

@implementation AMMAssignCatTVC

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
    
    //Title
    self.navigationItem.title = self.schoolClass.name;
    
    //Header
    [self.tableView setTableHeaderView:self.header];
    
    //Empty Footer
    [self.tableView setTableFooterView:[[UIView alloc] init]];
    
    //Loading custom cells and registering for reuse
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    
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

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self doneEditing];
}

- (UIView *)header
{
    if (!_header) {
        [[NSBundle mainBundle] loadNibNamed:@"AMMAssignCatHeader" owner:self options:nil];
    }
    //Font
    self.assignCatName.font = [UtilityMethods latoLightFont:20];
    self.editButton.titleLabel.font = [UtilityMethods latoLightFont:14];
    
    //Text
    self.assignCatName.text = self.assignCat.name;
    [self setUpEditButton];
    
    //Color
    self.assignCatName.textColor = [UIColor blackColor];
    [self.editButton setTitleColor:[UIColor colorWithRed:38/255.0
                                                   green:172/255.0
                                                    blue:199/255.0
                                                   alpha:1] forState:UIControlStateNormal];
    
    // Add a bottomBorder.
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, 63.0f, self.assignCatName.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1].CGColor;
    [self.assignCatName.layer addSublayer:bottomBorder];
    
    return _header;
}

- (void)setUpEditButton
{
    [self.editButton setTitle:nil forState:UIControlStateNormal];
    UIImage *pencil = [[UIImage imageNamed:@"pencil6.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.editButton setImage:pencil forState:UIControlStateNormal];
    if (self.tableView.editing) {
        [self.editButton removeTarget:self action:@selector(doneEditing) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.editButton addTarget:self action:@selector(addAssignment) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setUpDoneEditingButton
{
    [self.editButton setImage:nil forState:UIControlStateNormal];
    [self.editButton setTitle:@"Done" forState:UIControlStateNormal];
    if (self.tableView.editing) {
        [self.editButton removeTarget:self action:@selector(addAssignment) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.editButton addTarget:self action:@selector(doneEditing) forControlEvents:UIControlEventTouchUpInside];
    [self.editButton setNeedsDisplay];
}

- (void)addAssignment
{
    Assignment *assign = [[Assignment alloc] initWithName:@"Click to Add" gradeEarned:0.0];
    [self.assignCat addAssignment:assign atIndex:0];
    self.tableView.editing = YES;
    self.tableView.allowsSelectionDuringEditing = YES;
    [self.tableView reloadData];
    [self setUpDoneEditingButton];
}

- (void)doneEditing
{
    Assignment *dummy = [self.assignCat.assignmentList objectAtIndex:0];
    if ([dummy.name isEqualToString:@"Click to Add"]) {
        [self.assignCat removeAssignment:dummy];
    }
    [self setUpEditButton];
    self.tableView.editing = NO;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [self.assignCat.assignmentList count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSInteger assignCount = [self.assignCat.assignmentList count];
    if (assignCount == 0) {
        return @"No Assignments";
    } else {
        return [NSString stringWithFormat:@"%0.1f", self.assignCat.average];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    Assignment *assign = [self.assignCat.assignmentList objectAtIndex:indexPath.row];
    
    // Configure the cell...
    cell.textLabel.font = [UtilityMethods latoLightFont:15];
    cell.textLabel.text = [assign description];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableView.editing) {
        Assignment *assign = [self.assignCat.assignmentList objectAtIndex:indexPath.row];
        AMMNewAssignment *navc = [[AMMNewAssignment alloc] initWithNibName:@"AMMNewAssignment" bundle:nil];
        navc.assign = assign;
        
        UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
        self.navigationItem.backBarButtonItem = back;
        [self.navigationController pushViewController:navc animated:YES];
    }
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
