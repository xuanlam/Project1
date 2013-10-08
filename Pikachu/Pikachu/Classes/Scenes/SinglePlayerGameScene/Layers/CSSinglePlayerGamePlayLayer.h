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

typedef enum {
    PKCLogicAlignmentNone,
    PKCLogicAlignmentTop,
    PKCLogicAlignmentLeft,
    PKCLogicAlignmentBottom,
    PKCLogicAlignmentRight
} PKCLogicAlignment;

@protocol CSSinglePlayerGamePlayDelegate;

#import "CCLayer.h"
#import "CSGameCell.h"

@interface CSSinglePlayerGamePlayLayer : CCLayer

@property (nonatomic, unsafe_unretained) id<CSSinglePlayerGamePlayDelegate> delegate;

- (void)showHint;
- (void)randomMap;
- (void)addTime;

@end

@protocol CSSinglePlayerGamePlayDelegate <NSObject>

- (void)gamePlayLayer:(CSSinglePlayerGamePlayLayer *)gamePlayLayer needDrawGuideWithPoints:(NSArray *)points andDirections:(NSArray *)directions onCompletion:(void(^)())completion;
- (void)gamePlayLayer:(CSSinglePlayerGamePlayLayer *)gamePlayLayer needDrawHintWithPoints:(NSArray *)points andDirections:(NSArray *)directions onCompletion:(void(^)())completion;
- (void)gamePlayLayer:(CSSinglePlayerGamePlayLayer *)gamePlayLayer needUpdateTimeLeftWithValue:(float)value;
- (void)gamePlayLayer:(CSSinglePlayerGamePlayLayer *)gamePlayLayer needUpdateComboTimeLeftWithValue:(float)value;
- (void)gamePlayLayerNeedHideComboBar:(CSSinglePlayerGamePlayLayer *)gamePlayLayer;
- (void)gamePlayLayerNeedShowComboBar:(CSSinglePlayerGamePlayLayer *)gamePlayLayer;
- (void)gamePlayLayer:(CSSinglePlayerGamePlayLayer *)gamePlayLayer needUpdateScoreWithScore:(NSInteger)score;
- (void)gamePlayLayer:(CSSinglePlayerGamePlayLayer *)gamePlayLayer needUpdateLevelWithLevel:(NSInteger)level;
- (void)gamePlayLayer:(CSSinglePlayerGamePlayLayer *)gamePlayLayer needUpdateComboLevelWithLevel:(NSInteger)level;
- (void)gamePlayLayer:(CSSinglePlayerGamePlayLayer *)gamePlayLayer needUpdateCountHintWithNumber:(NSInteger)countHint;
- (void)gamePlayLayer:(CSSinglePlayerGamePlayLayer *)gamePlayLayer needUpdateCountRandomWithNumber:(NSInteger)countRandom;
- (void)gamePlayLayer:(CSSinglePlayerGamePlayLayer *)gamePlayLayer needUpdateCountAddTimeWithNumber:(NSInteger)countAddTime;


@end