//
//  ProjectsTableViewCell.h
//  USGBC
//
//  Created by Shekhar Chikara on 14/03/14.
//  Copyright (c) 2014 USGBC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *projectName;
@property (weak, nonatomic) IBOutlet UILabel *projectCertifiedDate;
@property (weak, nonatomic) IBOutlet UILabel *projectFoundationStatement;
@property (weak, nonatomic) IBOutlet UIImageView *projectImage;

@end
