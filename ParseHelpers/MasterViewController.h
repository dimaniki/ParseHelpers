//
//  MasterViewController.h
//  ParseHelpers
//
//  Created by Mac on 03.11.13.
//  Copyright (c) 2013 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterViewController : UITableViewController<UISearchBarDelegate>

// Settings or Test table
@property (nonatomic, strong) NSString *target;

@end
