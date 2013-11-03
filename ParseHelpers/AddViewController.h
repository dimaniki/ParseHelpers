//
//  AddViewController.h
//  ParseHelpers
//
//  Created by Mac on 03.11.13.
//  Copyright (c) 2013 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddViewController : UIViewController

//Fields of table
@property (weak, nonatomic) IBOutlet UITextField *field_id;
@property (weak, nonatomic) IBOutlet UITextField *field2;
@property (weak, nonatomic) IBOutlet UITextField *field3;

// Settings or Test table
@property (nonatomic, strong) NSString *target;

- (IBAction)add:(id)sender;

@end
