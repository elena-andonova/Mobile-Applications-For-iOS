//
//  EventTicketViewController.h
//  CultureGuideApp
//
//  Created by Elena Andonova on 2/7/16.
//  Copyright © 2016 EA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventTicketViewController : UIViewController

@property (strong, nonatomic) NSString* url;

@property (weak, nonatomic) IBOutlet UIWebView *ticketsWebView;

@property (strong, nonatomic) NSString* testText;

@end
