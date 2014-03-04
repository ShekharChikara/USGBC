//
//  ArticleModel.m
//  USGBC
//
//  Created by Shekhar Chikara on 04/03/14.
//  Copyright (c) 2014 USGBC. All rights reserved.
//

#import "ArticleModel.h"

@implementation ArticleModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                @"article.articleTitle": @"articleTitle",
                                @"article.articleBody": @"articleBody",
                                @"article.articlePostedDate": @"articlePostedDate",
                                @"article.articleImage": @"articleImage",
                                @"article.articleChannel": @"articleChannel",
                                @"article.articleUsername": @"articleUsername",
                                @"article.articleImageSmall": @"articleImageSmall",
                                @"article.articleSummary": @"articleSummary"
                            }];
}

@end
