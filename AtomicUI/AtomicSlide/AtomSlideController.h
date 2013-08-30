//
//  AtomSlideController.h
//  
//
//  Created by Brian Thomas on 8/13/13.
//
//

#import <UIKit/UIKit.h>

@interface AtomSlideController : UIViewController

- (id)initWithMaster:(UIViewController *)master andDetail:(UIViewController *)detail;
- (id)initWithMaster:(UIViewController *)master andDetail:(UIViewController *)detail withIndicatorBackgroundColor:(UIColor *)backgroundColor;
- (id)initWithMaster:(UIViewController *)master andDetail:(UIViewController *)detail withMasterWidth:(NSNumber *)masterWidth slideDistance:(NSNumber *)slideDistance withIndicatorBackgroundColor:(UIColor *)backgroundColor;

- (void)allowsSliding:(BOOL)shouldSlide;

- (void)startIndicator;
- (void)stopIndicator;

- (void)openSlideBar;
- (void)closeSlideBar;

@end
