//
//  PlacesLocationViewController.m
//  CultureGuideApp
//
//  Created by Elena Andonova on 2/7/16.
//  Copyright © 2016 EA. All rights reserved.
//

#import "PlacesLocationViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <EverliveSDK/EverliveSDK.h>
#import "Place.h"
#import "PlaceOnMap.h"

@interface PlacesLocationViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

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
    
    [self loadPlacesOnMap];
    
   }

-(void)loadPlacesOnMap{
    EVDataStore *dataStore = [EVDataStore sharedInstance];
    EVFetchRequest *request = [EVFetchRequest fetchRequestWithKindOfClass:[Place class]];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"CultureCategoryId == %@",self.categoryId]];
    
    [dataStore executeFetchRequest:request block:^(NSArray *result, NSError *error) {
        
        NSMutableArray *places = [NSMutableArray array];
        
        for (int index = 0; index < [result count]; index++)
        {
            Place *place = [result objectAtIndex:index];
            
            CLLocationDegrees latitude = [[place.geoLocation objectForKey:@"latitude"] doubleValue];
            CLLocationDegrees longitude = [[place.geoLocation objectForKey:@"longitude"] doubleValue];
            CLLocationCoordinate2D placeCoordinates = CLLocationCoordinate2DMake(latitude,longitude);
            PlaceOnMap *placeOnMap = [[PlaceOnMap alloc] init];
            placeOnMap.title = place.name;
            placeOnMap.subtitle = place.location;
            placeOnMap.coordinate = placeCoordinates;
            [self.locationsMapView addAnnotation:placeOnMap];
        }
    }];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    location = [locations lastObject];
    NSLog(@"%@", location);
    
    //+42.69558360,+23.31977180
    CLLocationCoordinate2D coordinate = [location coordinate];
    MKCoordinateSpan span = MKCoordinateSpanMake(0.05,0.05);
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    
    self.locationsMapView.showsUserLocation = YES;
    [self.locationsMapView setRegion:region animated:YES];
    
    CLGeocoder *coder = [[CLGeocoder alloc] init];
    [coder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *mark = [placemarks lastObject];
        NSLog(@"%@", [mark.addressDictionary objectForKey:@"Name"]);
        self.userLocationLabel.text = [NSString stringWithFormat:@"..around your location: %@",
                                       [mark.addressDictionary objectForKey:@"Name"]];
    }];
    
    [locationManager stopMonitoringSignificantLocationChanges];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    MKPinAnnotationView *pinView = nil;
    if(annotation != mapView.userLocation)
    {
        static NSString *defaultPinID = @"defaultPin";
        pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        
        if (pinView == nil)
        {
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID];

        }
        
        pinView.pinTintColor = [MKPinAnnotationView greenPinColor];
        //pinView.pinColor = MKPinAnnotationColorPurple;
        pinView.canShowCallout = YES;
        pinView.animatesDrop = YES;
    }
    else {
        [mapView.userLocation setTitle:@"You are here!"];
    }
    return pinView;
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
