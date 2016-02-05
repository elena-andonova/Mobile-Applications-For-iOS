//
//  Category.m
//  CultureGuideApp
//
//  Created by Elena Andonova on 2/5/16.
//  Copyright © 2016 EA. All rights reserved.
//

#import "CultureCategory.h"

@implementation CultureCategory

-(instancetype)initWithName:(NSString *)name andImage:(NSString *)image{

    if (self = [super init]) {
        self.name = name;
        self.image = image;
    }
    return self;
}

-(instancetype)initWithName:(NSString *)name image:(NSString *)image andPlaces:(NSArray *)places{
    
    if (self = [super init]) {
        self.name = name;
        self.image = image;
        self.places = places;
    }
    return self;
}

+(instancetype)cultureCategoryWithName:(NSString *)name andImage:(NSString *)image{
    return [[CultureCategory alloc] initWithName:name andImage:image];
}

@end
