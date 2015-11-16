//
//  TweetDetailsViewController.m
//  Twitter
//
//  Created by Jim Challenger on 11/8/15.
//  Copyright © 2015 Jim Challenger. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "TwitterClient.h"
#import "TweetsViewController.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"
#import "ReplyTweetViewController.h"

@interface TweetDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;

@end

@implementation TweetDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Tweet";
    
    self.nameLabel.text = self.tweet.user.name;
    self.tweetLabel.text = self.tweet.text;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yy"];
    NSString *stringFromDate = [formatter stringFromDate:self.tweet.createdAt];
    self.timestampLabel.text = stringFromDate;
    
    [self.imageView setImageWithURL:[NSURL URLWithString:self.tweet.user.profileImageUrl]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onFavorite:(id)sender {
    [[TwitterClient sharedInstance] favoriteTweetForId:self.tweet.idString completion:^(NSObject *tweet, NSError *error) {
        if (tweet != nil) {
            NSLog(@"favorited");
        }
    }];
    
}
- (IBAction)onRetweet:(id)sender {
    NSLog(@"Retweeting...");
    [[TwitterClient sharedInstance] retweetForId:self.tweet.idString completion:^(NSObject *tweet, NSError *error) {
        if (tweet != nil) {
            NSLog(@"retweeted");
        }
    }];
}
- (IBAction)onReply:(id)sender {
    ReplyTweetViewController *vc = [[ReplyTweetViewController alloc] init];
    vc.idString = self.tweet.idString;
    vc.username = self.tweet.user.screename;
    [self.navigationController pushViewController:vc animated:YES];
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
