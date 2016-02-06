//
//  PlaceDetailsViewController.m
//  CultureGuideApp
//
//  Created by Elena Andonova on 2/6/16.
//  Copyright © 2016 EA. All rights reserved.
//

#import "EventDetailsViewController.h"


@interface EventDetailsViewController()

@end

@implementation EventDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.title = self.event.name;
    [self.parentViewController.navigationItem setTitle:self.event.name];
    
    NSURL *imgUrlString = [NSURL URLWithString:self.event.eventImage];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:imgUrlString]];
    
    self.eventImageView.image = img;
    self.eventDescriptionTextView.text = self.event.eventDescription;
    self.eventOverviewTextView.text = self.event.eventOverview;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
//{
//    self.eventTicketView = (EventTicketViewController*)[tabBarController.viewControllers objectAtIndex:1];
//    self.eventTicketView.testText = @"Testing";
//    //self.eventTicketView.url = self.event.eventTicketsUrl;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
