//
//  AtomSlideController.h
//  
//
//  Created by Brian Thomas on 8/13/13.
//
//

#import <UIKit/UIKit.h>

@interface AtomSlideController : UIViewController

- (void)configureWithMaster:(UIViewController *)master detail:(UIViewController *)detail masterContentWidth:(NSNumber *)contentWidth slideOpenWidth:(NSNumber *)slideOpenWidth;

- (void)allowsSliding:(BOOL)shouldSlide;
- (void)openSlideBar;
- (void)closeSlideBar;

@end
