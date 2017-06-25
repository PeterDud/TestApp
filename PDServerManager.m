//
//  PDServerManager.m
//  TestTask
//
//  Created by Lavrin on 6/25/17.
//  Copyright © 2017 Lavrin. All rights reserved.
//

#import "PDServerManager.h"
#import "AFNetworking.h"
#import "PDEvent.h"

@interface PDServerManager ()

@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;

@end

@implementation PDServerManager

+ (PDServerManager *) sharedManager {
    
    static PDServerManager *sharedManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[PDServerManager alloc] init];
    });
    return sharedManager;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        self.sessionManager = [[AFHTTPSessionManager alloc] init];
    }
    return self;
}

- (void) getEventsFromPage:(NSInteger) pageNumber
                 OnSuccess:(void(^)(NSArray *events)) success
                  onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure {
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @(pageNumber), @"page", nil];
    
    [self.sessionManager GET:@"https://api.github.com/events"
                  parameters:params
                    progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        
                        NSMutableArray *events = [NSMutableArray array];
                        
                        for (NSDictionary *dict in responseObject) {
                            
                            PDEvent *event = [[PDEvent alloc] initWithServerResponse:dict];
                            [events addObject: event];
                        }
                        if (success) {
                            success(events);
                        }
                        
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        
                        
                    }];
}

- (void) getRepoWebView:(NSString *) repoURL
              onSuccess:(void(^)(NSString *webViewURL)) success
              onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure {
    
    [self.sessionManager GET:repoURL 
                  parameters:nil
                    progress:nil
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         
                         NSString *htmlURL = [responseObject objectForKey:@"html_url"];
                         
                         if (success) {
                             success(htmlURL);
                         }
                         
                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         
                         NSLog(@"%@", [error localizedDescription]);
                     }];
}





























@end
