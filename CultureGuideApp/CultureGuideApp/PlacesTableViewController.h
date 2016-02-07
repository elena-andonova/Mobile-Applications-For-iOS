//
//  PlacesTableViewController.h
//  CultureGuideApp
//
//  Created by Elena Andonova on 2/6/16.
//  Copyright © 2016 EA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlacesLocationViewController.h"

@interface PlacesTableViewController : UITableViewController //<UITabBarControllerDelegate>

@property (strong, nonatomic) NSString *cultureCategoryId;

@property (strong, nonatomic) NSString *cultureCategoryName;

@property (strong, nonatomic) NSArray *places;

//@property (strong, nonatomic) PlacesLocationViewController *placeViewController;

@end
