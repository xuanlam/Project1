//
//  StoreMenuLayer.m
//  Pikachu
//
//  Created by Phi Long on 3/31/13.
//
//

#import "StoreMenuLayer.h"

@implementation StoreMenuLayer

- (id)init {
    self = [super init];
    if (self) {
        // add navigation status bar
        CCSprite *statusBar = [CCSprite spriteWithFile:@"background_statusbar.png"];
        statusBar.anchorPoint = ccp(0.0f, 1.0f);
        statusBar.position = ccp(0.0f, 768.0f);
        [self addChild:statusBar];
        
        // add button Back
        CCMenuItemImage *button = [CCMenuItemImage itemWithNormalImage:@"b_0001_button_Back.png" selectedImage:@"b_0000_button_Back_down.png" disabledImage:@"b_0000_button_Back_down.png" target:self selector:@selector(buttonBackSender)];
        CCMenu *backButton = [CCMenu menuWithItems:button, nil];
        backButton.anchorPoint = ccp(0.0f, 1.0f);
        backButton.position = ccp(35.0f, 745.0f);
        [self addChild:backButton];
        
        // add Store Label
        CCLabelTTF *storeLabel = [[CCLabelTTF alloc] initWithString:@" Store" fontName:@"PokemonNormal" fontSize:34];
//        storeLabel.anchorPoint = CGPointMake(0.5f, 1.0f);
//        storeLabel.horizontalAlignment = CCTextAlignmentRight;
        storeLabel.position = CGPointMake(500.0f, 745.0f);
        [self addChild:storeLabel];
        
        // add button Pause -- chua co Image button pause down
        CCMenuItemImage *button2 = [CCMenuItemImage itemWithNormalImage:@"menu_button_pause.png" selectedImage:@"menu_button_pause.png" disabledImage:@"menu_button_pause.png" target:self selector:@selector(buttonPauseSender)];
        CCMenu *pauseButton = [CCMenu menuWithItems:button2, nil];
        pauseButton.anchorPoint = ccp(1.0f, 1.0f);
        pauseButton.position = ccp(1000.0f, 745.0f);
        [self addChild:pauseButton];
        
        // ADD ITEM
        
    }
    
    return self;
}

- (void)buttonBackSender {
    
}

- (void)buttonPauseSender {
    
}

@end
