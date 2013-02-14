//
//  CardMatchingGame.h
//  Matchisimo
//
//  Created by Hillary Parham on 2/12/13.
//  Copyright (c) 2013 HJPCreations. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic) int score;
@property (nonatomic) NSString *flipState;

@end
