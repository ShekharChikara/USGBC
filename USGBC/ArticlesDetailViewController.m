//
//  ArticlesDetailViewController.m
//  USGBC
//
//  Created by Shekhar Chikara on 04/03/14.
//  Copyright (c) 2014 USGBC. All rights reserved.
//

#import "ArticlesDetailViewController.h"
#import "UIImageView+WebCache.h"

@interface ArticlesDetailViewController () 

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
    
    [self.scrollView setScrollEnabled:YES];
    
	// Do any additional setup after loading the view.
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.tabBarController.tabBar setHidden:YES];
    
    [self.articleImage setImageWithURL:[NSURL URLWithString:self.article.articleImage]];
    
    [self.articleTitle setText:self.article.articleTitle];
    
    [self.articleChannel setText:[NSString stringWithFormat:@"In %@",self.article.articleChannel]];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MMMM dd, YYYY - h:ma"];
    NSDate* myDate = [df dateFromString:self.article.articlePostedDate];
    [df setDateFormat:@"dd MMMM, yyyy"];
    NSString *publishedDate = [df stringFromDate:myDate];
    
    self.articlePostedDate.text = [NSString stringWithFormat:@"Posted on %@",publishedDate];
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[self.article.articleBody dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    [self.articleBody setAttributedText:attributedString];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
