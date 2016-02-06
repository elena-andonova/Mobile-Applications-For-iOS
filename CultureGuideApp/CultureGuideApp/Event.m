//
//  Event.m
//  CultureGuideApp
//
//  Created by Elena Andonova on 2/2/16.
//  Copyright © 2016 EA. All rights reserved.
//

#import "Event.h"

@implementation Event

-(instancetype)initWithName:(NSString *)name
                       date:(NSDate *)date
                       hall: (NSString*) hall
        andEventDescription:(NSString *)descr{
    
    if (self = [super init]) {
        self.name = name;
        self.date = date;
        self.hall = hall;
        self.eventDescription = descr;
    }
    return self;
}

+(instancetype)eventWithName:(NSString *)name date:(NSDate *)date hall:(NSString *)hall andEventDescription:(NSString *)descr{
    
    return [[Event alloc] initWithName:name date:date hall:hall andEventDescription:descr];
}

@end
