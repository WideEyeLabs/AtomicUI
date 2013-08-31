//
//  AtomPullOverController.m
//  AtomPullOver
//
//  Created by Brian Thomas on 8/30/13.
//  Copyright (c) 2013 WideEyeLabs. All rights reserved.
//

#import "AtomPullOverController.h"
#import "Masonry.h"

#define kSlideAnimationTime 0.18

@interface AtomPullOverController ()

@property (strong, nonatomic) UIViewController *pullOverController;
@property (strong, nonatomic) UIViewController *rootController;

@property (strong, nonatomic) UIView *pullOverBacking;
@property (strong, nonatomic) UIView *pullOverContentBacking;
@property (strong, nonatomic) UIView *pullOverContent;
@property (strong, nonatomic) UIView *pullOverGrip;
@property (strong, nonatomic) UIView *detailView;

@property (strong, nonatomic) NSNumber *pullOverContentWidth;

@property (nonatomic, strong) NSLayoutConstraint *pullOverOffset;

@property (nonatomic, strong) UIPanGestureRecognizer *gripPanRecognizer;
@property (nonatomic, strong) UIPanGestureRecognizer *pullOverPanRecognizer;

@property (nonatomic) BOOL isPullOverDisplayed;

@end

@implementation AtomPullOverController

- (id)initWithPullOverController:(UIViewController *)pullOver andRootController:(UIViewController *)rootController withContentWidth:(NSNumber *)width
{
    if (self = [super init])
    {
        _pullOverController = pullOver;
        _rootController = rootController;
        _pullOverContentWidth = width;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _pullOverContentWidth = [NSNumber numberWithInt:280];
    [self loadDetailView];
    [self loadPullOverBackingView];
    [self addPanGestureToContentView];
    [self addPanGestureToGripView];
    [self addPullOverControllerToView];
    [self addRootControllerToView];
}

- (void)addPanGestureToContentView
{
    _pullOverPanRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRecognized:)];
    [_pullOverContent addGestureRecognizer:_pullOverPanRecognizer];
}

- (void)addPanGestureToGripView
{
    _gripPanRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRecognized:)];
    [_pullOverGrip addGestureRecognizer:_gripPanRecognizer];
}

#pragma mark - Private Sliding Methods

//- (void)tapRecognized:(UITapGestureRecognizer *)tap
//{
//    if ([tap state] == UIGestureRecognizerStateEnded)
//    {
//        [self closeSlideBar];
//    }
//}

- (void)panRecognized:(UIPanGestureRecognizer *)pan
{
    CGPoint p = [pan translationInView:self.view];
    CGPoint v = [pan velocityInView:self.view];
    if ([pan state] == UIGestureRecognizerStateChanged)
    {
        [self shiftPullOverView:p.x];
    }
    else if ([pan state] == UIGestureRecognizerStateEnded)
    {
        if (v.x > 80)
        {
            [self movePullOverToPosition:0 withEaseIn:NO];
        }
        else if (v.x < -80)
        {
            [self movePullOverToPosition:-(_pullOverContentWidth.intValue) withEaseIn:NO];
        }
        else
        {
            [self adjustPullOverToNearestLockedPosition];
        }
    }
    
    [pan setTranslation:CGPointZero inView:self.view];
}

// fixed
- (void)shiftPullOverView:(CGFloat)amount
{
    if (abs(_pullOverOffset.constant) <= _pullOverContentWidth.intValue && _pullOverOffset.constant <= 0)
    {
        if ((_pullOverOffset.constant + amount) < -(_pullOverContentWidth.intValue))
        {
            _pullOverOffset.constant = -(_pullOverContentWidth.intValue);
        }
        else if ((_pullOverOffset.constant + amount) > 0)
        {
            _pullOverOffset.constant = 0;
        }
        else
        {
            _pullOverOffset.constant = _pullOverOffset.constant + amount;
        }
    }
}

- (void)movePullOverToPosition:(CGFloat)position withEaseIn:(BOOL)ease
{
    self.view.userInteractionEnabled = NO;
    CGFloat time = (abs(position-_pullOverOffset.constant))*(kSlideAnimationTime/_pullOverContentWidth.intValue) + 0.11;
    
    NSUInteger option = ease ? UIViewAnimationOptionCurveEaseInOut : UIViewAnimationOptionCurveEaseOut;
    
    [UIView animateWithDuration:time delay:0 options:option animations:^{
        _pullOverOffset.constant = position;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        if ((int)position == 0)
        {
            _isPullOverDisplayed = NO;
//            [self.view sendSubviewToBack:_closeOnTapView];
        }
        else
        {
            _isPullOverDisplayed = YES;
//            [self.view bringSubviewToFront:_closeOnTapView];
        }
        self.view.userInteractionEnabled = YES;
    }];
}

// fixed
- (void)adjustPullOverToNearestLockedPosition
{
    if (abs(_pullOverOffset.constant) > _pullOverContentWidth.intValue/2)
    {
        [self movePullOverToPosition:-(_pullOverContentWidth.intValue) withEaseIn:YES];
    }
    else
    {
        [self movePullOverToPosition:0 withEaseIn:YES];
    }
}

#pragma mark - Load Controllers

- (void)addPullOverControllerToView
{
    UIView *superview = _pullOverContent;
    [self addChildViewController:_pullOverController];
    [_pullOverContent addSubview:_pullOverController.view];
    
    [_pullOverController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superview.mas_left).with.offset(0);
        make.bottom.equalTo(superview.mas_bottom).with.offset(0);
        make.top.equalTo(superview.mas_top).with.offset(0);
        make.right.equalTo(superview.mas_right).with.offset(0);
    }];
    
    [_pullOverController didMoveToParentViewController:self];
}

- (void)addRootControllerToView
{
    UIView *superview = _detailView;
    [self addChildViewController:_rootController];
    [_detailView addSubview:_rootController.view];
    
    [_rootController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superview.mas_left).with.offset(0);
        make.bottom.equalTo(superview.mas_bottom).with.offset(0);
        make.top.equalTo(superview.mas_top).with.offset(0);
        make.right.equalTo(superview.mas_right).with.offset(0);
    }];
    
    [_rootController didMoveToParentViewController:self];
}


#pragma mark - Load Views

- (void)loadDetailView
{
    UIView *superview = self.view;
    _detailView = [[UIView alloc] init];
    [self.view addSubview:_detailView];
    _detailView.backgroundColor = [UIColor clearColor];
    
    [_detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superview).with.offset(0);
    }];
}

- (void)loadPullOverBackingView;
{
    UIView *superview = self.view;
    _pullOverBacking = [[UIView alloc] init];
    [self.view addSubview:_pullOverBacking];
    
    [_pullOverBacking mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superview.mas_left).with.offset(-(_pullOverContentWidth.intValue));
        make.top.equalTo(superview.mas_top).with.offset(0);
        make.bottom.equalTo(superview.mas_bottom).with.offset(0);
        if (_pullOverContentWidth.intValue > 50)
        {
            NSNumber *backingWidth = [NSNumber numberWithInt:_pullOverContentWidth.intValue+30];
            make.width.equalTo(backingWidth);
        }
        else
        {
            make.width.equalTo(@50);
        }
    }];
    
    NSArray *constraints = [self.view constraints];
    _pullOverOffset = constraints[4];
    
    _pullOverBacking.backgroundColor = [UIColor clearColor];
    [self loadContentView];
    [self loadPullOverGrip];
}

- (void)loadContentBackingView
{
    
}

- (void)loadContentView
{
    UIView *superview = _pullOverBacking;
    _pullOverContent = [[UIView alloc] init];
    [_pullOverBacking addSubview:_pullOverContent];
    _pullOverContent.backgroundColor = [UIColor clearColor];
    
    [_pullOverContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview.mas_top).with.offset(0);
        make.bottom.equalTo(superview.mas_bottom).with.offset(0);
        make.left.equalTo(superview.mas_left).with.offset(0);
        make.right.equalTo(superview.mas_right).with.offset(-30);
    }];
}

- (void)loadPullOverGrip
{
    UIView *superview = _pullOverBacking;
    _pullOverGrip = [[UIView alloc] init];
    [_pullOverBacking addSubview:_pullOverGrip];
    _pullOverGrip.backgroundColor = [UIColor clearColor];
    
    [_pullOverGrip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(superview.mas_bottom).with.offset(0);
        make.width.equalTo(@30);
        make.top.equalTo(superview.mas_top).with.offset(60);
        make.right.equalTo(superview.mas_right).with.offset(0);
    }];
}

@end
