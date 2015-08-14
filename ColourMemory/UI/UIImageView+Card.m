//
//  UIImageView+Card.m
//  ColourMemory
//
//  Created by Vass, Gabor on 13/08/15.
//  Copyright (c) 2015 Gabor, Vass. All rights reserved.
//

#import "UIImageView+Card.h"
#import <objc/objc.h>
#import <objc/runtime.h>

static const char* const kUIImageViewCardId = "kUIImageViewCardId";

@implementation UIImageView(Card)

@dynamic cardId;

-(void) setCardId:(NSString *)card_id{
    objc_setAssociatedObject(self, kUIImageViewCardId, card_id, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString*) cardId {
    return objc_getAssociatedObject(self, kUIImageViewCardId);
}


@end
