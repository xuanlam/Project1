//
//  SinglePlayerGameLayer.h
//  Pikachu
//
//  Created by Xuan Lam on 8/8/12.
//
//
typedef enum {
    DirectionLeft = 0,
    DirectionRight = 1,
    DirectionUp = 2,
    DirectionDown = 3,
    DirectionNone = 4
} Direction;


@protocol SinglePlayerGamePlayDelegate;

#import "CCLayer.h"
#import "GameCell.h"

@interface SinglePlayerGamePlayLayer : CCLayer

@property (nonatomic, unsafe_unretained) id<SinglePlayerGamePlayDelegate> delegate;

- (void)showHint;
- (void)randomMap;

@end

@protocol SinglePlayerGamePlayDelegate <NSObject>

- (void)gamePlayLayer:(SinglePlayerGamePlayLayer *)gamePlayLayer needDrawLineWithPoints:(NSArray *)points andDirections:(NSArray *)directions;
- (void)gamePlayLayer:(SinglePlayerGamePlayLayer *)gamePlayLayer needUpdateTimeLeftWithValue:(float)value;
- (void)gamePlayLayer:(SinglePlayerGamePlayLayer *)gamePlayLayer needUpdateScoreWithScore:(NSInteger)score;
- (void)gamePlayLayer:(SinglePlayerGamePlayLayer *)gamePlayLayer needUpdateLevelWithLevel:(NSInteger)level;
- (void)gamePlayLayer:(SinglePlayerGamePlayLayer *)gamePlayLayer needUpdateCountHintWithNumber:(NSInteger)countHint;
- (void)gamePlayLayer:(SinglePlayerGamePlayLayer *)gamePlayLayer needUpdateCountRandomWithNumber:(NSInteger)countRandom;

@end