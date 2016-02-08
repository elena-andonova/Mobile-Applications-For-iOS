//
//  LocalDatabase.h
//  CultureGuideApp
//
//  Created by Elena Andonova on 2/8/16.
//  Copyright © 2016 EA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Place.h"

@interface LocalDatabase : NSObject

+(instancetype) database;

-(NSArray*) favoritePlaces;

-(void)addFavoritePlace: (Place*) place;

@end
