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
        // add shop wood 1
        CCSprite *shopWood1 = [CCSprite spriteWithFile:@"b_0011_Shop_WOOD.png"];
        shopWood1.anchorPoint = ccp(0.0f, 0.0f);
        shopWood1.position = ccp(130.0f, 450.0f);
        [self addChild:shopWood1];
        
        // add list 5 shope piece pack on wood 1
        CCMenuItemImage *pack1 = [CCMenuItemImage itemWithNormalImage:@"b_0009_Shop_Piece_Pack.png" selectedImage:@"b_0009_Shop_Piece_Pack.png" disabledImage:@"b_0009_Shop_Piece_Pack.png" target:self selector:@selector(buttonPack1Sender)];
        CCMenuItemImage *pack2 = [CCMenuItemImage itemWithNormalImage:@"b_0008_Shop_Piece_Pack_Buy.png" selectedImage:@"b_0008_Shop_Piece_Pack_Buy.png" disabledImage:@"b_0008_Shop_Piece_Pack_Buy.png" target:self selector:@selector(buttonPack1Sender)];
        CCMenuItemImage *pack3 = [CCMenuItemImage itemWithNormalImage:@"b_0009_Shop_Piece_Pack.png" selectedImage:@"b_0009_Shop_Piece_Pack.png" disabledImage:@"b_0009_Shop_Piece_Pack.png" target:self selector:@selector(buttonPack1Sender)];
        CCMenuItemImage *pack4 = [CCMenuItemImage itemWithNormalImage:@"b_0009_Shop_Piece_Pack.png" selectedImage:@"b_0009_Shop_Piece_Pack.png" disabledImage:@"b_0009_Shop_Piece_Pack.png" target:self selector:@selector(buttonPack1Sender)];
        CCMenuItemImage *pack5 = [CCMenuItemImage itemWithNormalImage:@"b_0009_Shop_Piece_Pack.png" selectedImage:@"b_0009_Shop_Piece_Pack.png" disabledImage:@"b_0009_Shop_Piece_Pack.png" target:self selector:@selector(buttonPack1Sender)];
        CCMenu *packShop1 = [CCMenu menuWithItems:pack1, pack2, pack3, pack4, pack5, nil];
        [packShop1 alignItemsHorizontallyWithPadding:20];
        packShop1.position = ccp(520.0f, 545.0f);
        [self addChild:packShop1];
        
        // add shop wood 2
        CCSprite *shopWood2 = [CCSprite spriteWithFile:@"b_0011_Shop_WOOD.png"];
        shopWood2.anchorPoint = ccp(0.0f, 0.0f);
        shopWood2.position = ccp(130.0f, 150.0f);
        [self addChild:shopWood2];
        
        // add list 5 shope piece pack on wood 2
        CCMenuItemImage *pack6 = [CCMenuItemImage itemWithNormalImage:@"b_0009_Shop_Piece_Pack.png" selectedImage:@"b_0009_Shop_Piece_Pack.png" disabledImage:@"b_0009_Shop_Piece_Pack.png" target:self selector:@selector(buttonPack2Sender)];
        CCMenuItemImage *pack7 = [CCMenuItemImage itemWithNormalImage:@"b_0008_Shop_Piece_Pack_Buy.png" selectedImage:@"b_0008_Shop_Piece_Pack_Buy.png" disabledImage:@"b_0008_Shop_Piece_Pack_Buy.png" target:self selector:@selector(buttonPack2Sender)];
        CCMenuItemImage *pack8 = [CCMenuItemImage itemWithNormalImage:@"b_0009_Shop_Piece_Pack.png" selectedImage:@"b_0009_Shop_Piece_Pack.png" disabledImage:@"b_0009_Shop_Piece_Pack.png" target:self selector:@selector(buttonPack2Sender)];
        CCMenuItemImage *pack9 = [CCMenuItemImage itemWithNormalImage:@"b_0009_Shop_Piece_Pack.png" selectedImage:@"b_0009_Shop_Piece_Pack.png" disabledImage:@"b_0009_Shop_Piece_Pack.png" target:self selector:@selector(buttonPack2Sender)];
        CCMenuItemImage *pack10 = [CCMenuItemImage itemWithNormalImage:@"b_0009_Shop_Piece_Pack.png" selectedImage:@"b_0009_Shop_Piece_Pack.png" disabledImage:@"b_0009_Shop_Piece_Pack.png" target:self selector:@selector(buttonPack2Sender)];
        CCMenu *packShop2 = [CCMenu menuWithItems:pack6, pack7, pack8, pack9, pack10, nil];
        [packShop2 alignItemsHorizontallyWithPadding:20];
        packShop2.position = ccp(520.0f, 245.0f);
        [self addChild:packShop2];
    }
    
    return self;
}

- (void)buttonBackSender {    
}

- (void)buttonPauseSender {
}

- (void)buttonPack1Sender {
}

- (void)buttonPack2Sender {
}

@end
