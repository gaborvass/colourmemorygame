//
//  HighscoreProtocol.h
//  ColourMemory
//
//  Interface definition for store implementations
//

#import <Foundation/Foundation.h>
#import "HighscoreItemProtocol.h"

@protocol HighscoreStoreProtocol <NSObject>

/**
 Save new high score
 @param id<HighscoreItemProtocol> new high score to be saved
 @param completionHandler: will be called when the high score is saved. Contains the ranking and in case of any error the root cause.
*/
- (void) saveNewHighscore:(id<HighscoreItemProtocol>)newHighscore completionHandler:(void (^)(int rank, NSError* error))completionHandler;

/**
 Load high scores from persistent store
 @param completionHandler: will be called when the high scores are returned. Contains the high scores and in case of any error the root cause.
*/
- (void) loadHighscores:(void (^)(NSArray<HighscoreItemProtocol>* highscores, NSError* error))completionHandler;

/**
 Wipe all data from persistent store
 @param completionHandler: will be called when deletion is finished. Contains in case of any error the root cause.
*/
- (void) wipeData:(void (^)(NSError* error))completionHandler;

@end
