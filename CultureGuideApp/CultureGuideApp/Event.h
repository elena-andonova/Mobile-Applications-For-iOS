//
//  Event.h
//  CultureGuideApp
//
//  Created by Elena Andonova on 2/2/16.
//  Copyright © 2016 EA. All rights reserved.
//

#import <EverliveSDK/EverliveSDK.h>

@interface Event : EVObject

@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSString *eventDescription;

@property (strong,nonatomic) NSDate *date;

@property (strong, nonatomic) NSString *hall;

-(instancetype)initWithName: (NSString*) name
                       date: (NSDate*) date
                       hall: (NSString*) hall
        andEventDescription: (NSString*) descr;

+(instancetype)eventWithName: (NSString*) name
                        date: (NSDate*) date
                        hall: (NSString*) hall
         andEventDescription: (NSString*) descr;

@end
