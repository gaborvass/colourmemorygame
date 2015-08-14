//
//  HighscoreStore.h
//  ColourMemory
//
//  Manages high scores and high score stores
//

#import <Foundation/Foundation.h>
#import "HighscoreStoreProtocol.h"

@interface HighscoreStore : NSObject <HighscoreStoreProtocol>

/**
 Register store implementation
*/
+(void) registerStore:(id<HighscoreStoreProtocol>)store;

@end
