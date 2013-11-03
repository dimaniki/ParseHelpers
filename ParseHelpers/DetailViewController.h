//
//  DetailViewController.h
//  ParseHelpers
//
//  Created by Mac on 03.11.13.
//  Copyright (c) 2013 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) PFObject* detailItem;
@property (weak, nonatomic) IBOutlet UITextField *field_id;
@property (weak, nonatomic) IBOutlet UITextField *field2;
@property (weak, nonatomic) IBOutlet UITextField *field3;

// Settings or Test table
@property (nonatomic, strong) NSString *target;

- (IBAction)update:(id)sender;
- (IBAction)remove:(id)sender;
@end
