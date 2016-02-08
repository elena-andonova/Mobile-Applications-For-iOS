//
//  EventTicketViewController.m
//  CultureGuideApp
//
//  Created by Elena Andonova on 2/7/16.
//  Copyright © 2016 EA. All rights reserved.
//

#import "EventTicketViewController.h"

@interface EventTicketViewController ()

@end

@implementation EventTicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    NSString *date = [self.event formatedDate];
    NSLog(@"%@",[NSString stringWithFormat:@"%@,\n%@", date, self.event.hall]);
    self.eventDetailsLabel.text = [NSString stringWithFormat:@"%@,\n%@", date, self.event.hall];
    
    NSURL *urlToLoad = [NSURL URLWithString:self.event.eventTicketsUrl];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:urlToLoad];
    [self.ticketsWebView loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
