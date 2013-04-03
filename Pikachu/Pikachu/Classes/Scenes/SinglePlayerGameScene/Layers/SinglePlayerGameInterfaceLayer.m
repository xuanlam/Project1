//
//  SinglePlayerGameInterfaceLayer.m
//  Pikachu
//
//  Created by Xuan Lam on 8/8/12.
//
//
#define PKCTIMEBAR_WIDTH 300.0f
#define PKCCOMBO_TIMEBAR_WIDTH 200.0f

#import "SinglePlayerGameInterfaceLayer.h"
#import "PKCUserInfo.h"

@interface SinglePlayerGameInterfaceLayer ()

@property (nonatomic, strong) CCSprite      *timeBar;
@property (nonatomic, strong) CCSprite      *timeBarLeft;
@property (nonatomic, strong) CCSprite      *timeBarRight;

@property (nonatomic, strong) CCSprite      *comboTimeBar;
@property (nonatomic, strong) CCSprite      *backgroundComboTimeBarLeft;
@property (nonatomic, strong) CCSprite      *backgroundComboTimeBarCenter;
@property (nonatomic, strong) CCSprite      *backgroundComboTimeBarRight;
@property (nonatomic, strong) CCSprite      *comboTimeBarLeft;
@property (nonatomic, strong) CCSprite      *comboTimeBarRight;


@property (nonatomic, strong) CCLabelTTF    *levelLabel;
@property (nonatomic, strong) CCLabelTTF    *scoreLabel;
@property (nonatomic, strong) CCLabelTTF    *countHintLabel;
@property (nonatomic, strong) CCLabelTTF    *countRandomLabel;
@property (nonatomic, strong) CCLabelTTF    *countAddTimeLabel;
@property (nonatomic, strong) CCLabelTTF    *comboLevelLabel;

@end

@implementation SinglePlayerGameInterfaceLayer

- (void)setUpInterface {
    
    //Button Hint & Random & Add 30s Button
    CCMenuItemImage *button = [CCMenuItemImage itemWithNormalImage:@"buttonHint-Normal.png" selectedImage:@"buttonHint-Highlighted.png" disabledImage:@"buttonHint-Highlighted.png" target:self selector:@selector(buttonHintPressed)];
    CCMenu *hintButton = [CCMenu menuWithItems:button, nil];
    hintButton.position = ccp(55.0f, 735.0f);
    [self addChild:hintButton];
    
    CCMenuItemImage *button2 = [CCMenuItemImage itemWithNormalImage:@"buttonRandom-Normal.png" selectedImage:@"buttonRandom-Highlighted.png" disabledImage:@"buttonRandom-Highlighted.png" target:self selector:@selector(buttonRandomPressed)];
    CCMenu *randomButton = [CCMenu menuWithItems:button2, nil];
    randomButton.position = ccp(150.0f, 735.0f);
    [self addChild:randomButton];
    
    CCMenuItemImage *button3 = [CCMenuItemImage itemWithNormalImage:@"button30s.png" selectedImage:@"button30s_down.png" disabledImage:@"button30s_down.png" target:self selector:@selector(buttonAddTimePressed)];
    CCMenu *add30sButton = [CCMenu menuWithItems:button3, nil];
    add30sButton.position = ccp(250.0f, 735.0f);
    [self addChild:add30sButton];

    
    // add Label under Hint & Random & Add 30s Button    
    _countHintLabel = [[CCLabelTTF alloc]initWithString:[NSString stringWithFormat:@"%d", [PKCUserInfo numberOfHintCount]] fontName:@"PokemonNormal" fontSize:24];
    _countHintLabel.anchorPoint = CGPointMake(1.0f, 0.5f);
    _countHintLabel.position = CGPointMake(55.0f, 700.0f);
    [self addChild:_countHintLabel];
    
    _countRandomLabel = [[CCLabelTTF alloc]initWithString:[NSString stringWithFormat:@"%d", [PKCUserInfo numberOfRandomCount]] fontName:@"PokemonNormal" fontSize:24];
    _countRandomLabel.anchorPoint = CGPointMake(1.0f, 0.5f);
    _countRandomLabel.position = CGPointMake(150.0f, 700.0f);
    [self addChild:_countRandomLabel];

    _countAddTimeLabel = [[CCLabelTTF alloc]initWithString:[NSString stringWithFormat:@"%d", [PKCUserInfo numberOfAddTimeCount]] fontName:@"PokemonNormal" fontSize:24];
    _countAddTimeLabel.anchorPoint = CGPointMake(1.0f, 0.5f);
    _countAddTimeLabel.position = CGPointMake(250.0f, 700.0f);
    [self addChild:_countAddTimeLabel];

    
    
    //Label
    self.levelLabel = [[CCLabelTTF alloc] initWithString:@"Level: 1" fontName:@"PokemonNormal" fontSize:24];
    _levelLabel.anchorPoint = CGPointMake(1.0f, 0.5f);
    _levelLabel.horizontalAlignment = CCTextAlignmentRight;
    _levelLabel.position = CGPointMake(1010, 720.0f);
    [self addChild:_levelLabel];
    
    self.scoreLabel = [[CCLabelTTF alloc] initWithString:@"Score: 0" fontName:@"PokemonNormal" fontSize:24];
    _scoreLabel.anchorPoint = CGPointMake(1.0f, 0.5f);
    _scoreLabel.horizontalAlignment = CCTextAlignmentRight;
    _scoreLabel.position = CGPointMake(1010, 750.0f);
    [self addChild:_scoreLabel];
    
    //Time bar
    CCSprite *backgroundTimeBarLeft = [CCSprite spriteWithFile:@"bgTime_left.png"];
    backgroundTimeBarLeft.position = ccp(300.0f, 735.0f);
    [backgroundTimeBarLeft setAnchorPoint:ccp(0, 0.5)];
    [self addChild:backgroundTimeBarLeft];

    self.timeBarLeft = [CCSprite spriteWithFile:@"bar_time_left.png"];
    _timeBarLeft.position = ccp(300.0f, 735.0f);
    [_timeBarLeft setAnchorPoint:ccp(0, 0.5)];
    [self addChild:_timeBarLeft];
    
    CCSprite *backgroundTimeBarCenter = [CCSprite spriteWithFile:@"bgTime_center.png"];
    backgroundTimeBarCenter.position = ccp(_timeBarLeft.position.x + _timeBarLeft.boundingBox.size.width, 735.0f);
    [backgroundTimeBarCenter setAnchorPoint:ccp(0, 0.5)];
    backgroundTimeBarCenter.scaleX = PKCTIMEBAR_WIDTH;
    [self addChild:backgroundTimeBarCenter];
    
    self.timeBar = [CCSprite spriteWithFile:@"bar_time_center.png"];
    _timeBar.position = ccp(_timeBarLeft.position.x + _timeBarLeft.boundingBox.size.width, 735.0f);
    [_timeBar setAnchorPoint:ccp(0, 0.5)];
    [self addChild:_timeBar];
    
    CCSprite *backgroundTimeBarRight = [CCSprite spriteWithFile:@"bgTime_right.png"];
    backgroundTimeBarRight.position = ccp(backgroundTimeBarCenter.position.x + backgroundTimeBarCenter.boundingBox.size.width, 735.0f);
    [backgroundTimeBarRight setAnchorPoint:ccp(0, 0.5)];
    [self addChild:backgroundTimeBarRight];
    
    self.timeBarRight = [CCSprite spriteWithFile:@"bar_time_right.png"];
    _timeBarRight.position = ccp(backgroundTimeBarCenter.position.x + backgroundTimeBarCenter.boundingBox.size.width, 735.0f);
    [_timeBarRight setAnchorPoint:ccp(0, 0.5)];
    [self addChild:_timeBarRight];
        
    [self updateTimeBarWithValue:1.0f];
    
    //Combo timebar
    self.backgroundComboTimeBarLeft = [CCSprite spriteWithFile:@"bgTime_left.png"];
    _backgroundComboTimeBarLeft.position = ccp(300.0f, 715.0f);
    [_backgroundComboTimeBarLeft setAnchorPoint:ccp(0, 0.5)];
    [self addChild:_backgroundComboTimeBarLeft];
    
    self.backgroundComboTimeBarCenter = [CCSprite spriteWithFile:@"bgTime_center.png"];
    _backgroundComboTimeBarCenter.position = ccp(_backgroundComboTimeBarLeft.position.x + _backgroundComboTimeBarLeft.boundingBox.size.width, 715.0f);
    [_backgroundComboTimeBarCenter setAnchorPoint:ccp(0, 0.5)];
    _backgroundComboTimeBarCenter.scaleX = PKCCOMBO_TIMEBAR_WIDTH;
    [self addChild:_backgroundComboTimeBarCenter];

    self.backgroundComboTimeBarRight = [CCSprite spriteWithFile:@"bgTime_right.png"];
    _backgroundComboTimeBarRight.position = ccp(_backgroundComboTimeBarCenter.position.x + _backgroundComboTimeBarCenter.boundingBox.size.width, 715.0f);
    [_backgroundComboTimeBarRight setAnchorPoint:ccp(0, 0.5)];
    [self addChild:_backgroundComboTimeBarRight];
    
    self.comboTimeBarLeft = [CCSprite spriteWithFile:@"bar_time_left.png"];
    _comboTimeBarLeft.position = ccp(300.0f, 715.0f);
    [_comboTimeBarLeft setAnchorPoint:ccp(0, 0.5)];
    [self addChild:_comboTimeBarLeft];
    
    self.comboTimeBar = [CCSprite spriteWithFile:@"bar_time_center.png"];
    _comboTimeBar.position = ccp(_backgroundComboTimeBarLeft.position.x + _backgroundComboTimeBarLeft.boundingBox.size.width, 715.0f);
    [_comboTimeBar setAnchorPoint:ccp(0, 0.5)];
    [self addChild:_comboTimeBar];
    
    self.comboTimeBarRight = [CCSprite spriteWithFile:@"bar_time_right.png"];
    _comboTimeBarRight.position = ccp(_backgroundComboTimeBarCenter.position.x + _backgroundComboTimeBarCenter.boundingBox.size.width, 715.0f);
    [_comboTimeBarRight setAnchorPoint:ccp(0, 0.5)];
    [self addChild:_comboTimeBarRight];
        
    self.comboLevelLabel = [[CCLabelTTF alloc] initWithString:@"0" fontName:@"PokemonNormal" fontSize:24.0f];
    _comboLevelLabel.anchorPoint = ccp(0, 0.5);
    _comboLevelLabel.position = ccp(620.0f, 710.0f);
    [self addChild:_comboLevelLabel];
    
    [self hideComboTimeBar];    
}

- (id)init {
    self = [super init];
    if (self) {
        [self setUpInterface];
    }
    return self;
}


#pragma mark - Actions

- (void)buttonHintPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(gameInterfaceDidSelectHintButton:)]) {
        [_delegate gameInterfaceDidSelectHintButton:self];
    }
}

- (void)buttonRandomPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(gameInterfaceDidSelectRandomButton:)]) {
        [_delegate gameInterfaceDidSelectRandomButton:self];
    }
}

- (void)buttonAddTimePressed {
    if (_delegate && [_delegate respondsToSelector:@selector(gameInterfaceDidSelectAddTimeButton:)]) {
        [_delegate gameInterfaceDidSelectAddTimeButton:self];
    }
}

- (void)updateTimeBarWithValue:(float)value {
    float width = value * PKCTIMEBAR_WIDTH;
    [_timeBar setScaleX:width];
    _timeBarRight.position = ccp(_timeBar.position.x + _timeBar.boundingBox.size.width, 735.0f);
}

- (void)updateComboTimeBarWithValue:(float)value {
    
    float width = value * PKCCOMBO_TIMEBAR_WIDTH;
    [_comboTimeBar setScaleX:width];
    _comboTimeBarRight.position = ccp(_comboTimeBar.position.x + _comboTimeBar.boundingBox.size.width, 715.0f);

}

- (void)showComboTimeBar {
    
    [self updateComboTimeBarWithValue:1.0f];
    
    _backgroundComboTimeBarLeft.opacity = 255.0f;
    _backgroundComboTimeBarCenter.opacity = 255.0f;
    _backgroundComboTimeBarRight.opacity = 255.0f;
    
    _comboTimeBar.opacity = 255.0f;
    _comboTimeBarLeft.opacity = 255.0f;
    _comboTimeBarRight.opacity = 255.0f;
    
    _comboLevelLabel.opacity = 255.0f;
}

- (void)hideComboTimeBar {
    _backgroundComboTimeBarLeft.opacity = 0.0f;
    _backgroundComboTimeBarCenter.opacity = 0.0f;
    _backgroundComboTimeBarRight.opacity = 0.0f;
    
    _comboTimeBar.opacity = 0.0f;
    _comboTimeBarLeft.opacity = 0.0f;
    _comboTimeBarRight.opacity = 0.0f;
    
    _comboLevelLabel.opacity = 0.0f;
}

- (void)setScore:(NSInteger)score {
    _scoreLabel.string = [NSString stringWithFormat:@"Score: %d", score];
}

- (void)setLevel:(NSInteger)level {
    _levelLabel.string = [NSString stringWithFormat:@"Level: %d", level];
}

- (void)setRandom:(NSInteger)countRandom {
    _countRandomLabel.string = [NSString stringWithFormat:@"%d", countRandom];
}

- (void)setHint:(NSInteger)countHint {
    _countHintLabel.string = [NSString stringWithFormat:@"%d", countHint];
}

- (void)setAddTimeCount:(NSInteger)addTimeCount {
    _countAddTimeLabel.string = [NSString stringWithFormat:@"%d", addTimeCount];
}

- (void)setComboLevel:(NSInteger)level {    
    _comboLevelLabel.string = [NSString stringWithFormat:@"%d", level];
}

@end
