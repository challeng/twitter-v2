//
//  ProfileViewController.m
//  Twitter
//
//  Created by Jim Challenger on 11/15/15.
//  Copyright © 2015 Jim Challenger. All rights reserved.
//

#import "ProfileViewController.h"
#import <UIImageView+AFNetworking.h>

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tweetCount;
@property (weak, nonatomic) IBOutlet UILabel *followingCount;
@property (weak, nonatomic) IBOutlet UILabel *followerCount;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property BOOL customUser;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Profile";
    
    if (self.user == nil) {
        self.user = [User currentUser];
    }
    
    self.tweetCount.text = [NSString stringWithFormat:@"%@", self.user.tweetCount];
    self.followingCount.text = [NSString stringWithFormat:@"%@", self.user.followingCount];
    self.followerCount.text = [NSString stringWithFormat:@"%@", self.user.followerCount];
    self.nameLabel.text = self.user.name;
    self.screenameLabel.text = [NSString stringWithFormat:@"@%@", self.user.screename];
    [self.profileImage setImageWithURL:[NSURL URLWithString:self.user.profileImageUrl]];
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
