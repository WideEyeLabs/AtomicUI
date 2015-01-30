//
//  AtomTableData.m
//  
//
//  Created by Brian Thomas on 8/14/13.
//
//

#import "AtomTableData.h"

@implementation AtomTableData

- (id)initWithSections:(NSArray *)sections backgroundColor:(UIColor *)backgroundColor backgroundView:(UIView *)backgroundView headerView:(UIView *)header footerView:(UIView *)footer
{
    if (self = [super init])
    {
        _sections = sections;
        _backgroundColor = backgroundColor;
        _backgroundView = backgroundView;
        _headerView = header;
        _footerView = footer;
        _seperatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _seperatorColor = [UIColor lightGrayColor];
    }
    
    return self;
}

- (id)initWithSections:(NSArray *)sections headerView:(UIView *)header footerView:(UIView *)footer
{
    return [self initWithSections:sections backgroundColor:[UIColor blackColor] backgroundView:nil headerView:header footerView:footer];
}

- (id)initWithSections:(NSArray *)sections
{
    return [self initWithSections:sections headerView:nil footerView:nil];
}

@end
