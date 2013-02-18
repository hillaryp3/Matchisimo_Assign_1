//
//  PlayingCard.m
//  Matchisimo
//
//  Created by Hillary Parham on 2/9/13.
//  Copyright (c) 2013 HJPCreations. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+ (NSArray *)validSuits
{
    static NSArray *validSuits = nil;
    if (!validSuits) validSuits = @[@"♥",@"♦",@"♠",@"♣"];
    return validSuits;
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank
{
    return [self rankStrings].count-1;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    NSLog(@"there are %d cards in the array", [otherCards count]);
    
    if (otherCards.count == 1) {
        Card *otherCard = [otherCards lastObject];
        if ([otherCard isKindOfClass:[PlayingCard class]]) {
            PlayingCard *otherPlayingCard = (PlayingCard *)otherCard;
            if ([otherPlayingCard.suit isEqualToString:self.suit]) {
                score  = 2;
            } else if (otherPlayingCard.rank == self.rank){
                score = 8;
            }
        }
    } else if (otherCards.count == 2) {
        NSLog(@"Getting Here");
        PlayingCard *otherFirst = [otherCards objectAtIndex:0];
        PlayingCard *otherSecond = [otherCards lastObject];
        
        if (otherFirst.rank == self.rank &&
            otherSecond.rank == self.rank &&
            otherFirst.rank == otherSecond.rank) {
                score = 25;
        } else if ([otherFirst.suit isEqualToString:self.suit] &&
                   [otherSecond.suit isEqualToString:self.suit] &&
                   [otherFirst.suit isEqualToString:otherSecond.suit]){
            score = 12;
        }
    }
    return score;
}

@end
