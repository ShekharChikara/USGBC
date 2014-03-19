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
#import "UIScrollView+SVInfiniteScrolling.h"
#import "NSString+HTML.h"
#import "LoadingTableViewCell.h"

#define STRING_LENGTH 25
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ArticlesViewController () <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UITableView* table;
    NSInteger count;
    ArticlesModel* newArticles;
}

@end

@implementation ArticlesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    count = 1;
    
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
    
    NSString* title = [article.articleTitle stringByDecodingHTMLEntities];
    [cell.articleName setText:title];
    
    NSString* body = [article.articleSummary stringByDecodingHTMLEntities];
    [cell.articleBody setText:body];
        
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
        NSString* index = [NSString stringWithFormat:@"%d",indexPath.row];
        [adv setArticles:self.articles];
        [adv setIndex:index];
    } 
}

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
    NSString* articlesUrl = [NSString stringWithFormat:@"http://in.usgbc.org/mobile/services/articlesjson?page=%ld",(long)count++];
    
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
