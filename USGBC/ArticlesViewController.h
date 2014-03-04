//
//  ArticlesViewController.h
//  USGBC
//
//  Created by Shekhar Chikara on 04/03/14.
//  Copyright (c) 2014 USGBC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticlesModel.h"

@interface ArticlesViewController : UITableViewController

@property (strong, nonatomic) ArticlesModel* articles;

@end
