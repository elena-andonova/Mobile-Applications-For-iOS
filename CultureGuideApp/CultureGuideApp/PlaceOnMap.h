//
//  PlaceOnMap.h
//  CultureGuideApp
//
//  Created by Elena Andonova on 2/7/16.
//  Copyright © 2016 EA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface PlaceOnMap : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end
