//
//  PlacesLocationViewController.m
//  CultureGuideApp
//
//  Created by Elena Andonova on 2/7/16.
//  Copyright © 2016 EA. All rights reserved.
//

#import "PlacesLocationViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface PlacesLocationViewController () <CLLocationManagerDelegate>

@end

@implementation PlacesLocationViewController{
    CLLocationManager* locationManager;
    CLLocation *location;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    locationManager.distanceFilter = kCLLocationAccuracyHundredMeters;
    
    [locationManager requestAlwaysAuthorization];
    [locationManager startUpdatingLocation];
    
   }

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    location = [locations lastObject];
    NSLog(@"%@", location);
    
    //+42.69558360,+23.31977180
    CLLocationCoordinate2D coordinate = [location coordinate];
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1,0.1);
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    
    self.locationsMapView.showsUserLocation = YES;
    [self.locationsMapView setRegion:region animated:YES];
    
    CLGeocoder *coder = [[CLGeocoder alloc] init];
    [coder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *mark = [placemarks lastObject];
        NSLog(@"%@", [mark.addressDictionary objectForKey:@"Name"]);
        self.userLocationLabel.text = [NSString stringWithFormat:@"..around %@",
                                       [mark.addressDictionary objectForKey:@"Name"]];
    }];
    
    CLLocationDegrees latitude = [@"42.696629" doubleValue];
    CLLocationDegrees longitude = [@"23.347440000000006" doubleValue];
    CLLocationCoordinate2D testCoordinate = CLLocationCoordinate2DMake(latitude,longitude);
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = testCoordinate;
    
    [locationManager stopMonitoringSignificantLocationChanges];
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
