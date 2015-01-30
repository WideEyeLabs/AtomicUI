//
//  AtomTableRow.m
//  
//
//  Created by Brian Thomas on 8/14/13.
//
//

#import "AtomTableRow.h"
#import "AtomTableResponse.h"

@implementation AtomTableRow

- (id)initWithText:(NSString *)text subText:(NSString *)subText cellIdentifier:(NSString *)cellIdentifier cellHeight:(NSNumber *)cellHeight backgroundColor:(UIColor *)backgroundColor responseObject:(AtomTableResponse *)response cellViews:(NSArray *)cellViews
{
    if (self = [super init])
    {
        _text = text;
        _subText = subText;
        _cellIdentifier = cellIdentifier;
        _cellHeight = cellHeight;
        _backgroundColor = backgroundColor;
        _response = response;
        _cellViews = cellViews;
    }
    
    return self;
}

// .XIB FILES

- (id)initWithCellIdentifier:(NSString *)cellIdentifier cellHeight:(NSNumber *)cellHeight responseObject:(AtomTableResponse *)response cellViews:(NSArray *)cellViews
{
    return [self initWithText:@"" subText:@"" cellIdentifier:cellIdentifier cellHeight:cellHeight backgroundColor:[UIColor clearColor] responseObject:response cellViews:cellViews];
}

// NON .XIB

- (id)initWithText:(NSString *)text subText:(NSString *)subText backgroundColor:(UIColor *)backgroundColor cellHeight:(NSNumber *)cellHeight responseObject:(AtomTableResponse *)response
{
    return [self initWithText:text subText:subText cellIdentifier:@"subTextIdentifier" cellHeight:cellHeight backgroundColor:backgroundColor responseObject:response cellViews:@[]];
}

- (id)initWithText:(NSString *)text subText:(NSString *)subText backgroundColor:(UIColor *)backgroundColor responseObject:(AtomTableResponse *)response
{
    return [self initWithText:text subText:subText cellIdentifier:@"subTextIdentifier" cellHeight:@160 backgroundColor:backgroundColor responseObject:response cellViews:@[]];
}

- (id)initWithText:(NSString *)text subText:(NSString *)subText responseObject:(AtomTableResponse *)response
{
    return [self initWithText:text subText:subText cellIdentifier:@"subTextIdentifier" cellHeight:@40 backgroundColor:[UIColor whiteColor] responseObject:response cellViews:@[]];
}

- (id)initWithText:(NSString *)text responseObject:(AtomTableResponse *)response
{
    return [self initWithText:text subText:@"" cellIdentifier:@"defaultIdentifier" cellHeight:@40 backgroundColor:[UIColor whiteColor] responseObject:response cellViews:@[]];
}

- (id)initWithText:(NSString *)text
{
    return [self initWithText:text subText:@"" cellIdentifier:@"defaultIdentifier" cellHeight:@40 backgroundColor:[UIColor whiteColor] responseObject:nil cellViews:@[]];
}

@end
