//
//  StoreItemDetailLayer.m
//  Pikachu
//
//  Created by Xuan Lam on 4/1/13.
//
//

#import "StoreItemDetailLayer.h"
#import "cocos2d.h"


@implementation StoreItemDetailLayer

- (id)init {
    self = [super init];
    if (self) {
        CCSprite *background = [CCSprite spriteWithFile:@"MainMenuBackground.jpg"];
        [background setAnchorPoint:CGPointZero];
        background.scale = CC_CONTENT_SCALE_FACTOR();
        [self addChild:background];
    }
    return self;
}

@end
