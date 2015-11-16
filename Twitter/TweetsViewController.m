//
//  TweetsViewController.m
//  Twitter
//
//  Created by Jim Challenger on 11/8/15.
//  Copyright © 2015 Jim Challenger. All rights reserved.
//

#import "TweetsViewController.h"
#import "User.h"
#import "TwitterClient.h"
#import "Tweet.h"
#import "TweetCell.h"
#import <UIImageView+AFNetworking.h>
#import "ComposeTweetViewController.h"
#import "TweetDetailsViewController.h"

@interface TweetsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *tweets;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property BOOL mentions;

@end

@implementation TweetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.mentions) {
        [self fetchMentions];
    } else {
        [self fetchTweets];
    }
    
    [self setupTable];
    [self setUpRefreshControl];
    [self setUpNavbar];
}

- (id)initWithNibNameForMentions:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.mentions = YES;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    if (self.mentions) {
        [self fetchMentions];
    } else {
        [self fetchTweets];
    }
}

- (void)setUpNavbar {
    self.title = @"Home";
    UIBarButtonItem *composeButton = [[UIBarButtonItem alloc] initWithTitle:@"Compose" style:UIBarButtonItemStylePlain target:self action:@selector(onCompose:)];
    self.navigationItem.rightBarButtonItem = composeButton;
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(onLogout:)];
    self.navigationItem.leftBarButtonItem = logoutButton;
}

- (void)setUpRefreshControl {
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchTweets) forControlEvents:UIControlEventValueChanged];
    UITableViewController *dummyTableVC = [[UITableViewController alloc] init];
    dummyTableVC.tableView = self.tableView;
    dummyTableVC.refreshControl = self.refreshControl;
}

- (void)setupTable {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 120;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    TweetDetailsViewController *vc = [[TweetDetailsViewController alloc] init];
    vc.tweet = self.tweets[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    Tweet *tweet = self.tweets[indexPath.row];
    User *user = tweet.user;
    
    cell.tweetLabel.text = tweet.text;
    cell.userName.text = tweet.user.name;
    cell.screennameLabel.text = [NSString stringWithFormat:@"@%@", tweet.user.screename];
    
    if ([tweet.didRetweet boolValue] == YES) {
        cell.retweetedLabel.text = @"Retweeted by you";
    } else {
        cell.retweetedLabel.text = @"Not retweeted";
    }
    
    cell.favoriteCountLabel.text = [NSString stringWithFormat:@"%@ favorites", tweet.favoriteCount];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yy"];
    NSString *stringFromDate = [formatter stringFromDate:tweet.createdAt];
    cell.timestamp.text = stringFromDate;
    
    [cell.userImage setImageWithURL:[NSURL URLWithString:user.profileImageUrl]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (void)reloadData {
    if (self.mentions) {
        [self fetchMentions];
    } else {
        [self fetchTweets];
    }
}

- (void)fetchTweets {
    [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        self.tweets = tweets;
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }];
}

- (void)fetchMentions {
    [[TwitterClient sharedInstance] mentionsWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        self.tweets = tweets;
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }];
}


- (IBAction)onLogout:(id)sender {
    [User logout];
}

- (IBAction)onCompose:(id)sender {
    ComposeTweetViewController *vc = [[ComposeTweetViewController alloc] init];
//    [self presentViewController:vc animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
