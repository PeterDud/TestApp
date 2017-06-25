//
//  PDServerManager.h
//  TestTask
//
//  Created by Lavrin on 6/25/17.
//  Copyright © 2017 Lavrin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PDServerManager : NSObject

+ (PDServerManager *) sharedManager;

- (void) getEventsFromPage:(NSInteger) pageNumber
                 OnSuccess:(void(^)(NSArray *events)) success
                 onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;

- (void) getRepoWebView:(NSString *) repoURL
              onSuccess:(void(^)(NSString *webViewURL)) success
              onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;

@end
