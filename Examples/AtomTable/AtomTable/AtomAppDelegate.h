//
//  AtomAppDelegate.h
//  AtomTable
//
//  Created by Brian Thomas on 8/14/13.
//  Copyright (c) 2013 WideEyeLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AtomViewController;
@class AtomTableDataSource;

@interface AtomAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) AtomViewController *viewController;
@property (strong, nonatomic) AtomTableDataSource *dataSource;

@end
