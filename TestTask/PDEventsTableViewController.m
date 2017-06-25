//
//  PDTableViewController.m
//  TestTask
//
//  Created by Lavrin on 6/25/17.
//  Copyright © 2017 Lavrin. All rights reserved.
//

#import "PDEventsTableViewController.h"
#import "PDRepoWebViewController.h"
#import "PDServerManager.h"
#import "UIImageView+AFNetworking.h"
#import "PDEventCell.h"
#import "PDEvent.h"

@interface PDEventsTableViewController ()

@property (strong, nonatomic) NSMutableArray *events;

@end

@implementation PDEventsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Events";
    
    self.events = [NSMutableArray array];
    
    [self getEventsFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API

-(void) getEventsFromServer {
    
    NSInteger pageNumber = [self.events count] / 30 + 1;
    
    [[PDServerManager sharedManager] getEventsFromPage: pageNumber
     OnSuccess:^(NSArray *events) {
        
        [self.events addObjectsFromArray: events];
        
        NSMutableArray *indexPaths = [NSMutableArray array];
        
        for (int i = (int)[self.events count] - (int)[events count];
             i < [self.events count]; i++) {
            [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
        
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:indexPaths
                              withRowAnimation:UITableViewRowAnimationRight];
        [self.tableView endUpdates];

    } onFailure:^(NSError *error, NSInteger statusCode) {
        
        NSLog(@"%@", [error localizedDescription]);
    }];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.events count] + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == [self.events count]) {
        
        NSString *identifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        cell.textLabel.text = @"More";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        return cell;
        
    } else {
    
        NSString *identifier = @"EventCell";
        
        PDEventCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        PDEvent *event = [self.events objectAtIndex:indexPath.row];
        
        cell.loginLabel.text = event.login;
        cell.typeLabel.text = event.typeOfEvent;
        cell.dateLabel.text = event.creationDate;
        
        NSURLRequest *imageRequest = [NSURLRequest requestWithURL:event.avatarURL];
        
        cell.avatarView.image = nil;
        
        __weak PDEventCell *weakCell = cell;
        
        [cell.avatarView
         setImageWithURLRequest:imageRequest
         placeholderImage:nil
         success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                               
             weakCell.avatarView.image = image;
             [weakCell layoutSubviews];
                                               
         }
        failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
               
               NSLog(@"%@", [error localizedDescription]);
        }];
        return cell;
    }
    return nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    if (indexPath.row == [self.events count]) {
        
        [self getEventsFromServer];
        
    } else {
    
        PDEvent *event = [self.events objectAtIndex:indexPath.row];
        
        [[PDServerManager sharedManager]
         getRepoWebView:event.repoURL
         onSuccess:^(NSString *webViewURL) {
        
             PDRepoWebViewController *repoWebVieController = [[PDRepoWebViewController alloc] init];
             repoWebVieController.webViewURL = webViewURL;
             
             [self.navigationController pushViewController:repoWebVieController animated:YES];
         
         } onFailure:^(NSError *error, NSInteger statusCode) {

         }];
    }
}
























@end
