//
//  DefaultHighscoreStore.m
//  ColourMemory
//
//  Created by Vass, Gabor on 12/08/15.
//  Copyright (c) 2015 Gabor, Vass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DefaultHighscoreStore.h"
#import "HighscoreItem.h"

#define KEY_HIGHSCORES @"HIGHSCORES"

@interface DefaultHighscoreStore()
    
@property (nonatomic, retain) NSMutableArray<HighscoreItemProtocol>* highscores;

@end

@implementation DefaultHighscoreStore

-(id) init{
    self = [super init];
    if(self){
        self.highscores = (NSMutableArray<HighscoreItemProtocol>*)[NSMutableArray new];
    }
    return self;
}

-(void) saveNewHighscore:(id<HighscoreItemProtocol>)newHighscore completionHandler:(void (^)(int rank, NSError* error))completionHandler {
    __block int newRank = 0;
    
    NSMutableArray<HighscoreItemProtocol>* copiedHighscores = (NSMutableArray<HighscoreItemProtocol>*)[NSMutableArray arrayWithCapacity:self.highscores.count + 1];
    
    if(self.highscores.count == 0){
        [self.highscores addObject:newHighscore];
    }else{
        __block BOOL newItemAdded = NO;
        [self.highscores enumerateObjectsUsingBlock:^(id<HighscoreItemProtocol> highscore, NSUInteger idx, BOOL *stop) {
            if(!newItemAdded){
                if(newHighscore.score < highscore.score){
                    [copiedHighscores addObject:highscore];
                } else if (newHighscore.score == highscore.score){
                    // newer comes first
                    [copiedHighscores addObject:newHighscore];
                    [copiedHighscores addObject:highscore];
                    newRank = (int)idx;
                    newItemAdded = YES;
                } else {
                    [copiedHighscores addObject:newHighscore];
                    [copiedHighscores addObject:highscore];
                    newRank = (int)idx;
                    newItemAdded = YES;
                }
            }else{
                [copiedHighscores addObject:highscore];
            }
        }];
        if(!newItemAdded){
            [copiedHighscores addObject:newHighscore];
            newRank = (int)copiedHighscores.count - 1;
        }
        self.highscores = copiedHighscores;
    }
    
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:self.highscores];
    
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:KEY_HIGHSCORES];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // return position starting from 1

    completionHandler(newRank+1, nil);
}

-(void) loadHighscores:(void (^)(NSArray<HighscoreItemProtocol>* highscores, NSError* error))completionHandler{
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_HIGHSCORES];
    if(data != nil){
        self.highscores = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    
    completionHandler(self.highscores, nil);
    
}

-(void) wipeData:(void (^)(NSError *))completionHandler{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_HIGHSCORES];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.highscores = (NSMutableArray<HighscoreItemProtocol>*)[NSMutableArray new];

}

@end