//
//  HamburgerViewController.m
//  Twitter
//
//  Created by Jim Challenger on 11/14/15.
//  Copyright © 2015 Jim Challenger. All rights reserved.
//

#import "HamburgerViewController.h"
#import "MenuViewController.h"

@interface HamburgerViewController ()
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak , nonatomic) IBOutlet NSLayoutConstraint *leftMarginConstraint;
@property CGFloat originalLeftMargin;

@end

@implementation HamburgerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setMenuViewController:(UIViewController *)menuViewController {
    [self.view layoutIfNeeded];
    
    if (_menuViewController != nil) {
        [_menuViewController willMoveToParentViewController:nil];
        [_menuViewController.view removeFromSuperview];
        [_menuViewController didMoveToParentViewController:nil];
    }
    
    [menuViewController willMoveToParentViewController:self];
    [self.menuView addSubview:menuViewController.view];
    [menuViewController didMoveToParentViewController:self];
    
    _menuViewController = menuViewController;
}

- (void)setContentViewController:(UIViewController *)contentViewController {
    [self.view layoutIfNeeded];
    
    if (_contentViewController != nil) {
        [_contentViewController willMoveToParentViewController:nil];
        [_contentViewController.view removeFromSuperview];
        [_contentViewController didMoveToParentViewController:nil];
    }
    
    [contentViewController willMoveToParentViewController:self];
    [self.contentView addSubview:contentViewController.view];
    [contentViewController didMoveToParentViewController:self];
    
    _contentViewController = contentViewController;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self closeMenu];
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)onPanGesture:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:self.view];
    CGPoint velocity = [sender velocityInView:self.view];
    
    [UIView animateWithDuration:0.3 animations:^{
        if (sender.state == UIGestureRecognizerStateBegan) {
            self.originalLeftMargin = self.leftMarginConstraint.constant;
            
        } else if (sender.state == UIGestureRecognizerStateChanged) {
            self.leftMarginConstraint.constant = self.originalLeftMargin + translation.x;
            
        } else if (sender.state == UIGestureRecognizerStateEnded) {
            if (velocity.x > 0) {
                [self openMenu];
            } else {
                [self closeMenu];
            }
            [self.view layoutIfNeeded];
        }
    }];
}

- (void)closeMenu {
    self.leftMarginConstraint.constant = 0;
}

- (void)openMenu {
    self.leftMarginConstraint.constant = self.view.frame.size.width - 250;
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
