//
//  AtomSlideController.m
//  
//
//  Created by Brian Thomas on 8/13/13.
//
//

#import "AtomSlideController.h"
#import <QuartzCore/QuartzCore.h>

#define kSlideAnimationTime 0.18

@interface AtomSlideController ()

@property (nonatomic, strong) UIViewController *masterController;
@property (nonatomic, strong) UIViewController *detailController;
@property (nonatomic, strong) NSNumber *masterContentWidth;
@property (nonatomic, strong) NSNumber *slideOpenWidth;

@property (nonatomic, strong) UIView *sectionsView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *closeOnTapView;
@property (nonatomic, strong) NSLayoutConstraint *contentViewOffset;

@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;

@property (nonatomic) BOOL isSectionsTableDisplayed;

@end

@implementation AtomSlideController

#pragma mark - Initializers

- (void)configureWithMaster:(UIViewController *)master detail:(UIViewController *)detail masterContentWidth:(NSNumber *)contentWidth slideOpenWidth:(NSNumber *)slideOpenWidth {
    _masterController = master;
    _detailController = detail;
    _masterContentWidth = contentWidth;
    _slideOpenWidth = slideOpenWidth;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadSectionsView];
    [self loadContentView];
    [self addContentAreaControllerToHierarchy];
    [self addSectionsControllerToHierarchy];
    [self addPanGestureToContentView];
}


#pragma mark - Public Methods

- (void)allowsSliding:(BOOL)shouldSlide
{
    [self closeSlideBar];
    [_panRecognizer setEnabled:shouldSlide];
}

- (void)openSlideBar
{
    [self moveSlideViewToPosition:_slideOpenWidth.intValue withEaseIn:YES];
}

- (void)closeSlideBar
{
    [self moveSlideViewToPosition:0 withEaseIn:YES];
}


#pragma mark - Private Sliding Methods

- (void)tapRecognized:(UITapGestureRecognizer *)tap
{
    if ([tap state] == UIGestureRecognizerStateEnded)
    {
        [self closeSlideBar];
    }
}

- (void)panRecognized:(UIPanGestureRecognizer *)pan
{
    CGPoint p = [pan translationInView:self.view];
    CGPoint v = [pan velocityInView:_contentView];
    if ([pan state] == UIGestureRecognizerStateChanged)
    {
        if (p.x > 0)
        {
            [self shiftContentView:p.x];
        }
        else
        {
            [self shiftContentView:p.x];
        }
    }
    else if ([pan state] == UIGestureRecognizerStateEnded)
    {
        if (v.x > 80)
        {
            [self moveSlideViewToPosition:_slideOpenWidth.intValue withEaseIn:NO];
        }
        else if (v.x < -80)
        {
            [self moveSlideViewToPosition:0 withEaseIn:NO];
        }
        else
        {
            [self adjustSlideToNearestLockedPosition];
        }
    }
    
    [pan setTranslation:CGPointZero inView:self.view];
}

- (void)shiftContentView:(CGFloat)amount
{
    if (_contentViewOffset.constant <= _slideOpenWidth.intValue && _contentViewOffset.constant >= 0)
    {
        if ((_contentViewOffset.constant + amount) > _slideOpenWidth.intValue)
        {
            _contentViewOffset.constant = _slideOpenWidth.intValue;
        }
        else if ((_contentViewOffset.constant + amount) < 0)
        {
            _contentViewOffset.constant = 0;
        }
        else
        {
            _contentViewOffset.constant = _contentViewOffset.constant + amount;
        }
    }
}

- (void)moveSlideViewToPosition:(CGFloat)position withEaseIn:(BOOL)ease
{
    self.view.userInteractionEnabled = NO;
    CGFloat time = (abs(position-_contentViewOffset.constant))*(kSlideAnimationTime/_slideOpenWidth.intValue) + 0.11;
    
    NSUInteger option = ease ? UIViewAnimationOptionCurveEaseInOut : UIViewAnimationOptionCurveEaseOut;
    
    [UIView animateWithDuration:time delay:0 options:option animations:^{
        _contentViewOffset.constant = position;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        if ((int)position == 0)
        {
            _isSectionsTableDisplayed = NO;
            [_contentView sendSubviewToBack:_closeOnTapView];
        }
        else
        {
            _isSectionsTableDisplayed = YES;
            [_contentView bringSubviewToFront:_closeOnTapView];
        }
        self.view.userInteractionEnabled = YES;
    }];
}

- (void)adjustSlideToNearestLockedPosition
{
    if (_contentViewOffset.constant > _slideOpenWidth.intValue/2)
    {
        [self openSlideBar];
    }
    else
    {
        [self closeSlideBar];
    }
}


#pragma mark - Set Up Controllers

- (void)addContentAreaControllerToHierarchy
{
    [self addChildViewController:_detailController];
    [_contentView addSubview:_detailController.view];
    _detailController.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[detail]-0-|" options:0 metrics:nil views:@{@"detail": self.detailController.view}]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[detail]-0-|" options:0 metrics:nil views:@{@"detail": self.detailController.view}]];
    
    [_detailController didMoveToParentViewController:self];
}

- (void)addPanGestureToContentView
{
    _panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRecognized:)];
    [_detailController.view addGestureRecognizer:_panRecognizer];
}

- (void)addSectionsControllerToHierarchy
{
    [self addChildViewController:_masterController];
    [_sectionsView addSubview:_masterController.view];
    _masterController.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.sectionsView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[master]-0-|" options:0 metrics:nil views:@{@"master": self.masterController.view}]];
    [self.sectionsView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[master]-0-|" options:0 metrics:nil views:@{@"master": self.masterController.view}]];
    
    [_masterController didMoveToParentViewController:self];
}


#pragma mark - Set Up Container and Layout Constraints

- (void)loadSectionsView
{
    _sectionsView = [[UIView alloc] init];
    _sectionsView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_sectionsView];
    [_sectionsView setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[section]" options:0 metrics:nil views:@{@"section": self.sectionsView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[section]-0-|" options:0 metrics:nil views:@{@"section": self.sectionsView}]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.sectionsView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:self.masterContentWidth.floatValue]];
}

- (void)loadContentView
{
    _contentView = [[UIView alloc] init];
    _contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_contentView];
    [_contentView setBackgroundColor:[UIColor darkGrayColor]];
    _contentView.layer.masksToBounds = NO;
    
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[content]" options:0 metrics:nil views:@{@"content": self.contentView}];
    [self.view addConstraints:constraints];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[content]-0-|" options:0 metrics:nil views:@{@"content": self.contentView}]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
    
    _contentViewOffset = constraints[0];
    [self.view layoutIfNeeded];
    
    [self loadContentCloseOnTapView];
}

- (void)loadContentCloseOnTapView
{
    _closeOnTapView = [[UIView alloc] init];
    _closeOnTapView.translatesAutoresizingMaskIntoConstraints = NO;
    [_contentView addSubview:_closeOnTapView];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[close]-0-|" options:0 metrics:nil views:@{@"close": self.closeOnTapView}]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[close]-0-|" options:0 metrics:nil views:@{@"close": self.closeOnTapView}]];
    
    UITapGestureRecognizer *tapToClose = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognized:)];
    [tapToClose setNumberOfTapsRequired:1];
    [tapToClose setEnabled:YES];
    [_closeOnTapView addGestureRecognizer:tapToClose];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRecognized:)];
    [_closeOnTapView addGestureRecognizer:pan];
}

@end
