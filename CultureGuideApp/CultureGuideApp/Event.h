//
//  Event.h
//  CultureGuideApp
//
//  Created by Elena Andonova on 2/2/16.
//  Copyright © 2016 EA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSString *eventDescription;

@property (strong,nonatomic) NSDate *date;

-(instancetype)initWithName: (NSString*) name
                       date: (NSDate*) date
        andEventDescription: (NSString*) descr;

+(instancetype)eventWithName: (NSString*) name
                        date: (NSDate*) date
         andEventDescription: (NSString*) descr;

@end
