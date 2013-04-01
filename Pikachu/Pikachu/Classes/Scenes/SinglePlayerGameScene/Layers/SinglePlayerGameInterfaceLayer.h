//
//  SinglePlayerGameInterfaceLayer.h
//  Pikachu
//
//  Created by Xuan Lam on 8/8/12.
//
//

#import "CCLayer.h"
#import "cocos2d.h"

@protocol SinglePlayerGameInterfaceLayerDelegate;

@interface SinglePlayerGameInterfaceLayer : CCLayer
@property (nonatomic, unsafe_unretained) id<SinglePlayerGameInterfaceLayerDelegate> delegate;

- (void)updateTimeBarWithValue:(float)value;
- (void)setScore:(NSInteger)score;
- (void)setLevel:(NSInteger)level;
- (void)setRandom:(NSInteger)countRandom;
- (void)setHint:(NSInteger)countHint;
- (void)setAddTimeCount:(NSInteger)addTimeCount;

@end

@protocol SinglePlayerGameInterfaceLayerDelegate <NSObject>

- (void)gameInterfaceDidSelectHintButton:(SinglePlayerGameInterfaceLayer *)gameInterface;
- (void)gameInterfaceDidSelectRandomButton:(SinglePlayerGameInterfaceLayer *)gameInterface;
- (void)gameInterfaceDidSelectAddTimeButton:(SinglePlayerGameInterfaceLayer *)gameInterface;


@end