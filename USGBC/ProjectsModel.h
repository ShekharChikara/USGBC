//
//  ProjectsModel.h
//  USGBC
//
//  Created by Shekhar Chikara on 14/03/14.
//  Copyright (c) 2014 USGBC. All rights reserved.
//

#import "JSONModel.h"
#import "ProjectModel.h"

@protocol ProjectsModel
@end

@interface ProjectsModel : JSONModel

@property (strong, nonatomic) NSMutableArray<ProjectModel>* nodes;

@end
