//
//  DetailViewController.m
//  ParseHelpers
//
//  Created by Mac on 03.11.13.
//  Copyright (c) 2013 Mac. All rights reserved.
//

#import "DetailViewController.h"
#import "ParseHelper.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.field_id.text = self.detailItem[@"field_id"];
        self.field2.text = self.detailItem[@"field2"];
        self.field3.text = self.detailItem[@"field3"];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)update:(id)sender
{
    if ([self.target isEqualToString:@"Test"]) {
        [[ParseHelper sharedInstance] update:self.detailItem id:self.field_id.text field2:self.field2.text field3:self.field3.text block:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Update failed" message:[[error userInfo] objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        }];
    } else
    {
        [[ParseHelper sharedInstance] conditionalUpdate:@"Settings" objectId:self.field_id.text field2:self.field2.text field3:self.field3.text success:^{
            [self.navigationController popViewControllerAnimated:YES];
        } notFound:^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Update failed" message:@"Object not found"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }];
    }
}

- (IBAction)remove:(id)sender
{
    if ([self.target isEqualToString:@"Test"]) {
        [[ParseHelper sharedInstance] delete:self.detailItem block:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete failed" message:[[error userInfo] objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        }];
    } else
    {
        [[ParseHelper sharedInstance] conditionalDelete:@"Settings" objectId:self.detailItem[@"field_id"] success:^{
            [self.navigationController popViewControllerAnimated:YES];
        } notFound:^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete failed" message:@"Object not found"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }];
    }
}

@end
