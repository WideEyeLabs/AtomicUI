//
//  AtomAppDelegate.h
//  AtomSlide
//
//  Created by Brian Thomas on 8/13/13.
//  Copyright (c) 2013 WideEyeLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AtomViewController;
@class AtomSlideController;

@interface AtomAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) AtomViewController *viewController;
@property (strong, nonatomic) AtomSlideController *slide;

@end
