//
//  HighscoreProtocol.h
//  ColourMemory
//
//  Created by Vass, Gabor on 12/08/15.
//  Copyright (c) 2015 Gabor, Vass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HighscoreItemProtocol.h"

@protocol HighscoreStoreProtocol <NSObject>

- (void) saveNewHighscore:(id<HighscoreItemProtocol>)newHighscore completionHandler:(void (^)(int rank, NSError* error))completionHandler;

- (void) loadHighscores:(void (^)(NSArray<HighscoreItemProtocol>* highscores, NSError* error))completionHandler;

- (void) wipeData:(void (^)(NSError* error))completionHandler;

@end
