//
//  MenuViewController.m
//  Twitter
//
//  Created by Jim Challenger on 11/14/15.
//  Copyright © 2015 Jim Challenger. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuTableViewCell.h"
#import "TweetsViewController.h"
#import "ProfileViewController.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *viewControllers;
@property (strong, nonatomic) NSArray *cellLabels;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cellLabels = @[@"Tweets", @"Mentions", @"Profile"];
    self.viewControllers = [NSMutableArray array];
    
    TweetsViewController *tweetsViewController = [[TweetsViewController alloc] init];
    UINavigationController *tweetsNavigationController = [[UINavigationController alloc] initWithRootViewController:tweetsViewController];
    [self.viewControllers addObject:tweetsNavigationController];
    
    TweetsViewController *mentionsViewController = [[TweetsViewController alloc] initWithNibNameForMentions:@"TweetsViewController" bundle:nil];
    UINavigationController *mentionsNavigationController = [[UINavigationController alloc] initWithRootViewController:mentionsViewController];
    [self.viewControllers addObject:mentionsNavigationController];
    
    ProfileViewController *profileViewController = [[ProfileViewController alloc] init];
    UINavigationController *profileNavigationController = [[UINavigationController alloc] initWithRootViewController:profileViewController];
    [self.viewControllers addObject:profileNavigationController];
    
//    self.hamburgerViewController.contentViewController = tweetsNavigationController;
//    self.hamburgerViewController.contentViewController = tweetsViewController;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"MenuTableViewCell" bundle:nil] forCellReuseIdentifier:@"MenuCell"];
    [self.tableView reloadData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell"];
    
    cell.titleLabel.text = self.cellLabels[indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.hamburgerViewController.contentViewController = self.viewControllers[indexPath.row];
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
