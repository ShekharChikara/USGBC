//
//  ProjectsViewController.m
//  USGBC
//
//  Created by Shekhar Chikara on 04/03/14.
//  Copyright (c) 2014 USGBC. All rights reserved.
//
#import "ProjectsViewController.h"
#import "ArticlesModel.h"
#import "JSONModelLib.h"
#import "HUD.h"
#import "UIImageView+WebCache.h"
#import "ArticlesDetailViewController.h"
#import "UIScrollView+SVInfiniteScrolling.h"
#import "NSString+HTML.h"
#import "LoadingTableViewCell.h"
#import "ProjectsTableViewCell.h"
#import "ProjectsDetailViewController.h"

#define STRING_LENGTH 25
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ProjectsViewController () <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UITableView* table;
    NSInteger count;
    ProjectsModel* newProjects;
}
@end

@implementation ProjectsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    count = 1;
    
    //show loader view
    [HUD showUIBlockingIndicatorWithText:@"Loading Projects"];
    
    [table setBackgroundColor:UIColorFromRGB(0xe5e4e2)];
    
    [self loadDataIntoTable];
}

-(void)loadDataIntoTable {
    
    NSString* projectsUrl = [NSString stringWithFormat:@"http://in.usgbc.org/mobile/services/projects"];
    
    //fetch the feed
    self.projects = [[ProjectsModel alloc] initFromURLWithString:projectsUrl
                                                      completion:^(JSONModel *model, JSONModelError *err) {
                                                          
                                                          //hide the loader view
                                                          [HUD hideUIBlockingIndicator];
                                                          
                                                          //load the data into table
                                                          [table reloadData];
                                                      }];
}

#pragma mark - table methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.projects.nodes count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView
       cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *projectIdentifier   = @"ProjectsCell";
    
    ProjectsTableViewCell* cell = (ProjectsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:projectIdentifier];
    
    if (cell == nil) {
        cell = [[ProjectsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:projectIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
    }
    
    ProjectModel* project = self.projects.nodes[indexPath.row];
    
    NSString* title = [project.name stringByDecodingHTMLEntities];
    [cell.projectName setText:title];
    
    NSString* body = [project.foundation_statement stringByDecodingHTMLEntities];
    [cell.projectFoundationStatement setText:body];
    
    [cell.projectImage setImageWithURL:[NSURL URLWithString:project.image]
                      placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MMMM dd, YYYY - h:ma"];
    NSDate* myDate = [df dateFromString:project.date_certification];
    [df setDateFormat:@"dd MMMM, yyyy"];
    NSString *publishedDate = [df stringFromDate:myDate];
    
    cell.projectCertifiedDate.text = [NSString stringWithFormat:@"Certified on %@",publishedDate];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat projectsCellHeight = 65.0;
    return projectsCellHeight;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)sender{
    NSString* segueIdentifier = [segue identifier];
    if([segueIdentifier isEqualToString:@"projectsCellSegue"]){
        NSIndexPath *indexPath = [sender isKindOfClass:[NSIndexPath class]] ? (NSIndexPath*)sender : [self->table indexPathForSelectedRow];
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
        ProjectsDetailViewController* adv = [segue destinationViewController];
        ProjectModel *project = self.projects.nodes[indexPath.row];
        [adv setProject:project];
    }
}
/*
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
    if (endScrolling >= scrollView.contentSize.height)
    {
        NSLog(@"Table view bottom reached");
        static NSString *articleIdentifier   = @"ArticlesLoadingCell";
        
        //Show table footer
        LoadingTableViewCell* cell = (LoadingTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:articleIdentifier];
        
        if (cell == nil) {
            cell = [[LoadingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:articleIdentifier];
            cell.accessoryType = UITableViewCellAccessoryDetailButton;
        }
        cell.loadingText.text = @"Loading Articles";
        [cell.loadingIndicator startAnimating];
        [table setTableFooterView:cell];
        [self loadMoreArticles];
    }
}

-(void)loadMoreArticles {
    NSString* articlesUrl = [NSString stringWithFormat:@"http://in.usgbc.org/mobile/services/articlesjson?page=%d",count++];
    
    //fetch the next page data
    newArticles = [[ArticlesModel alloc] initFromURLWithString:articlesUrl
                                                    completion:^(JSONModel *model, JSONModelError *err) {
                                                        
                                                        [self.articles.articles addObjectsFromArray:newArticles.articles];
                                                        
                                                        if(newArticles.articles.count < 10) {
                                                            [table setTableFooterView:nil];
                                                        }
                                                        
                                                        //load the data into table
                                                        [table reloadData];
                                                    }];
}
*/
- (void)viewWillAppear:(BOOL)animated{
    if(self.tabBarController.tabBar.isHidden)  {
        self.tabBarController.tabBar.hidden = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
