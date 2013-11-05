//
//  AtomSlideController.m
//  
//
//  Created by Brian Thomas on 8/13/13.
//
//

#import "AtomSlideController.h"
#import <QuartzCore/QuartzCore.h>
#import "Masonry.h"

#define kSlideAnimationTime 0.18

@interface AtomSlideController ()

@property (nonatomic, strong) UIViewController *masterController;
@property (nonatomic, strong) UIViewController *detailController;
@property (nonatomic, strong) UIColor *indicatorBackgroundColor;
@property (nonatomic, strong) NSNumber *masterContentWidth;
@property (nonatomic, strong) NSNumber *slideOpenWidth;

@property (nonatomic, strong) UIView *sectionsView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *closeOnTapView;
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;
@property (nonatomic, strong) NSLayoutConstraint *contentViewOffset;

@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;

@property (nonatomic) BOOL isSectionsTableDisplayed;
@property (nonatomic) BOOL shouldInidicatorRemainActive;

@end

@implementation AtomSlideController


#pragma mark - Initializers

- (id)initWithMaster:(UIViewController *)master andDetail:(UIViewController *)detail
{
    return [self initWithMaster:master andDetail:detail withMasterWidth:@270 slideDistance:@260 withIndicatorBackgroundColor:[UIColor blackColor]];
}

- (id)initWithMaster:(UIViewController *)master andDetail:(UIViewController *)detail withIndicatorBackgroundColor:(UIColor *)backgroundColor
{
    return [self initWithMaster:master andDetail:detail withMasterWidth:@280 slideDistance:@260 withIndicatorBackgroundColor:backgroundColor];
}

- (id)initWithMaster:(UIViewController *)master andDetail:(UIViewController *)detail withMasterWidth:(NSNumber *)masterWidth slideDistance:(NSNumber *)slideDistance withIndicatorBackgroundColor:(UIColor *)backgroundColor
{
    if (self = [super init])
    {
        _masterController = master;
        _detailController = detail;
        _indicatorBackgroundColor = backgroundColor;
        _masterContentWidth = masterWidth;
        _slideOpenWidth = slideDistance;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadSectionsView];
    [self loadContentView];
    [self loadIndicatorView];
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

- (void)startIndicator
{
    [self.view bringSubviewToFront:_indicatorView];
    _indicatorView.hidden = NO;
    if (!_shouldInidicatorRemainActive)
    {
        [self runIndicator];
    }
}

- (void)stopIndicator
{
    _shouldInidicatorRemainActive = NO;
}

- (void)openSlideBar
{
    [self moveSlideViewToPosition:_slideOpenWidth.intValue withEaseIn:YES];
}

- (void)closeSlideBar
{
    [self moveSlideViewToPosition:0 withEaseIn:YES];
}




#pragma mark - Indicator Methods

- (void)runIndicator
{
    _shouldInidicatorRemainActive = YES;
    [_indicator startAnimating];
    [self fadeIndicatorIn];
}

- (void)fadeIndicatorIn
{
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _indicatorView.alpha = 0.9;
    } completion:^(BOOL finished) {
        if (_shouldInidicatorRemainActive)
        {
            [self fadeIndicatorOut];
        }
        else
        {
            [self animateIndicatorRemoval];
        }
    }];
}

- (void)fadeIndicatorOut
{
    [UIView animateWithDuration:0.3 delay:0.4 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _indicatorView.alpha = 0.5;
    } completion:^(BOOL finished) {
        if (_shouldInidicatorRemainActive)
        {
            [self fadeIndicatorIn];
        }
        else
        {
            [self animateIndicatorRemoval];
        }
    }];
}

- (void)animateIndicatorRemoval
{
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        _indicatorView.alpha = 0;
    } completion:^(BOOL finished) {
        [self hideIndicator];
    }];
}

- (void)hideIndicator
{
    [self.view sendSubviewToBack:_indicatorView];
    _indicatorView.hidden = YES;
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
    UIView *superview = _contentView;
    [self addChildViewController:_detailController];
    [_contentView addSubview:_detailController.view];
    
    [_detailController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superview.mas_left).with.offset(0);
        make.bottom.equalTo(superview.mas_bottom).with.offset(0);
        make.top.equalTo(superview.mas_top).with.offset(0);
        make.right.equalTo(superview.mas_right).with.offset(0);
    }];
    
    [_detailController didMoveToParentViewController:self];
}

- (void)addPanGestureToContentView
{
    _panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRecognized:)];
    [_detailController.view addGestureRecognizer:_panRecognizer];
}

- (void)addSectionsControllerToHierarchy
{
    UIView *superview = _sectionsView;
    [self addChildViewController:_masterController];
    [_sectionsView addSubview:_masterController.view];
    
    [_masterController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superview.mas_left).with.offset(0);
        make.bottom.equalTo(superview.mas_bottom).with.offset(0);
        make.top.equalTo(superview.mas_top).with.offset(0);
        make.right.equalTo(superview.mas_right).with.offset(0);
    }];
    
    [_masterController didMoveToParentViewController:self];
}




#pragma mark - Set Up Container and Layout Constraints

- (void)loadSectionsView
{
    UIView *superview = self.view;
    _sectionsView = [[UIView alloc] init];
    [self.view addSubview:_sectionsView];
    [_sectionsView setBackgroundColor:[UIColor whiteColor]];
    
    [_sectionsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superview.mas_left).with.offset(0);
        make.bottom.equalTo(superview.mas_bottom).with.offset(0);
        make.top.equalTo(superview.mas_top).with.offset(0);
        make.width.equalTo(_masterContentWidth);
    }];
}

- (void)loadContentView
{
    UIView *superview = self.view;
    _contentView = [[UIView alloc] init];
    [self.view addSubview:_contentView];
    [_contentView setBackgroundColor:[UIColor darkGrayColor]];
    _contentView.layer.masksToBounds = NO;
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superview.mas_left).with.offset(0);
        make.bottom.equalTo(superview.mas_bottom).with.offset(0);
        make.top.equalTo(superview.mas_top).with.offset(0);
        make.width.equalTo(superview.mas_width);
    }];
    
    NSArray *constraints = [self.view constraints];
    _contentViewOffset = constraints[3];
    [self.view layoutIfNeeded];
    
    [self loadContentCloseOnTapView];
}

- (void)loadContentCloseOnTapView
{
    UIView *superview = _contentView;
    _closeOnTapView = [[UIView alloc] init];
    [_contentView addSubview:_closeOnTapView];
    
    [_closeOnTapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superview.mas_left).with.offset(0);
        make.bottom.equalTo(superview.mas_bottom).with.offset(0);
        make.top.equalTo(superview.mas_top).with.offset(0);
        make.right.equalTo(superview.mas_right).with.offset(0);
    }];
    
    UITapGestureRecognizer *tapToClose = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognized:)];
    [tapToClose setNumberOfTapsRequired:1];
    [tapToClose setEnabled:YES];
    [_closeOnTapView addGestureRecognizer:tapToClose];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRecognized:)];
    [_closeOnTapView addGestureRecognizer:pan];
}

- (void)loadIndicatorView
{
    UIView *superview = self.view;
    _indicatorView = [[UIView alloc] init];
    [self.view addSubview:_indicatorView];
    
    [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@82);
        make.width.equalTo(@82);
        make.centerY.equalTo(superview.mas_centerY);
        make.centerX.equalTo(superview.mas_centerX);
    }];
    
    _indicatorView.backgroundColor = self.indicatorBackgroundColor;
    _indicatorView.layer.cornerRadius = 8.0;
    _indicatorView.layer.borderColor = [UIColor blackColor].CGColor;
    _indicatorView.layer.borderWidth = 1.0;
    _indicatorView.layer.shadowColor = [UIColor blackColor].CGColor;
    _indicatorView.layer.shadowRadius = 8.0;
    _indicatorView.alpha = 0.9;
    
    [self loadIndicator];
}

- (void)loadIndicator
{
    UIView *superview = _indicatorView;
    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_indicatorView addSubview:_indicator];
    
    [_indicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(superview.mas_centerY);
        make.centerX.equalTo(superview.mas_centerX);
    }];
    
    _indicatorView.userInteractionEnabled = NO;
    _indicatorView.alpha = 0;
    
    [self.view layoutIfNeeded];
}

@end
