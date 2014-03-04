//
//  ArticlesTableViewCell.h
//  USGBC
//
//  Created by Shekhar Chikara on 04/03/14.
//  Copyright (c) 2014 USGBC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticlesTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *articleName;
@property (weak, nonatomic) IBOutlet UILabel *articlePublishedDate;
@property (weak, nonatomic) IBOutlet UILabel *articleBody;
@property (weak, nonatomic) IBOutlet UIImageView *articleImage;

@end
