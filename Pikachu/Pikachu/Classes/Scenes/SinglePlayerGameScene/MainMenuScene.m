//
//  MainMenuScene.m
//  Pikachu
//
//  Created by Xuan Lam on 9/15/12.
//
//

#import "MainMenuScene.h"
#import "MainMenuLayer.h"

@implementation MainMenuScene

- (id)init {
    self = [super init];
    if (self) {
        MainMenuLayer *mainMenulayer = [MainMenuLayer node];
        [self addChild:mainMenulayer];
        
        //test Store Menu Layer
        StoreMenuLayer *storeLayer = [StoreMenuLayer node];
        storeLayer.delegate = self;
        [self addChild:storeLayer];
    }
    return self;
}


#pragma mark - StoreMenuLayerDelegate

- (void)storeMenuLayerDidSelectCloseButton:(StoreMenuLayer *)storeMenuLayer {
    [storeMenuLayer removeFromParentAndCleanup:YES];
}


@end
