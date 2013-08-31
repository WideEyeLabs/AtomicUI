//
//  AtomAppDelegate.h
//  AtomPullOver
//
//  Created by Brian Thomas on 8/30/13.
//  Copyright (c) 2013 WideEyeLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AtomViewController;

@interface AtomAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) AtomViewController *viewController;

@end
