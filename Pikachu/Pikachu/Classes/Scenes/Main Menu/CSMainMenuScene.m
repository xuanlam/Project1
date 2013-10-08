//
//  MainMenuScene.m
//  Pikachu
//
//  Created by Xuan Lam on 9/15/12.
//
//

#import "CSMainMenuScene.h"
#import "CSMainMenuLayer.h"

@implementation CSMainMenuScene

- (id)init {
    self = [super init];
    if (self) {
        CSMainMenuLayer *mainMenulayer = [CSMainMenuLayer node];
        [self addChild:mainMenulayer];

    }
    return self;
}




@end
