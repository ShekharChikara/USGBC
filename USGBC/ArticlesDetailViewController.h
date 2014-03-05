//
//  ArticlesDetailViewController.h
//  USGBC
//
//  Created by Shekhar Chikara on 04/03/14.
//  Copyright (c) 2014 USGBC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleModel.h"

@interface ArticlesDetailViewController : UIViewController

@property (strong, nonatomic) ArticleModel* article;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView* articleImage;
@property (weak, nonatomic) IBOutlet UILabel* articleTitle;
@property (weak, nonatomic) IBOutlet UILabel* articlePostedDate;
@property (weak, nonatomic) IBOutlet UILabel* articleChannel;
@property (weak, nonatomic) IBOutlet UITextView* articleBody;

@end
