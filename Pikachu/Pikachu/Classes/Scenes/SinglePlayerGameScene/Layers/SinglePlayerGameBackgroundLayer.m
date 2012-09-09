//
//  GameBackgroundLayer.m
//  Pikachu
//
//  Created by Xuan Lam on 8/7/12.
//
//

#import "SinglePlayerGameBackgroundLayer.h"

@implementation SinglePlayerGameBackgroundLayer


#pragma mark - Inits

- (id)init {
    self = [super init];
    if (self) {
        CCSprite *gameBackground = [CCSprite spriteWithFile:@"background_main.png"];
        gameBackground.anchorPoint = CGPointMake(0, 0);
        [gameBackground setPosition:ccp(0, 0)];
        [self addChild:gameBackground];
    }
    return self;
}

@end
