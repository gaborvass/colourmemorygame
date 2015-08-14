//
//  AppDelegate.h
//  ColourMemory
//
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "HighscoreStore.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) HighscoreStore* store;

@end

