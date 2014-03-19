//
//  ArticlesDetailViewController.m
//  USGBC
//
//  Created by Shekhar Chikara on 04/03/14.
//  Copyright (c) 2014 USGBC. All rights reserved.
//

#import "ArticlesDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "NSString+HTML.h"
#import "ArticleModel.h"

@interface ArticlesDetailViewController () <UIWebViewDelegate>

@end

@implementation ArticlesDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self.tabBarController.tabBar setHidden:YES];
    
    [self setupSwipeGestureRecognizer];
    
    [self loadArticleForIndex:self.index];
}

- (void) loadArticleForIndex:(NSString*)index{
    int count = [index intValue];
    ArticleModel* article = self.articles.articles[count];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MMMM dd, YYYY - h:ma"];
    NSDate* myDate = [df dateFromString:article.articlePostedDate];
    [df setDateFormat:@"dd MMMM, yyyy"];
    NSString *publishedDate = [df stringFromDate:myDate];
    
    NSString* postedDate = [NSString stringWithFormat:@"Posted on %@",publishedDate];
    
    NSString *htmlString = [NSString stringWithFormat:
                            @"<style>body{margin:0;padding:0} h1{font-size: 18px;} *{font-family:Helvetica;font-size:13px;</style>"
                            "<img src='%@' width=320px>"
                            "<div style='padding:10px'><h1>%@</h1>"
                            "<p>%@</p>"
                            "<p>In %@<hr></p>"
                            "%@</div>", article.articleImage, article.articleTitle, postedDate, article.articleChannel, article.articleBody];
    [self.navigationController setNavigationBarHidden:NO];
    [self.articleBody loadHTMLString:htmlString baseURL:nil];
}

- (void) setupSwipeGestureRecognizer {
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedScreen:)];
    swipeGesture.direction = (UISwipeGestureRecognizerDirectionLeft);
    [[self view] addGestureRecognizer:swipeGesture];
    
    swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedScreen:)];
    swipeGesture.direction = (UISwipeGestureRecognizerDirectionRight);
    [[self view] addGestureRecognizer:swipeGesture]; 
}

- (void)swipedScreen:(UISwipeGestureRecognizer*)gesture
{
    if (gesture.direction == UISwipeGestureRecognizerDirectionLeft) {
        int count = [self.index intValue];
        count++;
        if(count>=1 && count < self.articles.articles.count) {
            self.index = [NSString stringWithFormat:@"%d",count];
            [self loadArticleForIndex:self.index];
        }
    }
    if (gesture.direction == UISwipeGestureRecognizerDirectionRight){
        int count = [self.index intValue];
        count--;
        if(count>=0 && count < self.articles.articles.count) {
            self.index = [NSString stringWithFormat:@"%d",count];
            [self loadArticleForIndex:self.index];
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
