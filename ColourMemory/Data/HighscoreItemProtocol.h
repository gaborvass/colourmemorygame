//
//  HighscoreItemProtocol.m
//  ColourMemory
//  Interface definition of High Score objects
//

#import <Foundation/Foundation.h>

@protocol HighscoreItemProtocol <NSObject, NSCoding>

@property (nonatomic, retain, readonly) NSString* username;
@property (nonatomic, assign, readonly) int score;

/**
 Custom init method
 @param username: name of the user
 @param score: result score
*/
-(id) init:(NSString*)username score:(int)score;

@end
