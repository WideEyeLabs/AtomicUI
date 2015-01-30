//
//  AtomTableDataSource.m
//  
//
//  Created by Brian Thomas on 8/14/13.
//
//

#import "AtomTableDataSource.h"

#import "Masonry.h"
#import "AtomTableData.h"
#import "AtomTableSection.h"
#import "AtomTableRow.h"
#import "AtomTableResponse.h"

@implementation AtomTableDataSource

- (void)cellTapped
{
    NSLog(@"It happened!");
}

- (void)userSelectedItemAtIndexPath:(NSIndexPath *)indexPath withResponseObject:(NSObject *)response
{
    AtomTableResponse *responder = (AtomTableResponse *)response;
    if (responder.selector) [self performSelector:responder.selector];
}

- (UITableViewCell *)cellForIdentifier:(NSString *)identifier
{
    NSNumber *cellIdentifier = [_cellIdentifierDictionary valueForKey:identifier];
    switch (cellIdentifier.intValue)
    {
        case 1:
            return [self sampleCell];
            break;
        default:
            return nil;
            break;
    }
}

- (void)customizeCell:(UITableViewCell *)cell withCellViews:(NSArray *)views
{
    for (NSDictionary *viewDictionary in views)
    {
        NSNumber *viewTag = [viewDictionary valueForKey:@"tag"];
        id view = [cell viewWithTag:viewTag.intValue];
        switch (viewTag.intValue)
        {
            case 103:
                [view setBackgroundColor:[viewDictionary valueForKey:@"backgroundColor"]];
                break;
            default:
                break;
        }
    }
}

- (void)createIdentifierDictionary
{
    if (!_cellIdentifierDictionary) _cellIdentifierDictionary = @{@"sampleCell": @1};
}

- (UITableViewCell *)sampleCell
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sampleCell"];
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor purpleColor];
    view.tag = 103;
    
    [cell.contentView addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(cell.contentView.mas_right).with.offset(-10);
        make.height.equalTo(@20);
        make.width.equalTo(@20);
        make.centerY.equalTo(cell.contentView.mas_centerY);
    }];
    
    return cell;
}



- (AtomTableData *)tableDataForTable:(AtomTableController *)table
{
    UIView *headerThing = [[UIView alloc] init];
    [headerThing setBackgroundColor:[UIColor blackColor]];
    [headerThing setFrame:CGRectMake(0, 0, 10, 100)];
    
    UIView *footerThing = [[UIView alloc] init];
    [footerThing setBackgroundColor:[UIColor blackColor]];
    [footerThing setFrame:CGRectMake(0, 0, 10, 100)];
    
    UIView *superview1 = [[UIView alloc] init];
    superview1.backgroundColor = [UIColor blackColor];
    
    UIView *colorView1 = [[UIView alloc] init];
    colorView1.backgroundColor = [UIColor greenColor];
    
    [superview1 addSubview:colorView1];
    
    [colorView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@10);
        make.width.equalTo(@10);
        make.centerY.equalTo(superview1.mas_centerY);
        make.centerX.equalTo(superview1.mas_centerX);
    }];
    
    UIView *superview12 = [[UIView alloc] init];
    superview12.backgroundColor = [UIColor blackColor];
    
    UIView *colorView12 = [[UIView alloc] init];
    colorView12.backgroundColor = [UIColor greenColor];
    
    [superview12 addSubview:colorView12];
    
    [colorView12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superview12.mas_left).with.offset(20);
        make.bottom.equalTo(superview12.mas_bottom).with.offset(-10);
        make.top.equalTo(superview12.mas_top).with.offset(10);
        make.right.equalTo(superview12.mas_right).with.offset(-20);
    }];
    
    UIView *superview2 = [[UIView alloc] init];
    superview2.backgroundColor = [UIColor blackColor];
    
    UIView *colorView2 = [[UIView alloc] init];
    colorView2.backgroundColor = [UIColor redColor];
    
    [superview2 addSubview:colorView2];
    
    [colorView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@10);
        make.width.equalTo(@10);
        make.centerY.equalTo(superview2.mas_centerY);
        make.centerX.equalTo(superview2.mas_centerX);
    }];
    
    UIView *superview22 = [[UIView alloc] init];
    superview22.backgroundColor = [UIColor blackColor];
    
    UIView *colorView22 = [[UIView alloc] init];
    colorView22.backgroundColor = [UIColor redColor];
    
    [superview22 addSubview:colorView22];
    
    [colorView22 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superview22.mas_left).with.offset(20);
        make.bottom.equalTo(superview22.mas_bottom).with.offset(-10);
        make.top.equalTo(superview22.mas_top).with.offset(10);
        make.right.equalTo(superview22.mas_right).with.offset(-40);
    }];
    
    UIView *superview3 = [[UIView alloc] init];
    superview3.backgroundColor = [UIColor blackColor];
    
    UIView *colorView3 = [[UIView alloc] init];
    colorView3.backgroundColor = [UIColor yellowColor];
    
    [superview3 addSubview:colorView3];
    
    [colorView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@10);
        make.width.equalTo(@10);
        make.centerY.equalTo(superview3.mas_centerY);
        make.centerX.equalTo(superview3.mas_centerX);
    }];
    
    UIView *superview32 = [[UIView alloc] init];
    superview32.backgroundColor = [UIColor blackColor];
    
    UIView *colorView32 = [[UIView alloc] init];
    colorView32.backgroundColor = [UIColor yellowColor];
    
    [superview32 addSubview:colorView32];
    
    [colorView32 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superview32.mas_left).with.offset(20);
        make.bottom.equalTo(superview32.mas_bottom).with.offset(-10);
        make.top.equalTo(superview32.mas_top).with.offset(10);
        make.right.equalTo(superview32.mas_right).with.offset(-40);
    }];
    
    AtomTableResponse *response = [[AtomTableResponse alloc] init];
    response.selector = @selector(cellTapped);
    
    AtomTableResponse *response2 = [[AtomTableResponse alloc] init];
    response2.selector = @selector(cellTapped);
    
    AtomTableResponse *response3 = [[AtomTableResponse alloc] init];
    response3.selector = @selector(cellTapped);
    
    NSArray *cellViewSample = @[@{@"tag": @103, @"backgroundColor": [UIColor blueColor]}];
    
    return [[AtomTableData alloc] initWithSections:
            @[[[AtomTableSection alloc] initWithHeaderView:superview1 footerView:superview12 headerCellHeight:@40 footerCellHeight:@26 rows:
               @[[[AtomTableRow alloc] initWithText:@"Here is a"],
               [[AtomTableRow alloc] initWithText:@"title" subText:@"subtitle" responseObject:response],
               [[AtomTableRow alloc] initWithText:@"title" subText:@"subtitle" responseObject:nil],
               [[AtomTableRow alloc] initWithText:@"Here is a"]]],
            
            [[AtomTableSection alloc] initWithHeaderView:superview2 footerView:superview22 headerCellHeight:@40 footerCellHeight:@26 rows:
             @[[[AtomTableRow alloc] initWithText:@"Here is a"],
             [[AtomTableRow alloc] initWithText:@"Load" subText:@"Use Indicator" backgroundColor:[UIColor greenColor] cellHeight:@80 responseObject:response2],
             [[AtomTableRow alloc] initWithText:@"Stop" subText:@"Loading Indicator" backgroundColor:[UIColor redColor] cellHeight:@60 responseObject:response3],
             [[AtomTableRow alloc] initWithText:@"Here is a"]]],
            
            [[AtomTableSection alloc] initWithHeaderView:superview3 footerView:superview32 headerCellHeight:@40 footerCellHeight:@26 rows:
             @[[[AtomTableRow alloc] initWithText:@"Here is a"],
             [[AtomTableRow alloc] initWithCellIdentifier:@"sampleCell" cellHeight:@100 responseObject:nil cellViews:cellViewSample],
             [[AtomTableRow alloc] initWithText:@"title" subText:@"subtitle" responseObject:nil],
             [[AtomTableRow alloc] initWithText:@"Here is a"]]]] headerView:headerThing footerView:footerThing];
}

@end
