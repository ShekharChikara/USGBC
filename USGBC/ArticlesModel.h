//
//  ArticlesModel.h
//  USGBC
//
//  Created by Shekhar Chikara on 04/03/14.
//  Copyright (c) 2014 USGBC. All rights reserved.
//

#import "JSONModelLib.h"
#import "ArticleModel.h"

@protocol ArticlesModel
@end

@interface ArticlesModel : JSONModel

@property (strong, nonatomic) NSMutableArray<ArticleModel>* articles;

@end
