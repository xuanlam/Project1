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

- (void)gamePlayLayerNeedDrawLine:(SinglePlayerGamePlayLayer *)gamePlayLayer withPoints:(NSArray *)points andDirections:(NSArray *)directions;
- (void)gamePlayLayerNeedUpdateTimeLeft:(SinglePlayerGamePlayLayer *)gamePlayLayer WithValue:(float)value;

@end