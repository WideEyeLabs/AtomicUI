//
//  AtomPullOverController.h
//  AtomPullOver
//
//  Created by Brian Thomas on 8/30/13.
//  Copyright (c) 2013 WideEyeLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AtomPullOverController : UIViewController

- (id)initWithPullOverController:(UIViewController *)pullOver andRootController:(UIViewController *)rootController withContentWidth:(NSNumber *)width;

@end
