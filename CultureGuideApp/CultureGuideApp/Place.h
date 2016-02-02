//
//  Place.h
//  CultureGuideApp
//
//  Created by Elena Andonova on 2/2/16.
//  Copyright © 2016 EA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Place : NSObject

@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSString *placeDescription;

@property (strong, nonatomic) NSString *location;

@property (strong, nonatomic) NSArray *events;

@end
