//
//  PlacesLocationViewController.h
//  CultureGuideApp
//
//  Created by Elena Andonova on 2/7/16.
//  Copyright © 2016 EA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface PlacesLocationViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *locationsMapView;

@property (weak, nonatomic) IBOutlet UILabel *userLocationLabel;

@end
