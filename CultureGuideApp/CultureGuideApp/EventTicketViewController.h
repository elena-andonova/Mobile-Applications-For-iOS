//
//  EventTicketViewController.h
//  CultureGuideApp
//
//  Created by Elena Andonova on 2/7/16.
//  Copyright © 2016 EA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventTicketViewController : UIViewController

@property (strong, nonatomic) Event *event;

@property (weak, nonatomic) IBOutlet UILabel *eventDetailsLabel;

@property (weak, nonatomic) IBOutlet UIWebView *ticketsWebView;

@end
