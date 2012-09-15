//
//  SinglePlayerGameInterfaceLayer.m
//  Pikachu
//
//  Created by Xuan Lam on 8/8/12.
//
//
#define PKCTIMEBAR_WIDTH 300.0f

#import "SinglePlayerGameInterfaceLayer.h"

@interface SinglePlayerGameInterfaceLayer ()

@property (nonatomic, strong) CCSprite *timeBar;
@property (nonatomic, strong) CCSprite *timeBarLeft;
@property (nonatomic, strong) CCSprite *timeBarRight;

@end

@implementation SinglePlayerGameInterfaceLayer
@synthesize delegate = _delegate;
@synthesize timeBar = _timeBar;
@synthesize timeBarLeft = _timeBarLeft;
@synthesize timeBarRight = _timeBarRight;

- (void)setUpInterface {
    CCMenuItemImage *button = [CCMenuItemImage itemWithNormalImage:@"buttonHint-Normal.png" selectedImage:@"buttonHint-Highlighted.png" disabledImage:@"buttonHint-Highlighted.png" target:self selector:@selector(buttonHintSender)];
    
    CCMenu *hintButton = [CCMenu menuWithItems:button, nil];
    hintButton.position = ccp(55.0f, 735.0f);
    [self addChild:hintButton];
    
    
    CCMenuItemImage *button2 = [CCMenuItemImage itemWithNormalImage:@"buttonRandom-Normal.png" selectedImage:@"buttonRandom-Highlighted.png" disabledImage:@"buttonRandom-Highlighted.png" target:self selector:@selector(buttonRandomSender)];
    
    CCMenu *randomButton = [CCMenu menuWithItems:button2, nil];
    randomButton.position = ccp(150.0f, 735.0f);
    [self addChild:randomButton];
    
    self.timeBarLeft = [CCSprite spriteWithFile:@"bar_time_left.png"];
    _timeBarLeft.position = ccp(300.0f, 735.0f);
    [_timeBarLeft setAnchorPoint:ccp(0, 0.5)];
    [self addChild:_timeBarLeft];
    
    self.timeBar = [CCSprite spriteWithFile:@"bar_time_center.png"];
    _timeBar.position = ccp(_timeBarLeft.position.x + _timeBarLeft.boundingBox.size.width, 735.0f);
    [_timeBar setAnchorPoint:ccp(0, 0.5)];
//    [_timeBar setScaleX:100.0f];
    [self addChild:_timeBar];
    
    self.timeBarRight = [CCSprite spriteWithFile:@"bar_time_right.png"];
    _timeBarRight.position = ccp(_timeBar.position.x + _timeBar.boundingBox.size.width, 735.0f);
    [_timeBarRight setAnchorPoint:ccp(0, 0.5)];
    [self addChild:_timeBarRight];
    
    [self updateTimeBarWithValue:100.0f];
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

- (void)updateTimeBarWithValue:(float)value {
    float width = value * PKCTIMEBAR_WIDTH / 100;
    [_timeBar setScaleX:width];
    _timeBarRight.position = ccp(_timeBar.position.x + _timeBar.boundingBox.size.width, 735.0f);
}

@end
