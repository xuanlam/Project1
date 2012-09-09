//
//  SinglePlayerGameInterfaceLayer.m
//  Pikachu
//
//  Created by Xuan Lam on 8/8/12.
//
//

#import "SinglePlayerGameInterfaceLayer.h"

@implementation SinglePlayerGameInterfaceLayer
@synthesize delegate = _delegate;

- (void)setUpInterface {
    CCMenuItemImage *button = [CCMenuItemImage itemWithNormalImage:@"buttonHint-Normal.png" selectedImage:@"buttonHint-Highlighted.png" disabledImage:@"buttonHint-Highlighted.png" target:self selector:@selector(buttonHintSender)];
    
    CCMenu *hintButton = [CCMenu menuWithItems:button, nil];
    hintButton.position = ccp(55.0f, 735.0f);
    [self addChild:hintButton];
    
    
    CCMenuItemImage *button2 = [CCMenuItemImage itemWithNormalImage:@"buttonRandom-Normal.png" selectedImage:@"buttonRandom-Highlighted.png" disabledImage:@"buttonRandom-Highlighted.png" target:self selector:@selector(buttonRandomSender)];
    
    CCMenu *randomButton = [CCMenu menuWithItems:button2, nil];
    randomButton.position = ccp(150.0f, 735.0f);
    [self addChild:randomButton];
}

- (id)init {
    self = [super init];
    if (self) {
        [self setUpInterface];
    }
    return self;
}


#pragma mark - Actions

- (void)buttonHintSender {
    if (_delegate && [_delegate respondsToSelector:@selector(gameInterfaceDidSelectHintButton:)]) {
        [_delegate gameInterfaceDidSelectHintButton:self];
    }
}

- (void)buttonRandomSender {
    if (_delegate && [_delegate respondsToSelector:@selector(gameInterfaceDidSelectRandomButton:)]) {
        [_delegate gameInterfaceDidSelectRandomButton:self];
    }
}

@end
