//
//  MainMenuScene.m
//  Pikachu
//
//  Created by Xuan Lam on 9/15/12.
//
//

#import "MainMenuScene.h"
#import "MainMenuLayer.h"
#import "StoreMenuLayer.h"

@implementation MainMenuScene

- (id)init {
    self = [super init];
    if (self) {
//        MainMenuLayer *layer = [MainMenuLayer node];
//        [self addChild:layer];
        
        //test Store Menu Layer
        StoreMenuLayer *layer = [StoreMenuLayer node];
        [self addChild:layer];
    }
    return self;
}

@end
