//
//  AtomTableController.h
//  
//
//  Created by Brian Thomas on 8/14/13.
//
//

#import <UIKit/UIKit.h>

@class AtomTableData;

@protocol AtomTableDelegate;
@protocol AtomTableDataSource;

@interface AtomTableController : UITableViewController

@property (nonatomic) id<AtomTableDelegate> delegate;
@property (nonatomic) id<AtomTableDataSource> dataSource;

@end

@protocol AtomTableDataSource <NSObject>

- (UITableViewCell *)cellForIdentifier:(NSString *)identifier;
- (AtomTableData *)tableDataForTable:(AtomTableController *)table;
- (void)customizeCell:(UITableViewCell *)cell withCellViews:(NSArray *)views;

@end

@protocol AtomTableDelegate <NSObject>

- (void)userSelectedItemAtIndexPath:(NSIndexPath *)indexPath withResponseObject:(NSObject *)response;

@end
