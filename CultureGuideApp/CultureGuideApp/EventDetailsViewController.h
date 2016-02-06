//
//  PlaceDetailsViewController.h
//  CultureGuideApp
//
//  Created by Elena Andonova on 2/6/16.
//  Copyright © 2016 EA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventDetailsViewController : UIViewController <UITabBarControllerDelegate>

@property (strong,nonatomic) Event* event;

@property (weak, nonatomic) IBOutlet UIImageView *eventImageView;

@property (weak, nonatomic) IBOutlet UITextView *eventDescriptionTextView;

@property (weak, nonatomic) IBOutlet UITextView *eventOverviewTextView;

@end
