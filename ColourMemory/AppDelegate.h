//
//  AppDelegate.h
//  ColourMemory
//
//  Created by Vass, Gabor on 12/08/15.
//  Copyright (c) 2015 Gabor, Vass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "HighscoreStore.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) HighscoreStore* store;

@end

