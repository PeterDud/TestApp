//
//  PDRepoWebViewController.m
//  TestTask
//
//  Created by Lavrin on 6/25/17.
//  Copyright © 2017 Lavrin. All rights reserved.
//

#import "PDRepoWebViewController.h"

@interface PDRepoWebViewController () <UIWebViewDelegate>

@property (weak, nonatomic) UIActivityIndicatorView *indicator;

@end

@implementation PDRepoWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Repository";
    
    CGRect r = self.view.bounds;
    r.origin = CGPointZero;
    
    UIWebView* webView = [[UIWebView alloc] initWithFrame:r];
    webView.delegate = self;
    webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:webView];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.alpha = 1.0;
    activityIndicator.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2,
                                           CGRectGetHeight(self.view.bounds)/2);
    activityIndicator.hidesWhenStopped = YES;
    [self.view addSubview:activityIndicator];
    self.indicator = activityIndicator;
    
    NSURL* url = [NSURL URLWithString:self.webViewURL];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    [self.indicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [self.indicator stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    
    [self.indicator stopAnimating];
}




@end
