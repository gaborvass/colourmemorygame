//
//  HighscoresViewController.m
//  ColourMemory
//
//

#import "HighscoresViewController.h"
#import "PositionTableViewCell.h"
#import "DefaultHighscoreStore.h"
#import "AppDelegate.h"

#define REUSABLE_CELL_ID @"positionCell"

@interface HighscoresViewController ()

@property (nonatomic, retain) NSArray<HighscoreItemProtocol>* highscores;

@end

@implementation HighscoresViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void) viewWillAppear:(BOOL)animated{
    
    AppDelegate* appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdelegate.store loadHighscores:^(NSArray<HighscoreItemProtocol> *highscores, NSError *error) {
        self.highscores = highscores;
    }];
    
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidLayoutSubviews{
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]){
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.highscores count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    PositionTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:REUSABLE_CELL_ID forIndexPath:indexPath];
    
    [cell setSeparatorInset:UIEdgeInsetsZero];

    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    id<HighscoreItemProtocol> highscore = [self.highscores objectAtIndex:indexPath.row];
    
    cell.positionLabel.text = [NSString stringWithFormat:@"%d", (int)indexPath.row + 1];
    cell.usernameLabel.text = highscore.username;
    cell.resultLabel.text = [NSString stringWithFormat:@"%d", highscore.score];
    
    return cell;
}

@end
