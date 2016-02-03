//
//  Place.m
//  CultureGuideApp
//
//  Created by Elena Andonova on 2/2/16.
//  Copyright © 2016 EA. All rights reserved.
//

#import "Place.h"

@implementation Place

-(instancetype)initWithName:(NSString *)name{
    
    if(self = [super init])
    {
        self.name = name;
    }
    
    return self;
}

@end
