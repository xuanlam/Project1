//
//  GameBackgroundLayer.m
//  Pikachu
//
//  Created by Xuan Lam on 8/7/12.
//
//

#import "CSSinglePlayerGameBackgroundLayer.h"

@implementation CSSinglePlayerGameBackgroundLayer


#pragma mark - Inits

- (id)init {
    self = [super init];
    if (self) {
        CCSprite *gameBackground = [CCSprite spriteWithFile:@"gameBackground.png"];
        gameBackground.scale = CC_CONTENT_SCALE_FACTOR()/2;
        gameBackground.anchorPoint = CGPointMake(0, 0);
        [gameBackground setPosition:ccp(0, 0)];
        [self addChild:gameBackground];
    }
    return self;
}

@end
