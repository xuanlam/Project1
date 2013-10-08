//
//  SinglePlayerGameScene.m
//  Pikachu
//
//  Created by Xuan Lam on 8/7/12.
//
//

#import "CSSinglePlayerGameScene.h"
#import "CSSinglePlayerGameBackgroundLayer.h"
#import "CSEffectLayer.h"

@interface CSSinglePlayerGameScene ()

@property (nonatomic, strong) CSEffectLayer *effectLayer;
@property (nonatomic, strong) CSSinglePlayerGamePlayLayer *gamePlayLayer;

@end

@implementation CSSinglePlayerGameScene
@synthesize effectLayer = _effectLayer;
@synthesize gamePlayLayer = _gamePlayLayer;
@synthesize interfaceLayer = _interfaceLayer;

- (id)init {
    self = [super init];
    if (self) {
        CSSinglePlayerGameBackgroundLayer *backgroundLayer = [CSSinglePlayerGameBackgroundLayer node];
        [self addChild:backgroundLayer z:0];
        
        self.interfaceLayer = [CSSinglePlayerGameInterfaceLayer node];
        _interfaceLayer.delegate = self;
        [self addChild:_interfaceLayer z:3];
        
        self.gamePlayLayer = [CSSinglePlayerGamePlayLayer node];
        _gamePlayLayer.delegate = self;
        [self addChild:_gamePlayLayer z:1];
        
        self.effectLayer = [CSEffectLayer node];
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

- (void)gamePlayLayer:(CSSinglePlayerGamePlayLayer *)gamePlayLayer needDrawGuideWithPoints:(NSArray *)points andDirections:(NSArray *)directions onCompletion:(void (^)())completion {
    [_effectLayer drawGuideWithPoints:points andDirections:directions withTimeInterval:0.2f onCompletion:completion];
}

- (void)gamePlayLayer:(CSSinglePlayerGamePlayLayer *)gamePlayLayer needDrawHintWithPoints:(NSArray *)points andDirections:(NSArray *)directions onCompletion:(void (^)())completion {
    
    [_effectLayer drawGuideWithPoints:points andDirections:directions withTimeInterval:0.5f onCompletion:completion];
}

- (void)gamePlayLayer:(CSSinglePlayerGamePlayLayer *)gamePlayLayer needUpdateTimeLeftWithValue:(float)value {
    [_interfaceLayer updateTimeBarWithValue:value];
}

- (void)gamePlayLayer:(CSSinglePlayerGamePlayLayer *)gamePlayLayer needUpdateLevelWithLevel:(NSInteger)level {
    [_interfaceLayer setLevel:level];
}

- (void)gamePlayLayer:(CSSinglePlayerGamePlayLayer *)gamePlayLayer needUpdateScoreWithScore:(NSInteger)score {
    [_interfaceLayer setScore:score];
}

- (void)gamePlayLayer:(CSSinglePlayerGamePlayLayer *)gamePlayLayer needUpdateCountHintWithNumber:(NSInteger)countHint {
    [_interfaceLayer setHint:countHint];
}

- (void)gamePlayLayer:(CSSinglePlayerGamePlayLayer *)gamePlayLayer needUpdateCountRandomWithNumber:(NSInteger)countRandom {
    [_interfaceLayer setRandom:countRandom];
}

- (void)gamePlayLayer:(CSSinglePlayerGamePlayLayer *)gamePlayLayer needUpdateCountAddTimeWithNumber:(NSInteger)countAddTime {
    [_interfaceLayer setAddTimeCount:countAddTime];
}

- (void)gamePlayLayer:(CSSinglePlayerGamePlayLayer *)gamePlayLayer needUpdateComboLevelWithLevel:(NSInteger)level {
    [_interfaceLayer setComboLevel:level];
}

- (void)gamePlayLayerNeedHideComboBar:(CSSinglePlayerGamePlayLayer *)gamePlayLayer {
    [_interfaceLayer hideComboTimeBar];
}

- (void)gamePlayLayerNeedShowComboBar:(CSSinglePlayerGamePlayLayer *)gamePlayLayer {
    [_interfaceLayer showComboTimeBar];
}

- (void)gamePlayLayer:(CSSinglePlayerGamePlayLayer *)gamePlayLayer needUpdateComboTimeLeftWithValue:(float)value {
    [_interfaceLayer updateComboTimeBarWithValue:value];
}

#pragma mark - SinglePlayerGameInterfaceLayer

- (void)gameInterfaceDidSelectHintButton:(CSSinglePlayerGameInterfaceLayer *)gameInterface {
    [_gamePlayLayer showHint];
}

- (void)gameInterfaceDidSelectRandomButton:(CSSinglePlayerGameInterfaceLayer *)gameInterface {
    [_gamePlayLayer randomMap];
}

- (void)gameInterfaceDidSelectAddTimeButton:(CSSinglePlayerGameInterfaceLayer *)gameInterface {
    [_gamePlayLayer addTime];
}

@end
