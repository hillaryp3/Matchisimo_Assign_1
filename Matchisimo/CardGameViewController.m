//
//  CardGameViewController.m
//  Matchisimo
//
//  Created by Hillary Parham on 2/8/13.
//  Copyright (c) 2013 HJPCreations. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutlet UIButton *cardButton;
@property (strong, nonatomic) Deck *deck;
@end

@implementation CardGameViewController

- (Deck *)deck
{
    if (!_deck) _deck = [[PlayingCardDeck alloc] init];
    return _deck;
}

- (void)setCardButton:(UIButton *)cardButton
{
    _cardButton = cardButton;
    Card *card = [self.deck drawRandomCard];
    [cardButton setTitle:card.contents forState:UIControlStateSelected];
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flips updated to %d", self.flipCount);
}

- (IBAction)flipCard:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    self.flipCount++;
    if (!sender.isSelected) {
        Card *card = [self.deck drawRandomCard];
        [self.cardButton setTitle:card.contents forState:UIControlStateSelected];
    }
}


@end
