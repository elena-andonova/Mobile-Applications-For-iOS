//
//  PlacesTableViewController.h
//  CultureGuideApp
//
//  Created by Elena Andonova on 2/6/16.
//  Copyright © 2016 EA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlacesTableViewController : UITableViewController

@property (strong, nonatomic) NSString *cultureCategoryId;

@property (strong, nonatomic) NSArray *places;

@end
