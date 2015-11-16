//
//  ComposeTweetViewController.m
//  Twitter
//
//  Created by Jim Challenger on 11/8/15.
//  Copyright © 2015 Jim Challenger. All rights reserved.
//

#import "ComposeTweetViewController.h"
#import "TweetsViewController.h"
#import "TwitterClient.h"

@interface ComposeTweetViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ComposeTweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Compose";
    UIBarButtonItem *tweetButton = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onTweet:)];
    self.navigationItem.rightBarButtonItem = tweetButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onTweet:(id)sender {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.textView.text forKey:@"status"];
    [[TwitterClient sharedInstance] publishTweetWithParams:params completion:^(NSObject *tweet, NSError *error) {
        [self toHome];
    }];
}

- (void)toHome {
    [self.navigationController popViewControllerAnimated:YES];
//    TweetsViewController *vc = [[TweetsViewController alloc] init];
//    [self presentViewController:vc animated:YES completion:nil];
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
