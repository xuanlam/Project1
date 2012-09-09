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

- (id)init {
    self = [super init];
    if (self) {
        SinglePlayerGameBackgroundLayer *backgroundLayer = [SinglePlayerGameBackgroundLayer node];
        [self addChild:backgroundLayer z:0];
        
        self.gamePlayLayer = [SinglePlayerGamePlayLayer node];
        _gamePlayLayer.delegate = self;
        [self addChild:_gamePlayLayer z:1];
        
        self.effectLayer = [EffectLayer node];
        [self addChild:_effectLayer z:2];
        
        SinglePlayerGameInterfaceLayer *interfaceLayer = [SinglePlayerGameInterfaceLayer node];
        interfaceLayer.delegate = self;
        [self addChild:interfaceLayer z:3];
    }
    return self;
}


#pragma mark - gamePlayLayerDelegate

- (void)gamePlayLayerNeedDrawLine:(SinglePlayerGamePlayLayer *)gamePlayLayer withPoints:(NSArray *)points andDirections:(NSArray *)directions {
    [_effectLayer drawLineWithPoints:points andDirections:directions];
}


#pragma mark - SinglePlayerGameInterfaceLayer

- (void)gameInterfaceDidSelectHintButton:(SinglePlayerGameInterfaceLayer *)gameInterface {
    [_gamePlayLayer showHint];
}

- (void)gameInterfaceDidSelectRandomButton:(SinglePlayerGameInterfaceLayer *)gameInterface {
    [_gamePlayLayer randomMap];
}

@end
