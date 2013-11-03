//
//  AddViewController.m
//  ParseHelpers
//
//  Created by Mac on 03.11.13.
//  Copyright (c) 2013 Mac. All rights reserved.
//

#import "AddViewController.h"
#import "ParseHelper.h"

@interface AddViewController ()

@end

@implementation AddViewController

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
    self.navigationItem.title = [NSString stringWithFormat:@"Add to %@", self.target];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)add:(id)sender {
    if ([self.target isEqualToString:@"Test"]) {
        [[ParseHelper sharedInstance] insertTo:self.target id:self.field_id.text field2:self.field2.text field3:self.field3.text block:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Object inserted" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            } else {
                NSString *errorString = [[error userInfo] objectForKey:@"error"];
                NSLog(@"Error signing normal: %@", errorString);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Signup failed" message:[[error userInfo] objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        }];
    } else
    {
        [[ParseHelper sharedInstance] conditionalInsertTo:self.target id:self.field_id.text field2:self.field2.text field3:self.field3.text success:^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Object inserted" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        } objectExists:^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Object exists" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }];
    }
    

}

@end
