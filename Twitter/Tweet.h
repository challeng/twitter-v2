//
//  Tweet.h
//  Twitter
//
//  Created by Jim Challenger on 11/7/15.
//  Copyright © 2015 Jim Challenger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) NSString *idString;
@property (nonatomic, strong) NSString *favoriteCount;
@property (nonatomic, strong) NSString *didRetweet;

- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)tweetsWithArray:(NSArray *)array;

@end
