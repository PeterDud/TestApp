//
//  PDEvent.m
//  TestTask
//
//  Created by Lavrin on 6/25/17.
//  Copyright © 2017 Lavrin. All rights reserved.
//

#import "PDEvent.h"

@implementation PDEvent

- (instancetype)initWithServerResponse:(NSDictionary *)response {
    self = [super init];
    if (self) {
        
        NSDictionary *actor = [response objectForKey:@"actor"];
        NSDictionary *repo = [response objectForKey:@"repo"];
        
        self.login = [actor objectForKey:@"login"];
        self.avatarURL = [NSURL URLWithString:[actor objectForKey:@"avatar_url"]];
        self.creationDate = [response objectForKey:@"created_at"];
        self.typeOfEvent = [response objectForKey:@"type"];
        self.repoURL = [repo objectForKey:@"url"];
    }
    return self;
}










@end
