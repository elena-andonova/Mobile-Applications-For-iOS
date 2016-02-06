//
//  AppDelegate.h
//  CultureGuideApp
//
//  Created by Elena Andonova on 2/2/16.
//  Copyright © 2016 EA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackendData.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) BackendData *data;


@end

