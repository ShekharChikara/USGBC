//
//  LoadingTableViewCell.h
//  USGBC
//
//  Created by Shekhar Chikara on 05/03/14.
//  Copyright (c) 2014 USGBC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *loadingText;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;

@end
