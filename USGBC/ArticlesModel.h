//
//  ArticlesModel.h
//  USGBC
//
//  Created by Shekhar Chikara on 04/03/14.
//  Copyright (c) 2014 USGBC. All rights reserved.
//

#import "JSONModel.h"
#import "ArticleModel.h"

@protocol ArticlesModel
@end

@interface ArticlesModel : JSONModel

@property (strong, nonatomic) NSArray<ArticleModel>* articles;

@end
