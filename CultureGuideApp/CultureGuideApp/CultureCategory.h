//
//  Category.h
//  CultureGuideApp
//
//  Created by Elena Andonova on 2/5/16.
//  Copyright © 2016 EA. All rights reserved.
//

#import <EverliveSDK/EverliveSDK.h>

@interface CultureCategory : EVObject

@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSString *image;

-(instancetype)initWithName: (NSString*) name
                   andImage:(NSString*) image;

-(instancetype)initWithName: (NSString*) name
                      image:(NSString*) image
                  andPlaces: (NSArray*) places;


+(instancetype)cultureCategoryWithName:(NSString*) name
                              andImage:(NSString*) image;


@end
