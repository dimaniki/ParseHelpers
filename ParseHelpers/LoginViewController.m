//
//  LoginViewController.m
//  ParseHelpers
//
//  Created by Mac on 03.11.13.
//  Copyright (c) 2013 Mac. All rights reserved.
//

#import "LoginViewController.h"
#import "ParseHelper.h"
#import "StartViewController.h"
#import "SignupViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
	if ([PFUser currentUser] && [PFUser currentUser].username.length) {
        [self loggedIn];
    }
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
    } else
    {
        [self login:textField];
    }
    return YES;
}

-(void)login:(id)sender
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
    
    if (self.passwordField.isFirstResponder)
        [self.passwordField resignFirstResponder];
    
    [self.activityIndicator startAnimating];
    [[ParseHelper sharedInstance] login:self.loginField.text password:self.passwordField.text
                                    block:^(PFUser *user, NSError *error) {
                                        [self.activityIndicator stopAnimating];
                                        if (user) {
                                            [self loggedIn];
                                        } else {
                                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login failed" message:[[error userInfo] objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                            [alert show];
                                            self.passwordField.text = @"";
                                            [self.passwordField becomeFirstResponder];
                                        }
                                    }];
}

- (IBAction)loginFacebook:(id)sender {
    [self.activityIndicator startAnimating];
    [[ParseHelper sharedInstance] loginFacebook:^(PFUser *user, NSError *error) {
                                      if (user) {
                                          [self.activityIndicator stopAnimating];
                                          [self loggedIn];
                                      } else {
                                          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login with Facebook failed" message:[[error userInfo] objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                          [alert show];
                                          self.passwordField.text = @"";
                                          [self.passwordField becomeFirstResponder];
                                      }
                                  }];
}

-(void)loggedIn
{
    StartViewController *startPage = [[StartViewController alloc] initWithNibName:@"StartViewController" bundle:nil];
    [self.navigationController pushViewController:startPage animated:YES];
    //[self performSegueWithIdentifier:@"StartPage" sender:self];
}

-(void)signup:(id)sender
{
    SignupViewController *signupViewController = [[SignupViewController alloc] initWithNibName:@"SignupViewController" bundle:nil];
    [self.navigationController pushViewController:signupViewController animated:YES];
    //[self performSegueWithIdentifier:@"StartPage" sender:self];
}

@end
