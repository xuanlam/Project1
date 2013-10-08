//
//  SinglePlayerGameInterfaceLayer.h
//  Pikachu
//
//  Created by Xuan Lam on 8/8/12.
//
//

#import "CCLayer.h"

@protocol SinglePlayerGameInterfaceLayerDelegate;

@interface CSSinglePlayerGameInterfaceLayer : CCLayer
@property (nonatomic, unsafe_unretained) id<SinglePlayerGameInterfaceLayerDelegate> delegate;

- (void)updateTimeBarWithValue:(float)value;
- (void)setScore:(NSInteger)score;
- (void)setLevel:(NSInteger)level;
- (void)setRandom:(NSInteger)countRandom;
- (void)setHint:(NSInteger)countHint;
- (void)setAddTimeCount:(NSInteger)addTimeCount;
- (void)setComboLevel:(NSInteger)level;

- (void)updateComboTimeBarWithValue:(CGFloat)value;
- (void)showComboTimeBar;
- (void)hideComboTimeBar;

@end

@protocol SinglePlayerGameInterfaceLayerDelegate <NSObject>

- (void)gameInterfaceDidSelectHintButton:(CSSinglePlayerGameInterfaceLayer *)gameInterface;
- (void)gameInterfaceDidSelectRandomButton:(CSSinglePlayerGameInterfaceLayer *)gameInterface;
- (void)gameInterfaceDidSelectAddTimeButton:(CSSinglePlayerGameInterfaceLayer *)gameInterface;


@end