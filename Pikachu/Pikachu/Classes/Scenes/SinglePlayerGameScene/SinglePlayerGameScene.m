//
//  SinglePlayerGameScene.m
//  Pikachu
//
//  Created by Xuan Lam on 8/7/12.
//
//

#import "SinglePlayerGameScene.h"
#import "SinglePlayerGameBackgroundLayer.h"
#import "EffectLayer.h"

@interface SinglePlayerGameScene ()

@property (nonatomic, strong) EffectLayer *effectLayer;
@property (nonatomic, strong) SinglePlayerGamePlayLayer *gamePlayLayer;

@end

@implementation SinglePlayerGameScene
@synthesize effectLayer = _effectLayer;
@synthesize gamePlayLayer = _gamePlayLayer;
@synthesize interfaceLayer = _interfaceLayer;

- (id)init {
    self = [super init];
    if (self) {
        SinglePlayerGameBackgroundLayer *backgroundLayer = [SinglePlayerGameBackgroundLayer node];
        [self addChild:backgroundLayer z:0];
        
        self.interfaceLayer = [SinglePlayerGameInterfaceLayer node];
        _interfaceLayer.delegate = self;
        [self addChild:_interfaceLayer z:3];
        
        self.gamePlayLayer = [SinglePlayerGamePlayLayer node];
        _gamePlayLayer.delegate = self;
        [self addChild:_gamePlayLayer z:1];
        
        self.effectLayer = [EffectLayer node];
        [self addChild:_effectLayer z:2];
        
    }
    return self;
}


#pragma mark - gamePlayLayerDelegate

//- (void)gamePlayLayerNeedDrawLine:(SinglePlayerGamePlayLayer *)gamePlayLayer withPoints:(NSArray *)points andDirections:(NSArray *)directions {
//    [_effectLayer drawLineWithPoints:points andDirections:directions];
//}
//
//- (void)gamePlayLayerNeedUpdateTimeLeft:(SinglePlayerGamePlayLayer *)gamePlayLayer WithValue:(float)value {
//    [_interfaceLayer updateTimeBarWithValue:value];
//}

- (void)gamePlayLayer:(SinglePlayerGamePlayLayer *)gamePlayLayer needDrawGuideWithPoints:(NSArray *)points andDirections:(NSArray *)directions onCompletion:(void (^)())completion {
    [_effectLayer drawLineWithPoints:points andDirections:directions onCompletion:completion];
}

- (void)gamePlayLayer:(SinglePlayerGamePlayLayer *)gamePlayLayer needUpdateTimeLeftWithValue:(float)value {
    [_interfaceLayer updateTimeBarWithValue:value];
}

- (void)gamePlayLayer:(SinglePlayerGamePlayLayer *)gamePlayLayer needUpdateLevelWithLevel:(NSInteger)level {
    [_interfaceLayer setLevel:level];
}

- (void)gamePlayLayer:(SinglePlayerGamePlayLayer *)gamePlayLayer needUpdateScoreWithScore:(NSInteger)score {
    [_interfaceLayer setScore:score];
}

- (void)gamePlayLayer:(SinglePlayerGamePlayLayer *)gamePlayLayer needUpdateCountHintWithNumber:(NSInteger)countHint {
    [_interfaceLayer setHint:countHint];
}

- (void)gamePlayLayer:(SinglePlayerGamePlayLayer *)gamePlayLayer needUpdateCountRandomWithNumber:(NSInteger)countRandom {
    [_interfaceLayer setRandom:countRandom];
}

- (void)gamePlayLayer:(SinglePlayerGamePlayLayer *)gamePlayLayer needUpdateCountAddTimeWithNumber:(NSInteger)countAddTime {
    [_interfaceLayer setAddTimeCount:countAddTime];
}

- (void)gamePlayLayer:(SinglePlayerGamePlayLayer *)gamePlayLayer needUpdateComboLevelWithLevel:(NSInteger)level {
    [_interfaceLayer setComboLevel:level];
}

- (void)gamePlayLayerNeedHideComboBar:(SinglePlayerGamePlayLayer *)gamePlayLayer {
    [_interfaceLayer hideComboTimeBar];
}

- (void)gamePlayLayerNeedShowComboBar:(SinglePlayerGamePlayLayer *)gamePlayLayer {
    [_interfaceLayer showComboTimeBar];
}

- (void)gamePlayLayer:(SinglePlayerGamePlayLayer *)gamePlayLayer needUpdateComboTimeLeftWithValue:(float)value {
    [_interfaceLayer updateComboTimeBarWithValue:value];
}

#pragma mark - SinglePlayerGameInterfaceLayer

- (void)gameInterfaceDidSelectHintButton:(SinglePlayerGameInterfaceLayer *)gameInterface {
    [_gamePlayLayer showHint];
}

- (void)gameInterfaceDidSelectRandomButton:(SinglePlayerGameInterfaceLayer *)gameInterface {
    [_gamePlayLayer randomMap];
}

- (void)gameInterfaceDidSelectAddTimeButton:(SinglePlayerGameInterfaceLayer *)gameInterface {
    [_gamePlayLayer addTime];
}

@end
