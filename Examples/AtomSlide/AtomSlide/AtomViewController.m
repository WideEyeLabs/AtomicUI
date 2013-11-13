//
//  AtomViewController.m
//  AtomSlide
//
//  Created by Brian Thomas on 8/13/13.
//  Copyright (c) 2013 WideEyeLabs. All rights reserved.
//

#import "AtomViewController.h"
#import "AtomAppDelegate.h"
#import <AtomSlideController.h>

@interface AtomViewController ()

@end

@implementation AtomViewController

- (IBAction)startButtonTapped:(id)sender
{
    AtomAppDelegate *appDel = [[UIApplication sharedApplication] delegate];
    [appDel.slide startIndicator];
}

- (IBAction)stopButtonTapped:(id)sender
{
    AtomAppDelegate *appDel = [[UIApplication sharedApplication] delegate];
    [appDel.slide stopIndicator];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
