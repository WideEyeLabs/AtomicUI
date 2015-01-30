//
//  AtomTableDataSource.h
//  
//
//  Created by Brian Thomas on 8/14/13.
//
//

#import <Foundation/Foundation.h>
#import "AtomTableController.h"

@interface AtomTableDataSource : NSObject<AtomTableDataSource, AtomTableDelegate>

@property (strong, nonatomic) NSDictionary *cellIdentifierDictionary;

- (void)createIdentifierDictionary;

@end
