//
//  LoginViewController.m
//  Twitter
//
//  Created by Jim Challenger on 11/4/15.
//  Copyright © 2015 Jim Challenger. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"
#import "TweetsViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
- (IBAction)onLogin:(id)sender {
    [[TwitterClient sharedInstance] loginWithCompletion:^(User *user, NSError *error) {
        if (user != nil) {
           // Modally present tweets view
            TweetsViewController *vc = [[TweetsViewController alloc] init];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];

            [self presentViewController:navigationController animated:YES completion:nil];
        } else {
            // Present error view
        }
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
