//
//  ColourMemoryTests.m
//  ColourMemoryTests
//
//  Created by Vass, Gabor on 12/08/15.
//  Copyright (c) 2015 Gabor, Vass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "DefaultHighscoreStore.h"
#import "HighscoreItem.h"

@interface DefaultStoreTests : XCTestCase

@property (nonatomic, retain) DefaultHighscoreStore* store;

@end

@implementation DefaultStoreTests

- (void)setUp {
    [super setUp];
    
    self.store = [[DefaultHighscoreStore alloc] init];
    
    [self.store wipeData:nil];
    

}

- (void)tearDown {
    
    [self.store wipeData:nil];
    
    self.store = nil;
    
    [super tearDown];
}

- (void)testDefaultStore {
    
    [self.store loadHighscores:^(NSArray<HighscoreItemProtocol> *highscores, NSError *error) {
        XCTAssertEqual(highscores.count, 0);
    }];

    
    HighscoreItem* item1 = [[HighscoreItem alloc] init:@"Result1" score:10];
    [self.store saveNewHighscore:item1 completionHandler:^(int rank, NSError *error) {
        XCTAssertEqual(rank, 1);
    }];

    [self.store loadHighscores:^(NSArray<HighscoreItemProtocol> *highscores, NSError *error) {
        XCTAssertEqual(highscores.count, 1);
    }];

    HighscoreItem* item2 = [[HighscoreItem alloc] init:@"Result2" score:20];
    [self.store saveNewHighscore:item2 completionHandler:^(int rank, NSError *error) {
        XCTAssertEqual(rank, 1);
    }];
    

    HighscoreItem* item3 = [[HighscoreItem alloc] init:@"Result3" score:5];
    [self.store saveNewHighscore:item3 completionHandler:^(int rank, NSError *error) {
        XCTAssertEqual(rank, 3);
    }];
    
    
    HighscoreItem* item4 = [[HighscoreItem alloc] init:@"Result4" score:-4];
    [self.store saveNewHighscore:item4 completionHandler:^(int rank, NSError *error) {
        XCTAssertEqual(rank, 4);
    }];
    
    
    HighscoreItem* item5 = [[HighscoreItem alloc] init:@"Result5" score:13];
    [self.store saveNewHighscore:item5 completionHandler:^(int rank, NSError *error) {
        XCTAssertEqual(rank, 2);
    }];
    

    HighscoreItem* item6 = [[HighscoreItem alloc] init:@"Result6" score:20];
    [self.store saveNewHighscore:item6 completionHandler:^(int rank, NSError *error) {
        XCTAssertEqual(rank, 1);
    }];
    
    self.store = [[DefaultHighscoreStore alloc] init];
    
    [self.store loadHighscores:^(NSArray<HighscoreItemProtocol> *highscores, NSError *error) {
        XCTAssertEqual(highscores.count, 6);
        [highscores enumerateObjectsUsingBlock:^(id<HighscoreItemProtocol> highscore, NSUInteger idx, BOOL *stop) {
            NSLog(@"%@ %d", highscore.username, highscore.score);
            switch (idx) {
                case 0: {
                    XCTAssertEqual(20, highscore.score);
                    break;
                }
                case 1: {
                    XCTAssertEqual(20, highscore.score);
                    break;
                }
                case 2: {
                    XCTAssertEqual(13, highscore.score);
                    break;
                }
                case 3: {
                    XCTAssertEqual(10, highscore.score);
                    break;
                }
                case 4: {
                    XCTAssertEqual(5, highscore.score);
                    break;
                }
                case 5: {
                    XCTAssertEqual(-4, highscore.score);
                    break;
                }
            }
        }];
    }];
    
    [self.store wipeData:^(NSError *error) {
        [self.store loadHighscores:^(NSArray<HighscoreItemProtocol> *highscores, NSError *error) {
            XCTAssertEqual(highscores.count, 0);
        }];
    }];
    
}

@end
