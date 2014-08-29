//
//  AMMNewClass.m
//  Curva
//
//  Created by Anthony Mace on 6/17/14.
//  Copyright (c) 2014 Amaceing Studios. All rights reserved.
//

#import "AMMNewClass.h"
#import "AMMClassCircle.h"
#import "UtilityMethods.h"

@interface AMMNewClass ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *sectionField;
@property (weak, nonatomic) IBOutlet UITextField *daysField;
@property (weak, nonatomic) IBOutlet UITextField *timeField;


@end

@implementation AMMNewClass

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.nameField.delegate = self;
        self.sectionField.delegate = self;
        self.daysField.delegate = self;
        self.timeField.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([self.classToAdd.name isEqualToString:@"Click to Add"]) {
        self.navigationItem.title = @"New Class";
    } else {
        self.navigationItem.title = self.classToAdd.name;
    }
    
    //Fonts
    [self setFonts];
    
    self.timeField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
}

- (void)setFonts
{
    self.nameField.font = [UtilityMethods latoLightFont:14];
    self.sectionField.font = [UtilityMethods latoLightFont:14];
    self.daysField.font = [UtilityMethods latoLightFont:14];
    self.timeField.font = [UtilityMethods latoLightFont:14];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (![self.classToAdd.name isEqualToString:@"Click to Add"]) {
        self.nameField.text = self.classToAdd.name;
        self.sectionField.text = self.classToAdd.section;
        self.daysField.text = self.classToAdd.daysOfWeek;
        self.timeField.text = self.classToAdd.timeOfDay;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.timeField resignFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    SchoolClass *newClass = self.classToAdd;
    newClass.name = self.nameField.text;
    newClass.section = self.sectionField.text;
    newClass.daysOfWeek = self.daysField.text;
    newClass.timeOfDay = self.timeField.text;
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
