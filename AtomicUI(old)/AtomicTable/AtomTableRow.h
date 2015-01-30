//
//  AtomTableRow.h
//  
//
//  Created by Brian Thomas on 8/14/13.
//
//

#import <Foundation/Foundation.h>

@class AtomTableResponse;

@interface AtomTableRow : NSObject

@property (strong, nonatomic) NSString *cellIdentifier;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *subText;
@property (strong, nonatomic) NSNumber *cellHeight;
@property (strong, nonatomic) UIColor *backgroundColor;
@property (strong, nonatomic) AtomTableResponse *response;
@property (strong, nonatomic) NSArray *cellViews;

- (id)initWithText:(NSString *)text subText:(NSString *)subText cellIdentifier:(NSString *)cellIdentifier cellHeight:(NSNumber *)cellheight backgroundColor:(UIColor *)backgroundColor responseObject:(AtomTableResponse *)response cellViews:(NSArray *)cellViews;

// .XIB FILES

- (id)initWithCellIdentifier:(NSString *)cellIdentifier cellHeight:(NSNumber *)cellHeight responseObject:(AtomTableResponse *)response cellViews:(NSArray *)cellViews;

// NON .XIB

- (id)initWithText:(NSString *)text subText:(NSString *)subText backgroundColor:(UIColor *)backgroundColor cellHeight:(NSNumber *)cellHeight responseObject:(AtomTableResponse *)response;

- (id)initWithText:(NSString *)text subText:(NSString *)subText backgroundColor:(UIColor *)backgroundColor responseObject:(AtomTableResponse *)response;

- (id)initWithText:(NSString *)text subText:(NSString *)subText responseObject:(AtomTableResponse *)response;

- (id)initWithText:(NSString *)text responseObject:(AtomTableResponse *)response;

- (id)initWithText:(NSString *)text;

@end
