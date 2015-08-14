//
//  HighscoresViewController.m
//  ColourMemory
//
//  Created by Vass, Gabor on 13/08/15.
//  Copyright (c) 2015 Gabor, Vass. All rights reserved.
//

#import "HighscoresViewController.h"
#import "PositionTableViewCell.h"
#import "DefaultHighscoreStore.h"
#import "AppDelegate.h"

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
    // Dispose of any resources that can be recreated.
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

    PositionTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"positionCell" forIndexPath:indexPath];
    
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
