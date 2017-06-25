//
//  PDEvent.h
//  TestTask
//
//  Created by Lavrin on 6/25/17.
//  Copyright © 2017 Lavrin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDEvent : NSObject

@property (strong, nonatomic) NSString *login;
@property (strong, nonatomic) NSURL *avatarURL;
@property (strong, nonatomic) NSString *creationDate;
@property (strong, nonatomic) NSString *typeOfEvent;
@property (strong, nonatomic) NSString *repoURL;


- (id) initWithServerResponse:(NSDictionary *) response;

@end
