//
//  SinglePlayerGameInterfaceLayer.m
//  Pikachu
//
//  Created by Xuan Lam on 8/8/12.
//
//
#define PKCTIMEBAR_WIDTH 345.0f
#define PKCCOMBO_TIMEBAR_WIDTH 302.0f
#define PKCTIMEBAR_POSITION CGPointMake(338.0f, 728.0f)
#define PKCCOMBOBAR_POSITION CGPointMake(308.f, 682.0f)

#import "CSSinglePlayerGameInterfaceLayer.h"
#import "CSUserInfo.h"
#import "CSPauseScene.h"

@interface CSSinglePlayerGameInterfaceLayer ()

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

@implementation CSSinglePlayerGameInterfaceLayer

- (void)setUpInterface {
    
    //Button Hint & Random & Add 30s Button
    CCMenuItemImage *button = [CCMenuItemImage itemWithNormalImage:@"buttonHint-Normal.png" selectedImage:@"buttonHint-Normal.png" disabledImage:@"buttonHint-Normal.png" target:self selector:@selector(buttonHintPressed)];
    button.scale = CC_CONTENT_SCALE_FACTOR()/2;
    CCMenu *hintButton = [CCMenu menuWithItems:button, nil];
    hintButton.position = ccp(991.0f, 92.0f);
    [self addChild:hintButton];
    
    CCMenuItemImage *button2 = [CCMenuItemImage itemWithNormalImage:@"buttonRandom-Normal.png" selectedImage:@"buttonRandom-Normal.png" disabledImage:@"buttonRandom-Normal.png" target:self selector:@selector(buttonRandomPressed)];
    button2.scale = CC_CONTENT_SCALE_FACTOR()/2;
    CCMenu *randomButton = [CCMenu menuWithItems:button2, nil];
    randomButton.position = ccp(991.0f, 180.0f);
    [self addChild:randomButton];
    
    CCMenuItemImage *button3 = [CCMenuItemImage itemWithNormalImage:@"button30s.png" selectedImage:@"button30s.png" disabledImage:@"button30s.png" target:self selector:@selector(buttonAddTimePressed)];
    button3.scale = CC_CONTENT_SCALE_FACTOR()/2;
    CCMenu *add30sButton = [CCMenu menuWithItems:button3, nil];
    add30sButton.position = ccp(991.0f, 278.0f);
    [self addChild:add30sButton];
    
    // Game buttons
    // Help button
    [self addButtonAtLocation:ccp(985, 560) withImageName:@"inGameHelpButton.png" target:self selector:@selector(buttonInfoPressed)];
    // Settings Button
    [self addButtonAtLocation:ccp(985, 483) withImageName:@"inGameSettingsButton.png" target:self selector:@selector(buttonSettingsPressed)];
    // Pause button
    [self addButtonAtLocation:ccp(985, 414) withImageName:@"inGamePauseButton.png" target:self selector:@selector(buttonPausePressed)];
    
    // add Label under Hint & Random & Add 30s Button    
    _countHintLabel = [[CCLabelTTF alloc]initWithString:[NSString stringWithFormat:@"%d", [CSUserInfo numberOfHintCount]] fontName:@"PokemonNormal" fontSize:24];
    _countHintLabel.position = CGPointMake(hintButton.position.x, hintButton.position.y - 25.0f);
    [self addChild:_countHintLabel];
    
    _countRandomLabel = [[CCLabelTTF alloc]initWithString:[NSString stringWithFormat:@"%d", [CSUserInfo numberOfRandomCount]] fontName:@"PokemonNormal" fontSize:24];
    _countRandomLabel.position = CGPointMake(randomButton.position.x, randomButton.position.y - 25.0f);
    [self addChild:_countRandomLabel];

    _countAddTimeLabel = [[CCLabelTTF alloc]initWithString:[NSString stringWithFormat:@"%d", [CSUserInfo numberOfAddTimeCount]] fontName:@"PokemonNormal" fontSize:24];
    _countAddTimeLabel.position = CGPointMake(add30sButton.position.x, add30sButton.position.y - 25.0f);
    [self addChild:_countAddTimeLabel];
    
    //Label
    self.levelLabel = [[CCLabelTTF alloc] initWithString:@"0" fontName:@"PokemonNormal" fontSize:24];
    _levelLabel.horizontalAlignment = CCTextAlignmentRight;
    _levelLabel.position = CGPointMake(213.0f, 704.0f);
    _levelLabel.color = ccBLACK;
    [self addChild:_levelLabel];
    
    self.scoreLabel = [[CCLabelTTF alloc] initWithString:@"0" fontName:@"PokemonNormal" fontSize:24];
    _scoreLabel.anchorPoint = CGPointMake(1.0f, 0.5f);
    _scoreLabel.horizontalAlignment = CCTextAlignmentRight;
    _scoreLabel.position = CGPointMake(950.0f, 675.0f);
    [self addChild:_scoreLabel];
    
    //Time bar
    CCSprite *backgroundTimeBarLeft = [CCSprite spriteWithFile:@"bgTime_left.png"];
    backgroundTimeBarLeft.position = PKCTIMEBAR_POSITION;
    [backgroundTimeBarLeft setAnchorPoint:ccp(0, 0.5)];
    [self addChild:backgroundTimeBarLeft];

    self.timeBarLeft = [CCSprite spriteWithFile:@"bar_time_left.png"];
    _timeBarLeft.position = PKCTIMEBAR_POSITION;
    [_timeBarLeft setAnchorPoint:ccp(0, 0.5)];
    [self addChild:_timeBarLeft];
    
    CCSprite *backgroundTimeBarCenter = [CCSprite spriteWithFile:@"bgTime_center.png"];
    backgroundTimeBarCenter.position = ccp(_timeBarLeft.position.x + _timeBarLeft.boundingBox.size.width, PKCTIMEBAR_POSITION.y);
    [backgroundTimeBarCenter setAnchorPoint:ccp(0, 0.5)];
    backgroundTimeBarCenter.scaleX = PKCTIMEBAR_WIDTH * [UIScreen mainScreen].scale;
    [self addChild:backgroundTimeBarCenter];
    
    self.timeBar = [CCSprite spriteWithFile:@"bar_time_center.png"];
    _timeBar.position = ccp(_timeBarLeft.position.x + _timeBarLeft.boundingBox.size.width, PKCTIMEBAR_POSITION.y);
    [_timeBar setAnchorPoint:ccp(0, 0.5)];
    [self addChild:_timeBar];
    
    CCSprite *backgroundTimeBarRight = [CCSprite spriteWithFile:@"bgTime_right.png"];
    backgroundTimeBarRight.position = ccp(backgroundTimeBarCenter.position.x + backgroundTimeBarCenter.boundingBox.size.width, PKCTIMEBAR_POSITION.y);
    [backgroundTimeBarRight setAnchorPoint:ccp(0, 0.5)];
    [self addChild:backgroundTimeBarRight];
    
    self.timeBarRight = [CCSprite spriteWithFile:@"bar_time_right.png"];
    _timeBarRight.position = ccp(backgroundTimeBarCenter.position.x + backgroundTimeBarCenter.boundingBox.size.width, PKCTIMEBAR_POSITION.y);
    [_timeBarRight setAnchorPoint:ccp(0, 0.5)];
    [self addChild:_timeBarRight];
        
    [self updateTimeBarWithValue:1.0f];
    
    //Combo timebar
    self.backgroundComboTimeBarLeft = [CCSprite spriteWithFile:@"bgTime_left.png"];
    _backgroundComboTimeBarLeft.position = PKCCOMBOBAR_POSITION;
    [_backgroundComboTimeBarLeft setAnchorPoint:ccp(0, 0.5)];
    [self addChild:_backgroundComboTimeBarLeft];
    
    self.backgroundComboTimeBarCenter = [CCSprite spriteWithFile:@"bgTime_center.png"];
    _backgroundComboTimeBarCenter.position = ccp(_backgroundComboTimeBarLeft.position.x + _backgroundComboTimeBarLeft.boundingBox.size.width, PKCCOMBOBAR_POSITION.y);
    [_backgroundComboTimeBarCenter setAnchorPoint:ccp(0, 0.5)];
    _backgroundComboTimeBarCenter.scaleX = PKCCOMBO_TIMEBAR_WIDTH * [UIScreen mainScreen].scale;
    [self addChild:_backgroundComboTimeBarCenter];

    self.backgroundComboTimeBarRight = [CCSprite spriteWithFile:@"bgTime_right.png"];
    _backgroundComboTimeBarRight.position = ccp(_backgroundComboTimeBarCenter.position.x + _backgroundComboTimeBarCenter.boundingBox.size.width, PKCCOMBOBAR_POSITION.y);
    [_backgroundComboTimeBarRight setAnchorPoint:ccp(0, 0.5)];
    [self addChild:_backgroundComboTimeBarRight];
    
    self.comboTimeBarLeft = [CCSprite spriteWithFile:@"bar_time_left.png"];
    _comboTimeBarLeft.position = PKCCOMBOBAR_POSITION;
    [_comboTimeBarLeft setAnchorPoint:ccp(0, 0.5)];
    [self addChild:_comboTimeBarLeft];
    
    self.comboTimeBar = [CCSprite spriteWithFile:@"bar_time_center.png"];
    _comboTimeBar.position = ccp(_backgroundComboTimeBarLeft.position.x + _backgroundComboTimeBarLeft.boundingBox.size.width, PKCCOMBOBAR_POSITION.y);
    [_comboTimeBar setAnchorPoint:ccp(0, 0.5)];
    [self addChild:_comboTimeBar];
    
    self.comboTimeBarRight = [CCSprite spriteWithFile:@"bar_time_right.png"];
    _comboTimeBarRight.position = ccp(_backgroundComboTimeBarCenter.position.x + _backgroundComboTimeBarCenter.boundingBox.size.width, PKCCOMBOBAR_POSITION.y);
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


#pragma mark - Handle Buttons

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

- (void)buttonInfoPressed {
    
}

- (void)buttonPausePressed {
    [[CCDirector sharedDirector] pushScene:[CSPauseScene node]];
}

- (void)buttonSettingsPressed {
    
}


#pragma mark - Actions

- (void)updateTimeBarWithValue:(float)value {
    float width = value * PKCTIMEBAR_WIDTH * [UIScreen mainScreen].scale;
    [_timeBar setScaleX:width];
    _timeBarRight.position = ccp(_timeBar.position.x + _timeBar.boundingBox.size.width, PKCTIMEBAR_POSITION.y);
}

- (void)updateComboTimeBarWithValue:(float)value {
    
    NSLog(@"%f", [UIScreen mainScreen].scale);
    
    float width = value * PKCCOMBO_TIMEBAR_WIDTH * [UIScreen mainScreen].scale;
    [_comboTimeBar setScaleX:width];
    _comboTimeBarRight.position = ccp(_comboTimeBar.position.x + _comboTimeBar.boundingBox.size.width, PKCCOMBOBAR_POSITION.y);

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
    _scoreLabel.string = [NSString stringWithFormat:@"%d", score];
}

- (void)setLevel:(NSInteger)level {
    _levelLabel.string = [NSString stringWithFormat:@"%d", level];
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


#pragma mark - Getters


#pragma mark - Helper

- (void)addButtonAtLocation:(CGPoint)location withImageName:(NSString *)imageName target:(id)target selector:(SEL)selector {
    CCMenuItemImage *item = [CCMenuItemImage itemWithNormalImage:imageName selectedImage:imageName disabledImage:imageName target:target selector:selector];
    item.scale = CC_CONTENT_SCALE_FACTOR()/2;
    CCMenu *button = [CCMenu menuWithItems:item, nil];
    button.position = location;
    [self addChild:button];
}

@end
