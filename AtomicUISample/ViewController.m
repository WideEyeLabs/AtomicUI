//
//  ViewController.m
//  AtomicUISample
//
//  Created by Brian Thomas on 1/30/15.
//  Copyright (c) 2015 Brian Thomas. All rights reserved.
//

#import "ViewController.h"
#import "AtomSlideController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)openSlide:(id)sender {
    AppDelegate *appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDel.slideController openSlideBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *openButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    [openButton addTarget:self action:@selector(openSlide:) forControlEvents:UIControlEventTouchUpInside];
    openButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:openButton];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:openButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:openButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    [self.view layoutIfNeeded];
    openButton.titleLabel.text = @"HIIIII";
    openButton.backgroundColor = [UIColor greenColor];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
