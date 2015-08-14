//
//  HighscoreItem.m
//  ColourMemory
//

#import <Foundation/Foundation.h>
#import "HighscoreItem.h"

#define KEY_USERNAME    @"USERNAME"
#define KEY_SCORE       @"SCORE"

@implementation HighscoreItem

@synthesize username = _username;
@synthesize score = _score;

-(id) init:(NSString*)username score:(int)score{
    self = [super init];
    if(self){
        _username = username;
        _score = score;
    }
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.username forKey:KEY_USERNAME];
    [aCoder encodeInt:self.score forKey:KEY_SCORE];
}

-(id) initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if(self){
        _username = [aDecoder decodeObjectForKey:KEY_USERNAME];
        _score = [aDecoder decodeIntForKey:KEY_SCORE];
    }
    return self;
}

@end