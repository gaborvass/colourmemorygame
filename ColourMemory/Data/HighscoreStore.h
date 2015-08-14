//
//  HighscoreStore.h
//  ColourMemory
//
//  Created by Vass, Gabor on 14/08/15.
//  Copyright (c) 2015 Gabor, Vass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HighscoreStoreProtocol.h"

@interface HighscoreStore : NSObject <HighscoreStoreProtocol>

+(void) registerStore:(id<HighscoreStoreProtocol>)store;

@end
