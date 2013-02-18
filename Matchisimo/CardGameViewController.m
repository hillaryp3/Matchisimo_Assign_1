//
//  CardGameViewController.m
//  Matchisimo
//
//  Created by Hillary Parham on 2/8/13.
//  Copyright (c) 2013 HJPCreations. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameDetailLabel;
@property (strong, nonatomic) IBOutlet UIButton *dealButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameMode;
@end

@implementation CardGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.flipsLabel.text = @"";
    self.gameMode.hidden = NO;
}
- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                         usingDeck:[[PlayingCardDeck alloc] init]];
        return  _game;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI
{
    
    
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
        if(!card.isFaceUp){
            UIImage *cardBackImage = [UIImage imageNamed:@"decker06.jpg"];
            [cardButton setImageEdgeInsets:UIEdgeInsetsMake(-1.0, -1.0, -1.0, -1.0)];
            [cardButton setImage:cardBackImage forState:UIControlStateNormal];
        } else {
            [cardButton setImage:nil forState:UIControlStateNormal];
        }
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.gameDetailLabel.text = self.game.flipState;
}
- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flips updated to %d", self.flipCount);
}

- (IBAction)flipCard:(UIButton *)sender {
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.gameMode.hidden = YES;
    self.flipCount++;
    [self updateUI];
}

- (IBAction)pressDealButton:(UIButton *)sender
{
    self.game = nil;
    self.gameMode.hidden = NO;
    self.game.score = 0;
    self.gameDetailLabel.text = nil;
    self.game.flipState = nil;
    self.flipCount = 0;
    [self updateUI];
    
}

- (IBAction)changeGameMode:(UISegmentedControl *)sender {
    self.game.mode = sender.selectedSegmentIndex;
    if (sender.selectedSegmentIndex) {
        NSLog(@"Switched to 3 card game mode");
    } else {
        NSLog(@"Switched to 2 card game mode");
    }
}

@end
