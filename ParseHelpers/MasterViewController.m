//
//  MasterViewController.m
//  ParseHelpers
//
//  Created by Mac on 03.11.13.
//  Copyright (c) 2013 Mac. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "ParseHelper.h"

@interface MasterViewController () {
    NSArray *_objects;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = self.target;
}

-(void)viewDidAppear:(BOOL)animated
{
    [[ParseHelper sharedInstance] selectFrom:self.target block:^(NSArray *objects, NSError *error) {
        if (!error) {
            _objects = objects;
            [self.tableView reloadData];
        }
    }];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [[ParseHelper sharedInstance] conditionalSelectFrom:self.target keyWord:searchText block:^(NSArray *objects, NSError *error) {
        if (!error) {
            _objects = objects;
            [self.tableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    PFObject *object = _objects[indexPath.row];
    cell.textLabel.text = object[@"field2"];
    cell.detailTextLabel.text = object[@"field3"];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PFObject *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
        if ([segue.destinationViewController respondsToSelector:@selector(setTarget:)]) {
            [segue.destinationViewController performSelector:@selector(setTarget:) withObject:self.target];
        }
    }
}

@end
