//
//  AtomTableSection.h
//  
//
//  Created by Brian Thomas on 8/14/13.
//
//

#import <Foundation/Foundation.h>

@interface AtomTableSection : NSObject

@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UIView *footerView;
@property (strong, nonatomic) NSString *headerText;
@property (strong, nonatomic) NSString *footerText;
@property (strong, nonatomic) NSString *headerCellIdentifier;
@property (strong, nonatomic) NSNumber *headerCellHeight;
@property (strong, nonatomic) NSNumber *footerCellHeight;
@property (strong, nonatomic) NSArray *headerViews;
@property (strong, nonatomic) NSArray *rows;

- (id)initWithHeaderView:(UIView *)headerView
              footerView:(UIView *)footerView
              headerText:(NSString *)headerText
               foortText:(NSString *)footerText
    headerCellIdentifier:(NSString *)headerCellIdentifier
        headerCellHeight:(NSNumber *)headerCellHeight
        footerCellHeight:(NSNumber *)footerCellHeight
                    rows:(NSArray *)rows;

- (id)initWithHeaderView:(UIView *)headerView footerView:(UIView *)footerView headerCellHeight:(NSNumber *)headerCellHeight footerCellHeight:(NSNumber *)footerCellHeight rows:(NSArray *)rows;

- (id)initWithHeaderView:(UIView *)headerView headerCellHeight:(NSNumber *)headerCellHeight rows:(NSArray *)rows;

- (id)initWithHeaderText:(NSString *)headerText rows:(NSArray *)rows;

- (id)initWithRows:(NSArray *)rows;

@end
