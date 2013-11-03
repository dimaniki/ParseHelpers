//
//  ParseHelper.h
//  ParseHelpers
//
//  Created by Mac on 03.11.13.
//  Copyright (c) 2013 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface ParseHelper : NSObject

+(ParseHelper *)sharedInstance;

-(void)login:(NSString*)login password:(NSString*)password block:(void (^)(PFUser *user, NSError *error))block;
-(void)loginFacebook:(void (^)(PFUser *user, NSError *error))block;
-(void)signup:(NSString*)login password:(NSString*)password email:(NSString*)email block:(void (^)(BOOL succeeded, NSError *error))block;
-(void)logout;

//Insert new object in particular table
-(void)insertTo:(NSString*)table id:(NSString*)field_id field2:(NSString*)field2 field3:(NSString*)field3 block:(void (^)(BOOL succeeded, NSError *error))block;

//Insert object, if it doesn't exist
-(void)conditionalInsertTo:(NSString*)table id:(NSString*)field_id field2:(NSString*)field2 field3:(NSString*)field3 success:(void (^)(void))success objectExists:(void (^)(void))objectExists;

//Updates given object
-(void)update:(PFObject*)object id:(NSString*)field_id field2:(NSString*)field2 field3:(NSString*)field3 block:(void (^)(BOOL succeeded, NSError *error))block;

//Updated object by Id
-(void)conditionalUpdate:(NSString*)table objectId:(NSString*)objectId field2:(NSString*)field2 field3:(NSString*)field3 success:(void (^)(void))success notFound:(void (^)(void))notFound;

//Get all objects from table
-(void)selectFrom:(NSString*)table block:(void (^)(NSArray *objects, NSError *error))block;

//Find objects by keyWord
-(void)conditionalSelectFrom:(NSString*)table keyWord:(NSString*)keyWord block:(void (^)(NSArray *objects, NSError *error))block;

//Delete given object
-(void)delete:(PFObject*)object block:(void (^)(BOOL succeeded, NSError *error))block;

//Detele object by Id if it exists
-(void)conditionalDelete:(NSString*)table objectId:(NSString*)objectId success:(void (^)(void))success notFound:(void (^)(void))notFound;

@end
