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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowSettings"]) {
        if ([segue.destinationViewController respondsToSelector:@selector(setTarget:)]) {
            [segue.destinationViewController performSelector:@selector(setTarget:) withObject:@"Settings"];
        }
    } else if ([segue.identifier isEqualToString:@"ShowTest"]) {
        if ([segue.destinationViewController respondsToSelector:@selector(setTarget:)]) {
            [segue.destinationViewController performSelector:@selector(setTarget:) withObject:@"Test"];
        }
    } else if ([segue.identifier isEqualToString:@"AddSettings"]) {
        if ([segue.destinationViewController respondsToSelector:@selector(setTarget:)]) {
            [segue.destinationViewController performSelector:@selector(setTarget:) withObject:@"Settings"];
        }
    } else if ([segue.identifier isEqualToString:@"AddTest"]) {
        if ([segue.destinationViewController respondsToSelector:@selector(setTarget:)]) {
            [segue.destinationViewController performSelector:@selector(setTarget:) withObject:@"Test"];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES animated:NO];
    self.navigationItem.title = [PFUser currentUser].email;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Logout:(id)sender {
    [[ParseHelper sharedInstance] logout];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
