//
//  SignupViewController.m
//  ParseHelpers
//
//  Created by Mac on 03.11.13.
//  Copyright (c) 2013 Mac. All rights reserved.
//

#import "SignupViewController.h"
#import "ParseHelper.h"

@interface SignupViewController ()

@end

@implementation SignupViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.loginField) {
        [self.passwordField becomeFirstResponder];
    } else if (textField == self.passwordField) {
        [self.emailField becomeFirstResponder];
    } else
    {
        [self signup:textField];
    }
    return YES;
}

- (IBAction)signup:(id)sender
{
    if (![self.loginField.text length])
    {
        [self.loginField becomeFirstResponder];
        return;
    }
    if (![self.passwordField.text length])
    {
        [self.passwordField becomeFirstResponder];
        return;
    }
    if (![self.emailField.text length])
    {
        [self.emailField becomeFirstResponder];
        return;
    }
    
    if (self.emailField.isFirstResponder)
        [self.emailField resignFirstResponder];
    
    
    [[ParseHelper sharedInstance] signup:self.loginField.text password:self.passwordField.text email:self.emailField.text block:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // This code adds user device for push-notifications
            
//            PFInstallation *currentInstallation = [PFInstallation currentInstallation];
//            [currentInstallation setObject:@[[NSString stringWithFormat: @"user_%@", [PFUser currentUser].objectId]] forKey:@"channels"];
//            [currentInstallation saveInBackground];
            
        
            [self performSegueWithIdentifier:@"StartPage" sender:self];
        } else {
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            NSLog(@"Error signing normal: %@", errorString);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Signup failed" message:[[error userInfo] objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
}

@end
