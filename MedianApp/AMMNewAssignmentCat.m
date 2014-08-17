//
//  AMMNewAssignmentCat.m
//  MedianApp
//
//  Created by Anthony Mace on 7/24/14.
//  Copyright (c) 2014 Amaceing Studios. All rights reserved.
//

#import "AMMNewAssignmentCat.h"
#import "UtilityMethods.h"

@interface AMMNewAssignmentCat ()

@property (weak, nonatomic) IBOutlet UITextField *assignCatName;
@property (weak, nonatomic) IBOutlet UITextField *assignCatWeight;

@end

@implementation AMMNewAssignmentCat

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.assignCatName.delegate = self;
        self.assignCatWeight.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpTextFields];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self.assignCat.name isEqualToString:@"Click to Add"]) {
        self.navigationItem.title = @"New Category";
        self.assignCatName.placeholder = @"Assignment Category Name";
        self.assignCatWeight.placeholder = @"Weight";
    } else {
        self.navigationItem.title = @"Edit Category";
        self.assignCatName.text = self.assignCat.name;
        self.assignCatWeight.text = [NSString stringWithFormat:@"%.0f", self.assignCat.weight * 100];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    AssignmentCategory *category = self.assignCat;
    category.name = self.assignCatName.text;
    category.weight = [self.assignCatWeight.text doubleValue];
}

- (void)setUpTextFields
{
    //Fonts
    self.assignCatName.font = [UtilityMethods latoLightFont:14];
    self.assignCatWeight.font = [UtilityMethods latoLightFont:14];
    
    //Keyboards
    self.assignCatWeight.keyboardType = UIKeyboardTypeDecimalPad;
    self.assignCatName.keyboardType = UIKeyboardTypeAlphabet;
    self.assignCatName.returnKeyType = UIReturnKeyDone;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.assignCatWeight resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
