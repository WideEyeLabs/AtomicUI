//
//  AtomViewController.h
//  AtomSlide
//
//  Created by Brian Thomas on 8/13/13.
//  Copyright (c) 2013 WideEyeLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AtomViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;

- (IBAction)startButtonTapped:(id)sender;
- (IBAction)stopButtonTapped:(id)sender;

@end
