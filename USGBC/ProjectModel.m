//
//  ProjectModel.m
//  USGBC
//
//  Created by Shekhar Chikara on 14/03/14.
//  Copyright (c) 2014 USGBC. All rights reserved.
//

#import "ProjectModel.h"

@implementation ProjectModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"node.name": @"name",
                                                       @"node.rating_system": @"rating_system",
                                                       @"node.certification_level": @"certification_level",
                                                       @"node.image": @"image",
                                                       @"node.image2": @"image2",
                                                       @"node.foundation_statement": @"foundation_statement",
                                                       @"node.description": @"description",
                                                       @"node.address": @"address",
                                                       @"node.city": @"city",
                                                       @"node.state": @"state",
                                                       @"node.date_certification": @"date_certification",
                                                       }];
}

@end