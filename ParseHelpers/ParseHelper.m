//
//  ParseHelper.m
//  ParseHelpers
//
//  Created by Mac on 03.11.13.
//  Copyright (c) 2013 Mac. All rights reserved.
//

#import "ParseHelper.h"

@implementation ParseHelper

static ParseHelper *sharedInstance = nil;

+(ParseHelper *)sharedInstance
{
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        sharedInstance = [[ParseHelper alloc] init];
    });
    return sharedInstance;
}

// Parse recommends to use *InBackground methods always so not to block calling thread
-(void)login:(NSString*)login password:(NSString*)password block:(void (^)(PFUser *user, NSError *error))block
{
    [PFUser logInWithUsernameInBackground:login password:password block:block];
}

// Permissions let you get extra info from facebook
-(void)loginFacebook:(void (^)(PFUser *user, NSError *error))block
{
    NSArray *permissionsArray = @[ @"user_about_me", @"user_birthday"];
    
    [PFFacebookUtils logInWithPermissions:permissionsArray block:block];
}

// We've enabled automatic user in AppDelegate, so for signin up we only neet to fill mandatory fields
-(void)signup:(NSString *)login password:(NSString *)password email:(NSString *)email block:(void (^)(BOOL, NSError *))block
{
    PFUser * user = [PFUser currentUser];
    user.username = login;
    user.email = email;
    user.password = password;
    [user saveInBackgroundWithBlock:block];
}

-(void)logout
{
    [PFUser logOut];
}

// We don't neet to create table on server - it will be created automatically by ClassName
// Additionaly to using blocks for callback we can use selectors, but I find it less convinient
-(void)insertTo:(NSString*)table id:(NSString*)field_id field2:(NSString*)field2 field3:(NSString*)field3 block:(void (^)(BOOL succeeded, NSError *error))block
{
    PFObject *object = [PFObject objectWithClassName:table];
    [object setValue:[PFUser currentUser] forKey:@"user"];
    [object setValue:field_id forKey:@"field_id"];
    [object setValue:field2 forKey:@"field2"];
    [object setValue:field3 forKey:@"field3"];
    
    [object saveInBackgroundWithBlock:block];
}

// To make conditional insert we need to do 2 queries - first to check if object exists, and than do the rest
-(void)conditionalInsertTo:(NSString*)table id:(NSString*)field_id field2:(NSString*)field2 field3:(NSString*)field3 success:(void (^)(void))success objectExists:(void (^)(void))objectExists
{
    PFQuery *query = [PFQuery queryWithClassName:table];
    [query whereKey:@"field_id" equalTo:field_id];
    [query countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        if (number == 0) {
            
            PFObject *object = [PFObject objectWithClassName:table];
            [object setValue:[PFUser currentUser] forKey:@"user"];
            [object setValue:field_id forKey:@"field_id"];
            [object setValue:field2 forKey:@"field2"];
            [object setValue:field3 forKey:@"field3"];
            
            [object saveInBackground];
            if (success) {
                success();
            }
        } else{
            if (objectExists) {
                objectExists();
            }
        }
    }];

}

// Update is just setting fields to new values and save
-(void)update:(PFObject*)object id:(NSString*)field_id field2:(NSString*)field2 field3:(NSString*)field3 block:(void (^)(BOOL succeeded, NSError *error))block
{
    [object setValue:field_id forKey:@"field_id"];
    [object setValue:field2 forKey:@"field2"];
    [object setValue:field3 forKey:@"field3"];

    [object saveInBackgroundWithBlock:block];
}

// Conditional update requires to load object first
-(void)conditionalUpdate:(NSString*)table objectId:(NSString*)objectId field2:(NSString*)field2 field3:(NSString*)field3 success:(void (^)(void))success notFound:(void (^)(void))notFound
{
    PFQuery *query = [PFQuery queryWithClassName:table];
    [query whereKey:@"field_id" equalTo:objectId];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!error) {
            [object setValue:field2 forKey:@"field2"];
            [object setValue:field3 forKey:@"field3"];
            
            [object saveInBackground];
            if (success) {
                success();
            }
        } else{
            if (notFound) {
                notFound();
            }
        }
    }];
    
}

-(void)selectFrom:(NSString*)table block:(void (^)(NSArray *objects, NSError *error))block
{
    PFQuery *query = [PFQuery queryWithClassName:table];
    [query findObjectsInBackgroundWithBlock:block];
}

// As example of conditional select I implemented search by 2 fields in object with OR query.
// It's a bit obscure with Parse, but that's how it is
-(void)conditionalSelectFrom:(NSString*)table keyWord:(NSString*)keyWord block:(void (^)(NSArray *objects, NSError *error))block
{
    PFQuery *key1 = [PFQuery queryWithClassName:table];
    PFQuery *key2 = [PFQuery queryWithClassName:table];
    [key1 whereKey:@"field2" containsString:keyWord];
    [key2 whereKey:@"field3" containsString:keyWord];
    PFQuery *query = [PFQuery orQueryWithSubqueries:@[key1, key2]];
    [query findObjectsInBackgroundWithBlock:block];
}

-(void)delete:(PFObject*)object block:(void (^)(BOOL succeeded, NSError *error))block
{
    [object deleteInBackgroundWithBlock:block];
}

-(void)conditionalDelete:(NSString*)table objectId:(NSString*)objectId success:(void (^)(void))success notFound:(void (^)(void))notFound
{
    PFQuery *query = [PFQuery queryWithClassName:table];
    [query whereKey:@"field_id" equalTo:objectId];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!error) {
            [object deleteInBackground];
            if (success) {
                success();
            }
        } else{
            if (notFound) {
                notFound();
            }
        }
    }];
    
}

@end
