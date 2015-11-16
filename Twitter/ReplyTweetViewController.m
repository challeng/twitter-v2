//
//  ReplyTweetViewController.m
//  Twitter
//
//  Created by Jim Challenger on 11/8/15.
//  Copyright © 2015 Jim Challenger. All rights reserved.
//

#import "ReplyTweetViewController.h"
#import "TwitterClient.h"

@interface ReplyTweetViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ReplyTweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Reply";
    UIBarButtonItem *replyButton = [[UIBarButtonItem alloc] initWithTitle:@"Reply" style:UIBarButtonItemStylePlain target:self action:@selector(onReply:)];
    self.navigationItem.rightBarButtonItem = replyButton;
    self.textView.text = [NSString stringWithFormat:@"@%@", self.username];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onReply:(id)sender {
    NSLog(@"Replying...");
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.idString forKey:@"in_reply_to_status_id"];
    [params setValue:self.textView.text forKey:@"status"];
    [[TwitterClient sharedInstance] replyTweetWithParams:params completion:^(NSObject *tweet, NSError *error) {
        if (tweet != nil) {
            NSLog(@"Replied");
        }
        [self.navigationController popViewControllerAnimated:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }];
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
