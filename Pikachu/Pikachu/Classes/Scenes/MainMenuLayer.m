//
//  MainMenuLayer.m
//  Pikachu
//
//  Created by Xuan Lam on 9/15/12.
//
//

#import "MainMenuLayer.h"
#import "GameManager.h"
#import "StoreMenuView.h"

@implementation MainMenuLayer

//- (void)onEnter {
//    [[MyGameCenter sharedMyGameCenter]authenticateLocalPlayer];
//}

- (id)init {
    self = [super init];
    if (self) {
        // add check Game Center account
        [[MyGameCenter sharedMyGameCenter]authenticateLocalPlayer];
        
        CCSprite *background = [CCSprite spriteWithFile:@"MainMenuBackground.jpg"];
        [background setAnchorPoint:CGPointZero];
        background.scale = CC_CONTENT_SCALE_FACTOR();
        [self addChild:background];
        
        CCMenuItemImage *button = [CCMenuItemImage itemWithNormalImage:@"menu_button_play.png" selectedImage:@"menu_button_play_down.png" disabledImage:@"menu_button_play_down.png" target:self selector:@selector(buttonPlaySender)];
        CCMenu *playButton = [CCMenu menuWithItems:button, nil];
        playButton.position = ccp(512.0f, 400.0f);
        [self addChild:playButton];
        
        CCMenuItemImage *button2 = [CCMenuItemImage itemWithNormalImage:@"menu_button_more.png" selectedImage:@"menu_button_more_down.png" disabledImage:@"menu_button_more_down.png" target:self selector:@selector(buttonMoreSender)];
        CCMenu *moreButton = [CCMenu menuWithItems:button2, nil];
        moreButton.position = ccp(512.0f, 300.0f);
        [self addChild:moreButton];
        
    }
    
    return self;
}

- (void)buttonPlaySender {
    [[GameManager sharedGameManager] runSceneWithID:kGameSinglePlayer animation:YES];
}

- (void)buttonMoreSender {
    StoreMenuView *myview=[[StoreMenuView alloc] initWithFrame: CGRectMake(0, 0, 1024, 768)];
    [[[CCDirector sharedDirector] view]addSubview:myview];
    [myview release];
}

@end
