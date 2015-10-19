//
//  GHIssue.h
//  MantleDemo
//
//  Created by Terwer Green on 15/10/12.
//  Copyright © 2015年 Terwer Green. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    GHIssueStateOpen,
    GHIssueStateClosed
} GHIssueState;

@class GHUser;
@interface GHIssue : NSObject <NSCoding, NSCopying>

@property (nonatomic, copy, readonly) NSURL *URL;
@property (nonatomic, copy, readonly) NSURL *HTMLURL;
@property (nonatomic, copy, readonly) NSNumber *number;
@property (nonatomic, assign, readonly) GHIssueState state;
@property (nonatomic, copy, readonly) NSString *reporterLogin;
@property (nonatomic, copy, readonly) NSDate *updatedAt;
@property (nonatomic, strong, readonly) GHUser *assignee;
@property (nonatomic, copy, readonly) NSDate *retrievedAt;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *body;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
