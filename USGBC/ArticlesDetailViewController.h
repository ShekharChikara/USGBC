//
//  ArticlesDetailViewController.h
//  USGBC
//
//  Created by Shekhar Chikara on 04/03/14.
//  Copyright (c) 2014 USGBC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticlesModel.h"

@interface ArticlesDetailViewController : UIViewController

@property (strong, nonatomic) ArticlesModel* articles;
@property (strong, nonatomic) NSString* index;
@property (weak, nonatomic) IBOutlet UIWebView* articleBody;

@end
