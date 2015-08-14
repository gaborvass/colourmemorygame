//
//  HighscoreStore.m
//  ColourMemory
//
//  Created by Vass, Gabor on 14/08/15.
//  Copyright (c) 2015 Gabor, Vass. All rights reserved.
//

#import "HighscoreStore.h"

#define APP_NAME @"ColourMemory"

@implementation HighscoreStore

static id<HighscoreStoreProtocol> registeredStore;

+(void) registerStore:(id<HighscoreStoreProtocol>)store {
    registeredStore = store;
}

- (void) saveNewHighscore:(id<HighscoreItemProtocol>)newHighscore completionHandler:(void (^)(int rank, NSError* error))completionHandler{

    if(!registeredStore) {
        completionHandler(-1, [self generateGenericError]);
        return;
    }
    
    [registeredStore saveNewHighscore:newHighscore completionHandler:completionHandler];
}

- (void) loadHighscores:(void (^)(NSArray<HighscoreItemProtocol>* highscores, NSError* error))completionHandler{
    if(!registeredStore) {
        completionHandler(nil, [self generateGenericError]);
        return;
    }
    
    [registeredStore loadHighscores:completionHandler];
}

- (void) wipeData:(void (^)(NSError *))completionHandler{
    if(!registeredStore) {
        completionHandler([self generateGenericError]);
        return;
    }
    
    [registeredStore wipeData:completionHandler];
}

- (NSError*) generateGenericError{
    return [NSError errorWithDomain:APP_NAME code:1 userInfo:[NSDictionary dictionaryWithObject:@"There is no HighscoreStore register" forKey:NSLocalizedDescriptionKey]];
}

@end
