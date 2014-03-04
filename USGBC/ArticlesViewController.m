//
//  ArticlesViewController.m
//  USGBC
//
//  Created by Shekhar Chikara on 04/03/14.
//  Copyright (c) 2014 USGBC. All rights reserved.
//

#import "ArticlesViewController.h"
#import "ArticlesTableViewCell.h"
#import "ArticlesModel.h"
#import "ArticleModel.h"
#import "JSONModelLib.h"
#import "HUD.h"
#import "UIImageView+WebCache.h"
#import "ArticlesDetailViewController.h"

#define credentialsSection 0
#define cehoursSection 1
#define STRING_LENGTH 25
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ArticlesViewController () <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UITableView* table;
}

@end

@implementation ArticlesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //show loader view
    [HUD showUIBlockingIndicatorWithText:@"Loading Articles"];
    
    [table setBackgroundColor:UIColorFromRGB(0xe5e4e2)];
    
    [self loadDataIntoTable];
}

-(void)loadDataIntoTable {
    
    NSString* articlesUrl = [NSString stringWithFormat:@"http://in.usgbc.org/mobile/services/articlesjson"];
    
    //fetch the feed
    self.articles = [[ArticlesModel alloc] initFromURLWithString:articlesUrl
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
    return [self.articles.articles count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView
       cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *articleIdentifier   = @"ArticlesCell";
    
    ArticlesTableViewCell* cell = (ArticlesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:articleIdentifier];
        
    if (cell == nil) {
        cell = [[ArticlesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:articleIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
    }
        
    ArticleModel* article = self.articles.articles[indexPath.row];
    
    [cell.articleName setText:article.articleTitle];
    
    [cell.articleBody setText:article.articleSummary];
        
    [cell.articleImage setImageWithURL:[NSURL URLWithString:article.articleImageSmall]
                      placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MMMM dd, YYYY - h:ma"];
    NSDate* myDate = [df dateFromString:article.articlePostedDate];
    [df setDateFormat:@"dd MMMM, yyyy"];
    NSString *publishedDate = [df stringFromDate:myDate];
        
    cell.articlePublishedDate.text = [NSString stringWithFormat:@"Posted on %@",publishedDate];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat articlesCellHeight = 85.0;
    return articlesCellHeight;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)sender{
    NSString* segueIdentifier = [segue identifier];
    if([segueIdentifier isEqualToString:@"articlesCellSegue"]){
        NSIndexPath *indexPath = [sender isKindOfClass:[NSIndexPath class]] ? (NSIndexPath*)sender : [self->table indexPathForSelectedRow];
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
        ArticlesDetailViewController* adv = [segue destinationViewController];
        ArticleModel *article = self.articles.articles[indexPath.row];
        [adv setArticle:article];
    } 
}

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