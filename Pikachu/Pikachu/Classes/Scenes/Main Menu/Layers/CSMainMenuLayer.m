//
//  MainMenuLayer.m
//  Pikachu
//
//  Created by Xuan Lam on 9/15/12.
//
//

#import "CSMainMenuLayer.h"
#import "CSGameManager.h"
#import "CSStoreMenuView.h"
#import "CSUserInfo.h"

@implementation CSMainMenuLayer

//- (void)onEnter {
//    [[MyGameCenter sharedMyGameCenter]authenticateLocalPlayer];
//}

- (id)init {
    self = [super init];
    if (self) {
        // add check Game Center account
//        [[MyGameCenter sharedMyGameCenter]authenticateLocalPlayer];
        
        CCSprite *background = [CCSprite spriteWithFile:@"MainMenuBackground.png"];
        [background setAnchorPoint:CGPointZero];
        background.scale = CC_CONTENT_SCALE_FACTOR()/2;
        
        [self addChild:background];
        
        // play button
        CCMenuItemImage *button = [CCMenuItemImage itemWithNormalImage:@"menu_button_play.png" selectedImage:@"menu_button_play.png" disabledImage:@"menu_button_play.png" target:self selector:@selector(buttonPlaySender)];
        CCMenu *playButton = [CCMenu menuWithItems:button, nil];
        playButton.position = ccp(522.0f, 265.0f);
        [self addChild:playButton];
        
        
        // more button
        CCMenuItemImage *button2 = [CCMenuItemImage itemWithNormalImage:@"menu_button_more.png" selectedImage:@"menu_button_more.png" disabledImage:@"menu_button_more.png" target:self selector:@selector(buttonMoreSender)];
        CCMenu *moreButton = [CCMenu menuWithItems:button2, nil];
        moreButton.position = ccp(522.0f, 160.0f);
        [self addChild:moreButton];
        
        
        // help button
        CCMenuItemImage *button3 = [CCMenuItemImage itemWithNormalImage:@"helpButton.png" selectedImage:@"helpButton.png" disabledImage:@"helpButton.png" target:self selector:@selector(helpButtonDidPress)];
        button3.scale = CC_CONTENT_SCALE_FACTOR()/2;
        CCMenu *helpButton = [CCMenu menuWithItems:button3, nil];
        helpButton.position = ccp(974.0f, 718.0f);
        [self addChild:helpButton];
        
        // game center button
        CCMenuItemImage *button4 = [CCMenuItemImage itemWithNormalImage:@"gameCenterButton.png" selectedImage:@"gameCenterButton.png" disabledImage:@"gameCenterButton.png" target:self selector:@selector(gameCenterButtonDidPress)];
        button4.scale = CC_CONTENT_SCALE_FACTOR()/2;
        CCMenu *gameCenterButton = [CCMenu menuWithItems:button4, nil];
        gameCenterButton.position = ccp(50.0f, 718.0f);
        [self addChild:gameCenterButton];
        
        
        // music button
        CCMenuItemImage *musicOnButton = [CCMenuItemImage itemWithNormalImage:@"musicOnButton.png" selectedImage:@"musicOnButton.png" disabledImage:@"musicOnButton.png" target:nil selector:nil];
        
        CCMenuItemImage *musicOffButton = [CCMenuItemImage itemWithNormalImage:@"musicOffButton.png" selectedImage:@"musicOffButton.png" disabledImage:@"musicOffButton.png" target:nil selector:nil];
        CCMenuItemToggle *musicEnableToggleItem = [CCMenuItemToggle itemWithTarget:self
                                                               selector:@selector(musicButtonDidPress:) items:musicOnButton, musicOffButton, nil];
        musicEnableToggleItem.scale = CC_CONTENT_SCALE_FACTOR()/2;

        BOOL musicEnable = [CSUserInfo enableMusic];
        [musicEnableToggleItem setSelectedIndex:musicEnable ? 0 : 1];
        
        CCMenu *musicButton = [CCMenu menuWithItems:musicEnableToggleItem, nil];
        musicButton.position = ccp(50.0f, 638.0f);
        [self addChild:musicButton];
        
        
        // sound button
        CCMenuItemImage *soundOnButton = [CCMenuItemImage itemWithNormalImage:@"soundOnButton.png" selectedImage:@"soundOnButton.png" disabledImage:@"soundOnButton.png" target:nil selector:nil];
        
        CCMenuItemImage *soundOffButton = [CCMenuItemImage itemWithNormalImage:@"soundOffButton.png" selectedImage:@"soundOffButton.png" disabledImage:@"soundOffButton.png" target:nil selector:nil];
        CCMenuItemToggle *soundEnableToggleItem = [CCMenuItemToggle itemWithTarget:self
                                                                          selector:@selector(soundButtonDidPress:) items:soundOnButton, soundOffButton, nil];
        soundEnableToggleItem.scale = CC_CONTENT_SCALE_FACTOR()/2;

        BOOL soundEnable = [CSUserInfo enableSound];
        [soundEnableToggleItem setSelectedIndex:soundEnable ? 0 : 1];
        
        CCMenu *soundButton = [CCMenu menuWithItems:soundEnableToggleItem, nil];
        soundButton.position = ccp(50.0f, 558.0f);
        [self addChild:soundButton];
        
        
        // Pikachu
        CCSprite *pikachu = [[CCSprite alloc] initWithFile:@"pikachu0.png"];
        pikachu.scale = CC_CONTENT_SCALE_FACTOR()/2;
        pikachu.anchorPoint = CGPointZero;
        pikachu.position = CGPointZero;
        [self addChild:pikachu];
        
        CCAnimation *animation = [CCAnimation animation];
        for (int i = 0; i < 2; i++) {
            [animation addFrameWithFilename: [NSString stringWithFormat:@"pikachu%d.png", i]];
        }
        
        CCAnimate *action = [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO];
		CCRepeatForever *repeat = [CCRepeatForever actionWithAction:action];

        [pikachu runAction:repeat];

        
        // Dragon
        // Blue
        CCSprite *blueDragon = [[CCSprite alloc] initWithFile:@"blueDragon.png"];
        blueDragon.scale = CC_CONTENT_SCALE_FACTOR()/2;
        blueDragon.anchorPoint = ccp(1.0f, 0.0f);
        blueDragon.position = ccp(900.0f, 0.0f);
        [self addChild:blueDragon];
        
        id blueDragonMoveAction = [CCMoveTo actionWithDuration:1.0f position:ccp(900.0f, -20.0f)];
        id blueDragonMoveAction2 = [CCMoveTo actionWithDuration:1.0f position:ccp(900.0f, 0.0f)];
        CCSequence *blueDragonMoving = [CCSequence actions:blueDragonMoveAction, blueDragonMoveAction2, nil];
        CCRepeatForever *blueDragonMoveForever = [CCRepeatForever actionWithAction:blueDragonMoving];
        [blueDragon runAction:blueDragonMoveForever];
        
        // Red
        CCSprite *redDragon = [[CCSprite alloc] initWithFile:@"redDragon.png"];
        redDragon.scale = CC_CONTENT_SCALE_FACTOR()/2;
        redDragon.anchorPoint = ccp(1.0f, 0.0f);
        redDragon.position = ccp(1024.0f, -20.0f);
        [self addChild:redDragon];
        
        id moveAction = [CCMoveTo actionWithDuration:1.0f position:ccp(1024.0f, 0.0f)];
        id moveAction2 = [CCMoveTo actionWithDuration:1.0f position:ccp(1024.0f, -20.0f)];
        CCSequence *redDragonMoving = [CCSequence actions:moveAction, moveAction2, nil];
        CCRepeatForever *moveForever = [CCRepeatForever actionWithAction:redDragonMoving];
        [redDragon runAction:moveForever];

    }
    
    return self;
}

- (void)buttonPlaySender {
    [[CSGameManager sharedGameManager] runSceneWithID:kGameSinglePlayer animation:YES];
}

- (void)buttonMoreSender {
//    CSStoreMenuView *myview=[[CSStoreMenuView alloc] initWithFrame: CGRectMake(0, 0, 1024, 768)];
//    [[[CCDirector sharedDirector] view] addSubview:myview];
//    [myview release];
}

- (void)helpButtonDidPress {
    
}

- (void)gameCenterButtonDidPress {
    
}

- (void)musicButtonDidPress:(CCMenuItemToggle *)sender {
    int selectedIndex = sender.selectedIndex;
    BOOL musicEnbale = selectedIndex == 0 ? YES : NO;
    [CSUserInfo setEnableMusic:musicEnbale];
}

- (void)soundButtonDidPress:(CCMenuItemToggle *)sender {
    int selectedIndex = sender.selectedIndex;
    BOOL soundEnbale = selectedIndex == 0 ? YES : NO;
    [CSUserInfo setEnableSound:soundEnbale];
}


@end
