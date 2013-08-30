//
//  AtomTableData.h
//  
//
//  Created by Brian Thomas on 8/14/13.
//
//

#import <Foundation/Foundation.h>

@interface AtomTableData : NSObject

@property (strong, nonatomic) NSArray *sections;
@property (strong, nonatomic) UIColor *backgroundColor;
@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UIView *footerView;

- (id)initWithSections:(NSArray *)sections backgroundColor:(UIColor *)backgroundColor backgroundView:(UIView *)backgroundView headerView:(UIView *)header footerView:(UIView *)footer;

- (id)initWithSections:(NSArray *)sections headerView:(UIView *)header footerView:(UIView *)footer;

- (id)initWithSections:(NSArray *)sections;

@end
