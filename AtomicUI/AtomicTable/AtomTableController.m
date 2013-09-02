//
//  AtomTableController.m
//  
//
//  Created by Brian Thomas on 8/14/13.
//
//

#import "AtomTableController.h"

#import "AtomTableData.h"
#import "AtomTableSection.h"
#import "AtomTableRow.h"
#import "AtomTableResponse.h"

@interface AtomTableController ()

@property (strong, nonatomic) AtomTableData *tableData;

@end

@implementation AtomTableController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableData = [_dataSource tableDataForTable:self];
    self.tableView.separatorStyle = _tableData.seperatorStyle;
    self.tableView.separatorColor = _tableData.seperatorColor;
    self.tableView.tableHeaderView = _tableData.headerView;
    self.tableView.tableFooterView = _tableData.footerView;
    self.tableView.backgroundColor = _tableData.backgroundColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_tableData.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AtomTableSection *currentSection = _tableData.sections[section];
    return [currentSection.rows count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AtomTableSection *section = _tableData.sections[[indexPath section]];
    AtomTableRow *row = section.rows[[indexPath row]];
    NSArray *cellViews = row.cellViews;
    
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:row.cellIdentifier];
    if (!cell)
    {
        cell = [_dataSource cellForIdentifier:row.cellIdentifier];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"subtitleCell"];
        }
    }
    
    cell.textLabel.text = row.text;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.text = row.subText;
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = row.backgroundColor;
    
    [_dataSource customizeCell:cell withCellViews:row.cellViews];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AtomTableSection *section = _tableData.sections[[indexPath section]];
    AtomTableRow *row = section.rows[[indexPath row]];
    return row.cellHeight.floatValue;
}



#pragma mark - Header Methods

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    AtomTableSection *sec = _tableData.sections[section];
    return sec.headerText;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    AtomTableSection *sec = _tableData.sections[section];
    return sec.footerText;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    AtomTableSection *sec = _tableData.sections[section];
    return sec.headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    AtomTableSection *sec = _tableData.sections[section];
    return sec.footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    AtomTableSection *sec = _tableData.sections[section];
    return sec.headerCellHeight.intValue;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    AtomTableSection *sec = _tableData.sections[section];
    return sec.footerCellHeight.intValue;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AtomTableSection *section = _tableData.sections[[indexPath section]];
    AtomTableRow *row = section.rows[[indexPath row]];
    [_delegate userSelectedItemAtIndexPath:indexPath withResponseObject:row.response];
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}



#pragma mark - Methods For Tagged View Setup

- (void)setUpUIView:(UIView *)view withOptions:(NSDictionary *)cellDescription
{
    
}

- (void)setUpUIImageView:(UIImageView *)imageView withOptions:(NSDictionary *)cellDescription
{
    
}

- (void)setUpUILabel:(UILabel *)label withOptions:(NSDictionary *)cellDescription
{
    
}

@end
