//
//  ProjectModel.h
//  USGBC
//
//  Created by Shekhar Chikara on 14/03/14.
//  Copyright (c) 2014 USGBC. All rights reserved.
//

#import "JSONModel.h"

@protocol ProjectModel @end

@interface ProjectModel : JSONModel

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* rating_system;
@property (strong, nonatomic) NSString* certification_level;
@property (strong, nonatomic) NSString* image;
@property (strong, nonatomic) NSString* image2;
@property (strong, nonatomic) NSString* foundation_statement;
@property (strong, nonatomic) NSString* description;
@property (strong, nonatomic) NSString* address;
@property (strong, nonatomic) NSString* city;
@property (strong, nonatomic) NSString* state;
@property (strong, nonatomic) NSString* date_certification;


@end
