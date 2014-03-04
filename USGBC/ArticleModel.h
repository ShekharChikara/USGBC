//
//  ArticleModel.h
//  USGBC
//
//  Created by Shekhar Chikara on 04/03/14.
//  Copyright (c) 2014 USGBC. All rights reserved.
//

#import "JSONModel.h"

@protocol ArticleModel
@end

@interface ArticleModel : JSONModel

@property (strong, nonatomic) NSString* articleTitle;
@property (strong, nonatomic) NSString* articleBody;
@property (strong, nonatomic) NSString* articlePostedDate;
@property (strong, nonatomic) NSString* articleImage;
@property (strong, nonatomic) NSString* articleChannel;
@property (strong, nonatomic) NSString* articleUsername;
@property (strong, nonatomic) NSString* articleImageSmall;
@property (strong, nonatomic) NSString* articleSummary;

@end
