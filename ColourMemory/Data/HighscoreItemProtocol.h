//
//  HighscoreItemProtocol.m
//  ColourMemory
//
//  Created by Vass, Gabor on 12/08/15.
//  Copyright (c) 2015 Gabor, Vass. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HighscoreItemProtocol <NSObject, NSCoding>

@property (nonatomic, retain, readonly) NSString* username;
@property (nonatomic, assign, readonly) int score;

-(id) init:(NSString*)username score:(int)score;

@end
