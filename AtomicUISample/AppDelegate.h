//
//  AppDelegate.h
//  AtomicUISample
//
//  Created by Brian Thomas on 1/30/15.
//  Copyright (c) 2015 Brian Thomas. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AtomSlideController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) AtomSlideController *slideController;

@end

