//
//  DefaultHighscoreStore.h
//  ColourMemory
//
//  Default implementation of HighscoreStoreProtocol
//  Uses NSUserDefaults to store data
//

#import <Foundation/Foundation.h>
#import "HighscoreStoreProtocol.h"

@interface DefaultHighscoreStore : NSObject <HighscoreStoreProtocol>

@end