//
//  AMMAssignCatTVC.m
//  MedianApp
//
//  Created by Anthony Mace on 7/26/14.
//  Copyright (c) 2014 Amaceing Studios. All rights reserved.
//

#import "AMMAssignCatTVC.h"
#import "UtilityMethods.h"

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

- (UIView *)header
{
    if (!_header) {
        [[NSBundle mainBundle] loadNibNamed:@"AMMAssignCatHeader" owner:self options:nil];
    }
    //Font
    self.assignCatName.font = [UtilityMethods latoLightFont:20];
    self.editButton.titleLabel.font = [UtilityMethods latoLightFont:12];
    
    //Text
    self.assignCatName.text = self.assignCat.name;
    [self.editButton setTitle:@"Edit" forState:UIControlStateNormal];
    
    //Color
    self.assignCatName.textColor = [UIColor colorWithRed:30/255.0
                                                     green:178/255.0
                                                      blue:192/255.0
                                                     alpha:1];
    [self.editButton setTitleColor:[UIColor colorWithRed:30/255.0
                                             green:178/255.0
                                              blue:192/255.0
                                             alpha:1] forState:UIControlStateNormal];
    
    return _header;
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

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
