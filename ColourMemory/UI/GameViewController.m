//
//  GameViewController.m
//  ColourMemory
//
//

#import "GameViewController.h"
#import "UIImageView+Card.h"
#import "AppDelegate.h"
#import "HighscoreItem.h"

#define LOGO_IMG    @"logo"
#define CARD_BG_IMG @"card_bg"
#define CARD_ID     @"colour%d"
#define SHOW_HIGHSCORE_SEGUE_ID @"showHighscores"


@interface UINavigationController(GameController)

@end

@interface GameViewController () <UIGestureRecognizerDelegate, UIAlertViewDelegate>

@property (nonatomic, retain) NSMutableArray* cards;
@property (nonatomic, retain) UIImageView* selectedCard;

@end

@implementation GameViewController

int score = 0;
int numOfPairsFound = 0;

CGFloat calculated_row_height = 0;
CGFloat calculated_column_width = 0;

CGFloat calculated_card_height = 0;
CGFloat calculated_card_width = 0;

static int NUM_OF_ROWS     = 4;
static int NUM_OF_COLUMNS  = 4;

static int MARGIN_X = 10;
static int MARGIN_Y = 10;

static int SPACING = 5;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIImage* img_logo = [UIImage imageNamed:LOGO_IMG];
    
    UIImageView* uiv = [[UIImageView alloc] initWithImage:img_logo];
    [uiv setFrame:CGRectMake(0, 0, 80, 30)];
    UIBarButtonItem* barItem = [[UIBarButtonItem alloc] initWithCustomView:uiv];
    
    self.navigationItem.leftBarButtonItem = barItem;
    
    [self generateCards];

    [self createLaout];
    
}

- (void) createLaout {
    [self generateCards];
    
    for(UIView* subView in self.view.subviews){
        if([subView isKindOfClass:[UIImageView class]]){
            UIImageView* imgView = (UIImageView*)subView;
            if(imgView.cardId != nil){
                [subView removeFromSuperview];
            }
        }
    }
    
    CGFloat x = self.view.bounds.size.width;
    CGFloat y = self.view.bounds.size.height;
    
    x = x - 2 * MARGIN_X;
    y = y - 2 * MARGIN_Y - self.navigationController.navigationBar.frame.size.height;
    
    calculated_row_height = y / NUM_OF_ROWS;
    calculated_column_width = x / NUM_OF_COLUMNS;
    
    calculated_card_height = calculated_row_height - SPACING;
    calculated_card_width = calculated_column_width - SPACING;
    
    
    
    UIImage* card_bgImage = [UIImage imageNamed:CARD_BG_IMG];
    
    for(int row = 0; row < 4; ++row){
        for(int column = 0; column < 4; ++column){
            CGRect imageViewRect = CGRectMake((column * calculated_column_width) + MARGIN_X + SPACING, (row * calculated_row_height) + MARGIN_Y + SPACING + 52, calculated_card_width, calculated_card_height);
            
            UIImageView* cardView = [[UIImageView alloc] initWithImage:card_bgImage];
            [cardView setFrame:imageViewRect];
            
            
            UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                                     initWithTarget:self action:@selector(cardSelected:)];
            [tapRecognizer setNumberOfTouchesRequired:1];
            [tapRecognizer setDelegate:self];
            [cardView addGestureRecognizer:tapRecognizer];
            [cardView setUserInteractionEnabled:YES];
            
            [cardView setCardId:[self.cards objectAtIndex:(row * NUM_OF_ROWS) + column]];
            
            [self.view addSubview:cardView];
        }
    }
    numOfPairsFound = 0;
    self.navigationItem.title = [NSString stringWithFormat:@"%d points", score];
}


-(void) clearCard:(UIImageView*)imageView{
    UIImage* cardImage = [UIImage imageNamed:CARD_BG_IMG];
    [self flipCard:imageView cardImage:cardImage];
    [self.view setUserInteractionEnabled:YES];
}

-(void) flipCard:(UIImageView*)imageView cardImage:(UIImage*)cardImage{
    [UIView transitionWithView:imageView duration:0.2f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        imageView.image = cardImage;
    } completion:nil];
}

-(void) removeCard:(UIImageView*)imageView{
    [self.view setUserInteractionEnabled:YES];
    [UIView transitionWithView:imageView duration:0.5f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [imageView setHidden:YES];
    } completion:nil];
}

-(void) cardSelected:(UIGestureRecognizer*)sender{
    
    UIImageView* selectedIV = (UIImageView*)sender.view;
    NSString* cardId = selectedIV.cardId;
    UIImage* cardImage = [UIImage imageNamed:cardId];

    if(self.selectedCard == nil){
        [self flipCard:selectedIV cardImage:cardImage];
        self.selectedCard = selectedIV;
    }else if(self.selectedCard == sender.view){
        [self clearCard:selectedIV];
        self.selectedCard = nil;
    }else {
        [self flipCard:selectedIV cardImage:cardImage];
        if([self.selectedCard.cardId isEqualToString:cardId]){
            [self.view setUserInteractionEnabled:NO];

            [self performSelector:@selector(removeCard:) withObject:selectedIV afterDelay:1.0f];
            [self performSelector:@selector(removeCard:) withObject:self.selectedCard afterDelay:1.0f];
            score += 2;
            numOfPairsFound++;
            if(numOfPairsFound == 8){
                UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"Finished" message:@"Enter your name" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Save", nil];
                av.alertViewStyle = UIAlertViewStylePlainTextInput;
                [[av textFieldAtIndex:0] setText:@""];
                [av show];
            }
        }else{
            [self.view setUserInteractionEnabled:NO];
            [self performSelector:@selector(clearCard:) withObject:selectedIV afterDelay:1.0f];
            [self performSelector:@selector(clearCard:) withObject:self.selectedCard afterDelay:1.0f];
            score -= 1;
            
        }
        self.selectedCard = nil;
        self.navigationItem.title = [NSString stringWithFormat:@"%d points", score];
    }
    

}

-(void) generateCards {
    NSMutableDictionary* selectedCards = [NSMutableDictionary dictionary];
    
    self.cards = [NSMutableArray array];
    for(int i = 0; i<16; ++i){
        int selectionTimes;
        NSString* cardId;
        do {
            cardId = [NSString stringWithFormat:CARD_ID,arc4random_uniform(8)+1];
            selectionTimes = [[selectedCards objectForKey:cardId] intValue];
        } while (selectionTimes == 2);
        
        [selectedCards setObject:[NSNumber numberWithInt:selectionTimes+1] forKey:cardId];
        
        [self.cards addObject:cardId];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.alertViewStyle == UIAlertViewStylePlainTextInput){
        UITextField* textField = [alertView textFieldAtIndex:0];
        __block NSString* username = textField.text;
        AppDelegate* appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        HighscoreItem* hs = [[HighscoreItem alloc] init:username score:score];
        
        [appdelegate.store saveNewHighscore:hs completionHandler:^(int rank, NSError *error) {
            NSString* message = [NSString stringWithFormat:@"Congratulation %@, you finished at %d. position", username, rank];
            UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"Highscore" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [av show];
        }];
        
        self.selectedCard = nil;
        score = 0;
        [self createLaout];
    }else{
        [self performSegueWithIdentifier:SHOW_HIGHSCORE_SEGUE_ID sender:self];
    }
    
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView{
    UITextField* textField = [alertView textFieldAtIndex:0];
    if(textField){
        NSString* content = textField.text;
        content = [content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if(content.length > 0){
            return YES;
        }
    }

    return NO;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];

}

@end

@implementation UINavigationController(GameController)

- (BOOL)shouldAutorotate{
    id currentViewController = self.topViewController;
    
    if ([currentViewController isKindOfClass:[GameViewController class]]){
        return NO;
    }
    
    return YES;
}
@end
