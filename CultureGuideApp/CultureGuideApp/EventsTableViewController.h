//
//  EventsTableViewController.h
//  CultureGuideApp
//
//  Created by Elena Andonova on 2/6/16.
//  Copyright © 2016 EA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventsTableViewController : UITableViewController

@property (strong, nonatomic) NSString *placeId;

@property (strong, nonatomic) NSString *placeName;

@property (strong, nonatomic) NSArray *events;

@end
