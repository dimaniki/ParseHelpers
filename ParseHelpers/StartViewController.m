//
//  StartViewController.m
//  ParseHelpers
//
//  Created by Mac on 03.11.13.
//  Copyright (c) 2013 Mac. All rights reserved.
//

#import "StartViewController.h"
#import "ParseHelper.h"
#import <Parse/Parse.h>
#import "MasterViewController.h"
#import "AddViewController.h"

@interface StartViewController ()

@end

@implementation StartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES animated:NO];
    self.navigationItem.title = [PFUser currentUser].email;
    //[self.navigationController.navigationBar pushNavigationItem:self.navigationItem animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ShowSettings:(id)sender {
    MasterViewController *masterViewControler = [[MasterViewController alloc] initWithNibName:@"MasterViewController" bundle:nil];
    masterViewControler.target = @"Settings";
    [self.navigationController pushViewController:masterViewControler animated:YES];
}

- (IBAction)ShowTest:(id)sender {
    MasterViewController *masterViewControler = [[MasterViewController alloc] initWithNibName:@"MasterViewController" bundle:nil];
    masterViewControler.target = @"Test";
    [self.navigationController pushViewController:masterViewControler animated:YES];
}

- (IBAction)AddToSettings:(id)sender {
    AddViewController *addViewController = [[AddViewController alloc] initWithNibName:@"AddViewController" bundle:nil];
    addViewController.target = @"Settings";
    [self.navigationController pushViewController:addViewController animated:YES];
}

- (IBAction)AddToTest:(id)sender {
    AddViewController *addViewController = [[AddViewController alloc] initWithNibName:@"AddViewController" bundle:nil];
    addViewController.target = @"Test";
    [self.navigationController pushViewController:addViewController animated:YES];
}

- (IBAction)Logout:(id)sender {
    [[ParseHelper sharedInstance] logout];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
