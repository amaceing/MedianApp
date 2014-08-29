//
//  AMMNewAssignment.m
//  Curva
//
//  Created by Anthony Mace on 6/12/14.
//  Copyright (c) 2014 Amaceing Studios. All rights reserved.
//

#import "AMMNewAssignment.h"

@interface AMMNewAssignment ()

@property (weak, nonatomic) IBOutlet UITextField *assignName;
@property (weak, nonatomic) IBOutlet UITextField *pointsEarnedField;
@property (weak, nonatomic) IBOutlet UITextField *pointsPossField;
@property (weak, nonatomic) IBOutlet UILabel *outOfLabel;

@end

@implementation AMMNewAssignment

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.assignName.returnKeyType = UIReturnKeyDone;
        self.assignName.delegate = self;
        self.pointsEarnedField.delegate = self;
        self.pointsPossField.delegate = self;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setFont];
    if ([self.assign.name isEqualToString:@"Click to Add"]) {
        self.assignName.placeholder = @"Assignment Name";
        self.pointsEarnedField.placeholder = @"Points Earned";
        self.pointsPossField.placeholder = @"Points Possible";
        self.navigationItem.title = @"New Assignment";
    } else {
        self.assignName.text = self.assign.name;
        self.pointsEarnedField.text = [NSString stringWithFormat:@"%.1f",self.assign.pointsEarned];
        self.pointsPossField.text = [NSString stringWithFormat:@"%.1f",self.assign.pointsPossible];
        self.navigationItem.title = self.assignName.text;
    }
    self.pointsEarnedField.keyboardType = UIKeyboardTypeDecimalPad;
    self.pointsPossField.keyboardType = UIKeyboardTypeDecimalPad;
}

- (void)setFont
{
    self.assignName.font = [UIFont fontWithName:@"Lato-Light" size:14.0];
    self.pointsEarnedField.font = [UIFont fontWithName:@"Lato-Light" size:13.0];
    self.pointsPossField.font = [UIFont fontWithName:@"Lato-Light" size:13.0];
    self.outOfLabel.font = [UIFont fontWithName:@"Lato-Light" size:13.0];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.pointsEarnedField resignFirstResponder];
    [self.pointsPossField resignFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    Assignment *assign = self.assign;
    assign.name = self.assignName.text;
    assign.pointsEarned = [self.pointsEarnedField.text doubleValue];
    assign.pointsPossible = [self.pointsPossField.text doubleValue];
}

- (void)setAssign:(Assignment *)assign
{
    _assign = assign;
    self.navigationItem.title = @"New Assignment";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
