//
//  AtomTableSection.m
//  
//
//  Created by Brian Thomas on 8/14/13.
//
//

#import "AtomTableSection.h"

@implementation AtomTableSection

- (id)initWithHeaderView:(UIView *)headerView footerView:(UIView *)footerView headerText:(NSString *)headerText foortText:(NSString *)footerText headerCellIdentifier:(NSString *)headerCellIdentifier headerCellHeight:(NSNumber *)headerCellHeight footerCellHeight:(NSNumber*)footerCellHeight rows:(NSArray *)rows
{
    if (self = [super init])
    {
        _headerView = headerView;
        _footerView = footerView;
        _headerText = headerText;
        _footerText = footerText;
        _headerCellIdentifier = headerCellIdentifier;
        _headerCellHeight = headerCellHeight;
        _footerCellHeight = footerCellHeight;
        _rows = rows;
    }
    
    return self;
}

- (id)initWithHeaderView:(UIView *)headerView footerView:(UIView *)footerView headerCellHeight:(NSNumber *)headerCellHeight footerCellHeight:(NSNumber *)footerCellHeight rows:(NSArray *)rows
{
    return [self initWithHeaderView:headerView footerView:footerView headerText:@"" foortText:@"" headerCellIdentifier:@"headerIdentifier" headerCellHeight:headerCellHeight footerCellHeight:footerCellHeight rows:rows];
}

- (id)initWithHeaderView:(UIView *)headerView headerCellHeight:(NSNumber *)headerCellHeight rows:(NSArray *)rows
{
    return [self initWithHeaderView:headerView footerView:nil headerText:@"" foortText:@"" headerCellIdentifier:@"headerIdentifier" headerCellHeight:headerCellHeight footerCellHeight:@0 rows:rows];
}

- (id)initWithHeaderText:(NSString *)headerText rows:(NSArray *)rows
{
    return [self initWithHeaderView:nil footerView:nil headerText:headerText foortText:@"" headerCellIdentifier:@"headerIdentifier" headerCellHeight:@30 footerCellHeight:@0 rows:rows];
}

- (id)initWithRows:(NSArray *)rows
{
    return [self initWithHeaderView:nil footerView:nil headerText:@"" foortText:@"" headerCellIdentifier:@"headerIdentifier" headerCellHeight:@0 footerCellHeight:@0 rows:rows];
}


@end
