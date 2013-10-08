//
//  SinglePlayerGameLayer.m
//  Pikachu
//
//  Created by Xuan Lam on 8/8/12.
//
//
#define PKCBOARD_COLUMN 16
#define PKCBOARD_ROW 8
#define PKCGAME_CELL_SIZE CGSizeMake(60.0f, 76.0f)
#define PKCBOARD_PADDING CGSizeMake(32.0f, 60.0f)
#define kHighScoreLeaderboardCategory @"com.goldangry.pikachuHD.HighScores"

const int GameWidth = 16;
const int GameHeight = 8;

#import "CSSinglePlayerGamePlayLayer.h"
#import "CSGameManager.h"
#import "CSArray2D.h"
#import "SimpleAudioEngine.h"
#import "CSUserInfo.h"

@interface CSSinglePlayerGamePlayLayer()

@property (nonatomic) NSInteger highlightedCellIndex;
@property (nonatomic, strong)   CSArray2D       *CardMatrix;
@property (nonatomic)           int             RemainingCount;
@property (nonatomic)           int             CardColumn;
@property (nonatomic)           int             CardRow;
@property (nonatomic)           int             rCount;
@property (nonatomic, strong)   NSMutableArray  *rX;
@property (nonatomic, strong)   NSMutableArray  *rY;
@property (nonatomic)           int             tCount;
@property (nonatomic, strong)   NSMutableArray  *tX;
@property (nonatomic, strong)   NSMutableArray  *tY;
@property (nonatomic, strong)   NSMutableArray  *d;

@property (nonatomic)           int             level;
@property (nonatomic)           int             score;
@property (nonatomic)           int             countHint;
@property (nonatomic)           int             countRandom;
@property (nonatomic)           int             countRushTime;

@property (nonatomic)           float           timeLeft;
@property (nonatomic)           float           maxTime;
//Combo
@property (nonatomic)           float           comboTimeLeft;
@property (nonatomic)           float           maxComboTimeLeft;
@property (nonatomic)           int             comboLevel;

@property (nonatomic)           int             numberOfCard;

@property (nonatomic)           PKCLogicAlignment logicAlignment;

@end

@implementation CSSinglePlayerGamePlayLayer

- (id)init {
    self = [super init];
    if (self) {
        self.isTouchEnabled = YES;
        self.CardMatrix = [[CSArray2D alloc] initWithRows:GameHeight + 2 andColumn:GameWidth + 2];
        
        
        
        //setup array
        int MAX = (GameHeight + 2) * (GameWidth + 2);
        self.rX = [NSMutableArray arrayWithCapacity:MAX];
        self.rY = [NSMutableArray arrayWithCapacity:MAX];
        self.tX = [NSMutableArray arrayWithCapacity:MAX];
        self.tY = [NSMutableArray arrayWithCapacity:MAX];
        self.d = [NSMutableArray arrayWithCapacity:MAX];        
        
        _level = 1;
        _numberOfCard = 32;
        _score = 0;
        _countHint = [CSUserInfo numberOfHintCount];
        _countRandom = [CSUserInfo numberOfRandomCount];
        _countRushTime = [CSUserInfo numberOfAddTimeCount];
        
        [self setUpNewGameWithLevel:1];
        
        [self schedule:@selector(updateTime) interval:1.0f];
        
        _logicAlignment = PKCLogicAlignmentNone;
        
    }
    return self;
}

- (void)setUpNewGameWithLevel:(NSInteger)level {
    [self removeAllChildrenWithCleanup:YES];
    
#warning This is hack code ~.~
    _timeLeft = 600.0f - (_level-1) * 60.0f;
    
    if (_timeLeft < 300.0f) {
        _timeLeft = 300.0f;
    }
    
    _maxTime = _timeLeft;

    
    int i, j, k;
    
    //Mảng này cho biết mỗi hình xuất hiện mấy lần
    NSMutableArray *CardCount = [NSMutableArray arrayWithCapacity:_numberOfCard];
    for (k = 0; k < _numberOfCard; k++) {
        [CardCount addObject:[NSNumber numberWithInt:4]];
    }//Thiết lập có 4 thẻ hình cho mỗi hình
    
    //đầu tiên các ô của ma trận là trống
    for (i = 0; i < (GameHeight + 2); i++) {
        for (j = 0; j < (GameWidth + 2); j++) {
            [_CardMatrix setObject:[NSNumber numberWithInt:-1] forRow:i atColumn:j];
        }
    }
    
    //duyệt qua từng ô trong ma trận, chọn ngẫu nhiên thẻ hình cho ô đó
    //không xét các ô sát mép nên i: 1->GameHeight; j:1-> GameWidth
    //    NSArray *array = [[GameManager sharedGameManager] pathImages];
    
    for (i = 1; i <= GameHeight; i++) {
        for (j = 1; j <= GameWidth; j++) {
            do {
                k = arc4random() % _numberOfCard;
            } while ([[CardCount objectAtIndex:k] intValue] == 0);    // Nếu CardCount[k] == 0 nghĩa là
            //hình thứ k đã sử dụng hết
            //các thẻ hình, cần tìm k khác.
            [_CardMatrix setObject:[NSNumber numberWithInt:k] forRow:i atColumn:j];    //thẻ hình tại ô i, j là hình thứ k
            
            CSGameCell *cell = [self cellForRow:i atColumn:j];
            
            if (cell) {
                
                [self addChild:cell z:1 tag:cell.cellID];
            }
            
            int cCount = [[CardCount objectAtIndex:k] intValue];
            
            [CardCount replaceObjectAtIndex:k withObject:[NSNumber numberWithInt:cCount - 1]];            //hình thứ k đã dùng 1 thẻ
        }
    }
    
    int MAX = (GameHeight + 2) * (GameWidth + 2);
    
    for (int i = 0; i < MAX; i++) {
        
        [_rX addObject:[NSNull null]];
        [_rY addObject:[NSNull null]];
        [_tX addObject:[NSNull null]];
        [_tY addObject:[NSNull null]];
        [_d addObject:[NSNull null]];
    }
    
    _RemainingCount = GameWidth * GameHeight;  //60 thẻ hình chưa được 'ăn'
    _highlightedCellIndex = NSNotFound;      //Thẻ hình thứ nhất chưa được chọn
    
    NSArray *soundArray = [NSArray arrayWithObjects:@"back1.mp3", @"back2.mp3", @"back3.mp3", nil];
    int randomSoundNumber = arc4random() % [soundArray count];
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:[soundArray objectAtIndex:randomSoundNumber] loop:YES];
}



#pragma mark - Handle Taps

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    
//    CGPoint touchLocation = [touch locationInView: [touch view]];
//    touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
//    touchLocation = [self convertToNodeSpace:touchLocation];

    
    return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
//    CGPoint touchLocation = [touch locationInView: [touch view]];
//    touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
//    touchLocation = [self convertToNodeSpace:touchLocation];
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [touch locationInView: [touch view]];
    touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    touchLocation = [self convertToNodeSpace:touchLocation];
    
    for (CSGameCell *cell in [self children]) {
        if ([cell isContainPoint:touchLocation]) {
            
            if (_highlightedCellIndex == NSNotFound) {
                
                _highlightedCellIndex = cell.cellID;
                _CardColumn = cell.column;
                _CardRow = cell.row;
                
                cell.highlighted = YES;
                
            } else {
                
                if (cell.column != _CardColumn || cell.row != _CardRow) {
                    
                    if ([[_CardMatrix objectForRow:_CardRow atColumn:_CardColumn] intValue] == [[_CardMatrix objectForRow:cell.row atColumn:cell.column] intValue]) {
                        
                        //Find route
                        BOOL canEat = [self checkRouteFormX1:_CardRow Y1:_CardColumn toX2:cell.row Y2:cell.column];
                        
                        //Process Result
                        if (canEat) {
                            
                            [self doCombineForCell:cell];
                            
                        } else {  //nếu không tìm thấy đường đi
                            
                            [self deselectHighlightedCell];

                        }
                        
                    } else {
                        
                        [self deselectHighlightedCell];
                        
                    }
                    
                } else {
                    
                    [self deselectHighlightedCell];
                }
            }
            
            break;
        }
    }
}

- (void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event {
    [self ccTouchEnded:touch withEvent:event];
}

- (void)registerWithTouchDispatcher
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}


#pragma mark - Game Logic

- (BOOL)isBlankCellAtIndex:(CGPoint)index {
    for (CSGameCell *cell in [self children]) {
        if (cell.column == index.x && cell.row == index.y) {
            return NO;
        }
    }
    
    return YES;
}

- (NSInteger)turnCountOfDirection:(NSMutableArray *)direction andCount:(NSInteger)tCount {
    int count = 0;
    
    for (int i = 2; i < tCount; i++)    // duyệt qua các điểm trong đường đi
    {
        if ([[direction objectAtIndex:i - 1] intValue] != [[direction objectAtIndex:i] intValue]) {
            count++;  // nếu hướng khác nhau nghĩa là có rẽ
        }
    }
    return count;
}

- (void)findRouteWithCard1X:(NSInteger)x1 Card1Y:(NSInteger)y1 andCard2X:(NSInteger)x andCard2Y:(NSInteger)y direction:(Direction)direct {
    
    if ((x < 0) || (x > (GameHeight + 1))) return;
    if ((y < 0) || (y > (GameWidth + 1))) return;    // nếu ra khỏi ma trận, thoát
    if ([[_CardMatrix objectForRow:x atColumn:y] intValue] != -1) return;         // không phải ô trống, thoát (1)
    
    [_tX replaceObjectAtIndex:_tCount withObject:[NSNumber numberWithInt:x]];                     // đưa ô [y,x] vào đường đi
    [_tY replaceObjectAtIndex:_tCount withObject:[NSNumber numberWithInt:y]];
    [_d replaceObjectAtIndex:_tCount withObject:[NSNumber numberWithInt:direct]];               // ghi nhận là hướng đi đến ô [y,x]
    
    // nếu rẽ nhiều hơn 2 lần, thoát
    if (([self turnCountOfDirection:_d andCount:_tCount +1]) > 2) return;
    
    _tCount++;
    [_CardMatrix setObject:[NSNumber numberWithInt:-2] forRow:x atColumn:y];             // đánh dấu ô [y,x] đã đi qua
    // lệnh (1) đảm bảo ô đã đi qua sẽ không đi lại nữa
    if (x == x1 && y == y1)       // nếu đã tìm đến vị trí hình thứ nhất
    {
        // kiểm tra xem đường đi mới tìm có ngắn hơn đường đi trong các lần trước?
        if (_tCount < _rCount)
        {
            // nếu ngắn hơn, ghi nhớ lại đường đi này
            _rCount = _tCount;
            
            for (int i = 0; i < _tCount; i++)
            {
                [_rX replaceObjectAtIndex:i withObject:[_tX objectAtIndex:i]];//[i] = tX[i];
                [_rY replaceObjectAtIndex:i withObject:[_tY objectAtIndex:i]];
            }
        }
    } else {
        [self findRouteWithCard1X:x1 Card1Y:y1 andCard2X:x - 1 andCard2Y:y direction:DirectionLeft];
        [self findRouteWithCard1X:x1 Card1Y:y1 andCard2X:x + 1 andCard2Y:y direction:DirectionRight];
        [self findRouteWithCard1X:x1 Card1Y:y1 andCard2X:x andCard2Y:y - 1 direction:DirectionUp];
        [self findRouteWithCard1X:x1 Card1Y:y1 andCard2X:x andCard2Y:y + 1 direction:DirectionDown];
    }
    
    // ô [y,x] đã xét xong, quay lui nên loại ô [y,x] ra khỏi đường đi
    _tCount--;
    // đánh dấu lại là ô [y,x] trống, có thể đi qua lại
    [_CardMatrix setObject:[NSNumber numberWithInt:-1] forRow:x atColumn:y];
}


#pragma mark - Draw

- (void)updateBoard {
    for (int i = 1; i <= GameHeight; i++) {
        for (int j = 1; j <= GameWidth; j++) {
            if ([[_CardMatrix objectForRow:i atColumn:j] intValue] == -1) {
            
                CSGameCell *cell = (CSGameCell *)[self getChildByTag:i * (GameWidth + 2) + j];
                if (cell) {
                    [cell removeFromParentAndCleanup:YES];
                }
            }
        }
    }
    
    switch (_logicAlignment) {
        case PKCLogicAlignmentLeft: {
            
            for (int i = 1; i <= GameHeight; i++) {
                
                for (int j = GameWidth; j > 0; j--) {
                    
                    if ([[_CardMatrix objectForRow:i atColumn:j] intValue] == -1) {
                        
                        for (int k = j; k < GameWidth; k++) {
                            
                            [_CardMatrix setObject:[_CardMatrix objectForRow:i atColumn:k + 1] forRow:i atColumn:k];
                            
                            int cellID = i * (GameWidth + 2) + k + 1;
                            CSGameCell *cell = [self cellForCellID:cellID];
                            
                            if (cell) {
                                cell.position = ccp(cell.position.x - 60.0f, cell.position.y);
                                cell.column -= 1;
                                cell.cellID = cellID - 1;
                                cell.tag = cellID - 1;
                            } else {
                                NSLog(@"");
                            }
                        }
                        
                        [_CardMatrix setObject:[NSNumber numberWithInt:-1] forRow:i atColumn:GameWidth];
                    }
                }
            }

            break;
        }
            
        case PKCLogicAlignmentRight : {
            
            for (int i = 1; i <= GameHeight; i++) {
                
                for (int j = 1; j <= GameWidth; j++) {
                    
                    if ([[_CardMatrix objectForRow:i atColumn:j] intValue] == -1) {
                        
                        for (int k = j; k > 0; k--) {
                            
                            [_CardMatrix setObject:[_CardMatrix objectForRow:i atColumn:k - 1] forRow:i atColumn:k];
                            
                            int cellID = i * (GameWidth + 2) + k - 1;
                            CSGameCell *cell = [self cellForCellID:cellID];
                            
                            if (cell) {
                                cell.position = ccp(cell.position.x + 60.0f, cell.position.y);
                                cell.column += 1;
                                cell.cellID = cellID + 1;
                                cell.tag = cellID + 1;
                            } else {
                                NSLog(@"");
                            }
                        }
                        
                        [_CardMatrix setObject:[NSNumber numberWithInt:-1] forRow:i atColumn:1];
                    }
                }
            }
            
            break;
        }
        
        case PKCLogicAlignmentTop: {
            
            for (int i = 1; i <= GameWidth; i++) {
                
                for (int j = GameHeight; j > 0; j--) {
                    
                    if ([[_CardMatrix objectForRow:j atColumn:i] intValue] == -1) {
                        
                        for (int k = j; k < GameHeight; k++) {
                            
                            [_CardMatrix setObject:[_CardMatrix objectForRow:k + 1 atColumn:i] forRow:k atColumn:i];
                            
                            int cellID = (k + 1) * (GameWidth + 2) + i;
                            CSGameCell *cell = [self cellForCellID:cellID];
                            
                            if (cell) {
                                cell.position = ccp(cell.position.x, cell.position.y - PKCGAME_CELL_SIZE.height);
                                cell.row -= 1;
                                cell.cellID = cellID - GameWidth - 2;
                                cell.tag = cellID - GameWidth - 2;
                            } else {
                                NSLog(@"");
                            }
                        }
                        
                        [_CardMatrix setObject:[NSNumber numberWithInt:-1] forRow:GameHeight atColumn:i];
                    }
                }
            }
            
            break;
        }
            
        case PKCLogicAlignmentBottom: {
            
            for (int i = 1; i <= GameWidth; i++) { //Column
                
                for (int j = 1; j <= GameHeight; j++) { //Row
                    
                    if ([[_CardMatrix objectForRow:j atColumn:i] intValue] == -1) {
                        
                        for (int k = j; k > 0; k--) {
                            
                            [_CardMatrix setObject:[_CardMatrix objectForRow:k - 1 atColumn:i] forRow:k atColumn:i];
                            
                            int cellID = (k - 1) * (GameWidth + 2) + i;
                            CSGameCell *cell = [self cellForCellID:cellID];
                            
                            if (cell) {
                                cell.position = ccp(cell.position.x, cell.position.y + PKCGAME_CELL_SIZE.height);
                                cell.row += 1;
                                cell.cellID = cellID + GameWidth + 2;
                                cell.tag = cellID + GameWidth + 2;
                            } else {
                                NSLog(@"");
                            }
                        }

                        [_CardMatrix setObject:[NSNumber numberWithInt:-1] forRow:1 atColumn:i];
                    }
                }
            }

            
            break;
        }
        default:
            break;
    }
}

- (void)drawLineConnectOnCompletion:(void(^)())completion {
    NSMutableArray *points = [NSMutableArray array];
    
    for (int i = 0; i < _rCount; i ++) {
        CGPoint point = [self pointForCellWithRow:[[_rX objectAtIndex:i] intValue] andColumn:[[_rY objectAtIndex:i] intValue]];
        [points addObject:[NSValue valueWithCGPoint:point]];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(gamePlayLayer:needDrawGuideWithPoints:andDirections:onCompletion:)]) {
        [_delegate gamePlayLayer:self needDrawGuideWithPoints:points andDirections:_d onCompletion:^{
            if (completion) completion();
        }];
    }

    //Play effect sound
    [[SimpleAudioEngine sharedEngine] playEffect:@"choose.wav"];
}

- (void)drawHintOnCompletion:(void(^)())completion {
    NSMutableArray *points = [NSMutableArray array];
    
    for (int i = 0; i < _rCount; i ++) {
        CGPoint point = [self pointForCellWithRow:[[_rX objectAtIndex:i] intValue] andColumn:[[_rY objectAtIndex:i] intValue]];
        [points addObject:[NSValue valueWithCGPoint:point]];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(gamePlayLayer:needDrawHintWithPoints:andDirections:onCompletion:)]) {
        [_delegate gamePlayLayer:self needDrawHintWithPoints:points andDirections:_d onCompletion:completion];
    }
}


#pragma mark - Getters

- (CSGameCell *)cellForRow:(NSInteger)row atColumn:(NSInteger)column {
    
    int cellTag = row * (GameWidth + 2) + column;
    
    CSGameCell *cell = (CSGameCell *)[self getChildByTag:cellTag];
    
    if (!cell) {
        
        NSInteger currentPackIndex = [CSUserInfo currentPacketIndex];
        
        NSArray *array = [[CSGameManager sharedGameManager] pathImagesForPacketIndex:currentPackIndex];
        int type = [[_CardMatrix objectForRow:row atColumn:column] intValue];
        cell = [CSGameCell spriteWithFile:[array objectAtIndex:type]];
        
        CGPoint cellPosition = CGPointMake((column -1 ) * PKCGAME_CELL_SIZE.width + PKCBOARD_PADDING.width, (row - 1) * PKCGAME_CELL_SIZE.height + PKCBOARD_PADDING.height);
        cell.anchorPoint = CGPointZero;
        [cell setPosition:cellPosition];
        cell.cellID = cellTag;
        cell.type = type;
        cell.column = column;
        cell.row = row;
    }
    
    return cell;
}

- (CSGameCell *)cellForCellID:(NSInteger)cellID {
    
    CSGameCell *cell = (CSGameCell *)[self getChildByTag:cellID];
    
    if (cell) {
        
        return cell;
        
    }
    
    return nil;
}


- (CGPoint)pointForCellWithRow:(NSInteger)row andColumn:(NSInteger)column {
    CGPoint location = CGPointMake((column -1 ) * PKCGAME_CELL_SIZE.width + PKCGAME_CELL_SIZE.width/2 + PKCBOARD_PADDING.width, (row - 1) * PKCGAME_CELL_SIZE.height + PKCGAME_CELL_SIZE.height / 2 + PKCBOARD_PADDING.height);
    return location;
}


#pragma mark - Game Logic

- (void)upLevel {

    _level += 1;
    
    _logicAlignment = (_level - 1) % 5;
    
    if (_delegate && [_delegate respondsToSelector:@selector(gamePlayLayer:needUpdateLevelWithLevel:)]) {
        [_delegate gamePlayLayer:self needUpdateLevelWithLevel:_level];
    }
    
    [self setUpNewGameWithLevel:_level];
}

- (void)updateTime {
    
    _timeLeft -= 1.0f;
    
    if (_timeLeft <= 0.0f) {
        [self setUpNewGameWithLevel:_level];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(gamePlayLayer:needUpdateTimeLeftWithValue:)]) {
        [_delegate gamePlayLayer:self needUpdateTimeLeftWithValue:_timeLeft/_maxTime];
    }
}

- (void)doCombineForCell:(CSGameCell *)cell {
    
    cell.highlighted = YES;
    
    //Update matric
    [_CardMatrix setObject:[NSNumber numberWithInt:-1] forRow:cell.row atColumn:cell.column];
    [_CardMatrix setObject:[NSNumber numberWithInt:-1] forRow:_CardRow atColumn:_CardColumn];
        
    // Update score
    _score += 10;
    if (_delegate && [_delegate respondsToSelector:@selector(gamePlayLayer:needUpdateScoreWithScore:)]) {
        [_delegate gamePlayLayer:self needUpdateScoreWithScore:_score];
    }
    
    //Update count
    _RemainingCount -= 2;
    _highlightedCellIndex = NSNotFound;

    [self upComboLevel];
    
    NSLog(@"count: %d",_RemainingCount);
    
    // Draw guide
    [self drawLineConnectOnCompletion:^{
        //Organize board
        [self updateBoard];
        
        if (_RemainingCount <= 0) {
            
            [self upLevel];
#warning hack post high score in here
//            [[MyGameCenter sharedMyGameCenter]submitScore:_score category:kHighScoreLeaderboardCategory];
            
        } else {
            
            if ([self isNoWay]) {
                [self randomMap];
            }
        }
    }];
}

- (void)deselectHighlightedCell {
    
    CSGameCell *highlightedCell = [self cellForCellID:_highlightedCellIndex];
    
    if (highlightedCell) {
        
        highlightedCell.highlighted = NO;
        
    } else {
        
        NSLog(@"There is no highlighted cell");
    }
    
    _highlightedCellIndex = NSNotFound;
}


#pragma mark - Combo logic

- (void)setUpComboTimeForComboLevel:(NSInteger)level {
    _comboTimeLeft = 150.0f - 10.0f;
    
    if (_comboTimeLeft < 30.0f) {
        _comboTimeLeft = 30.0f;
    }
    
    _maxComboTimeLeft = _comboTimeLeft;
}

- (void)updateComboTime {
    _comboTimeLeft -= 1.0f;
    
    if (_comboTimeLeft <= 0.0f) {
        [self doEndCombo];
    } else {
        
        if (_delegate && [_delegate respondsToSelector:@selector(gamePlayLayer:needUpdateComboTimeLeftWithValue:)]) {
            [_delegate gamePlayLayer:self needUpdateComboTimeLeftWithValue:_comboTimeLeft / _maxComboTimeLeft];
        }
    }
}

- (void)upComboLevel {
    
    [self unschedule:@selector(updateComboTime)];
    
    _comboLevel++;
    [self setUpComboTimeForComboLevel:_comboLevel];
    
    [self schedule:@selector(updateComboTime) interval:1.0f/30.0f];
    
    if (_delegate && [_delegate respondsToSelector:@selector(gamePlayLayerNeedShowComboBar:)]) {
        [_delegate gamePlayLayerNeedShowComboBar:self];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(gamePlayLayer:needUpdateComboLevelWithLevel:)]) {
        [_delegate gamePlayLayer:self needUpdateComboLevelWithLevel:_comboLevel];
    }

}

- (void)doEndCombo {
    _comboLevel = 0;
    _comboTimeLeft = 0.0f;
    
    [self unschedule:@selector(updateComboTime)];
    
    if (_delegate && [_delegate respondsToSelector:@selector(gamePlayLayerNeedHideComboBar:)]) {
        [_delegate gamePlayLayerNeedHideComboBar:self];
    }
}


#pragma mark - Power Up

- (void)showHint {
    
    if ([self isNoWay] || _countHint <= 0) {
        
        [[SimpleAudioEngine sharedEngine]playEffect:@"lose.mp3"];
        return;
        
    } else {
        
        [self drawHintOnCompletion:nil];
        
        _countHint -= 1;
        
        [CSUserInfo setNumberOfHintCount:_countHint];
        
        if (_delegate && [_delegate respondsToSelector:@selector(gamePlayLayer:needUpdateCountHintWithNumber:)]) {
            [_delegate gamePlayLayer:self needUpdateCountHintWithNumber:_countHint];
        }
        [[SimpleAudioEngine sharedEngine]playEffect:@"disappear1.wav"];
    }
}

- (void)randomMap {
    
    if (_countRandom > 0) {
        
        _countRandom--;
        [CSUserInfo setNumberOfRandomCount:_countRandom];
        
        if (_delegate && [_delegate respondsToSelector:@selector(gamePlayLayer:needUpdateCountRandomWithNumber:)]) {
            [_delegate gamePlayLayer:self needUpdateCountRandomWithNumber:_countRandom];
        }
        
        [self removeAllChildrenWithCleanup:YES];
        
        NSMutableArray *CardCount = [NSMutableArray arrayWithCapacity:_numberOfCard];
        for (int type = 0; type < _numberOfCard; type++) {
            int count = 0;
            for (int i = 1; i <= GameHeight; i++) {
                for (int j = 1; j <= GameWidth; j++) {
                    if ([[_CardMatrix objectForRow:i atColumn:j] intValue] == type) {
                        count++;
                    }
                }
            }
            
            [CardCount addObject:[NSNumber numberWithInt:count]];
        }
        
        for (int l = 1; l <= GameHeight; l++) {
            for (int h = 1; h <= GameWidth; h++)
            {
                if ([[_CardMatrix objectForRow:l atColumn:h] intValue] != -1) {
                    int k;
                    
                    do
                    {
                        k = arc4random() % _numberOfCard;
                    } while ([[CardCount objectAtIndex:k] intValue] == 0);    // Nếu CardCount[k] == 0 nghĩa là
                    //hình thứ k đã sử dụng hết
                    //các thẻ hình, cần tìm k khác.
                    [_CardMatrix setObject:[NSNumber numberWithInt:k] forRow:l atColumn:h];    //thẻ hình tại ô i, j là hình thứ k
                    
                    CSGameCell *cell = [self cellForRow:l atColumn:h];
                    if (cell) {
                        [self addChild:cell z:1 tag:cell.cellID];
                    }
                    
                    int cCount = [[CardCount objectAtIndex:k] intValue];
                    
                    [CardCount replaceObjectAtIndex:k withObject:[NSNumber numberWithInt:cCount - 1]];                   //hình thứ k đã dùng 1 thẻ
                    
                }
            }
        }
        [[SimpleAudioEngine sharedEngine]playEffect:@"clean.wav"];
    }
    else {
        [[SimpleAudioEngine sharedEngine]playEffect:@"lose.mp3"];
        return;
    }
}

- (void)addTime {
    
    if (_countRushTime > 0 && _timeLeft <= _maxTime - 30.0f) {
        
        _countRushTime--;
        [CSUserInfo setNumberOfAddTimeCount:_countRushTime];
        
        _timeLeft += 30.0f;
        
        if (_delegate && [_delegate respondsToSelector:@selector(gamePlayLayer:needUpdateCountAddTimeWithNumber:)]) {
            [_delegate gamePlayLayer:self needUpdateCountAddTimeWithNumber:_countRushTime];
        }
        
    }
}


#pragma mark - Support Logic Methods

- (BOOL)isNoWay {
    
    for (int type = 0; type < _numberOfCard; type++) {
        NSMutableArray *arrayX = [NSMutableArray array];
        NSMutableArray *arrayY = [NSMutableArray array];
        
        for (int i = 1; i <= GameHeight; i++) {
            for (int j = 1; j <= GameWidth; j++) {
                if (![_CardMatrix objectForRow:i atColumn:j]) {
                    CCLOG(@"aaa");
                }
                if ([[_CardMatrix objectForRow:i atColumn:j] intValue] == type) {
                    [arrayX addObject:[NSNumber numberWithInt:i]];
                    [arrayY addObject:[NSNumber numberWithInt:j]];
                }
            }
        }
        
        if (arrayX.count > 1) {
            for (int k = 0; k < arrayX.count - 1; k++) {
                for (int h = k + 1; h < arrayX.count; h++) {
                    if ([self checkRouteFormX1:[[arrayX objectAtIndex:k] intValue] Y1:[[arrayY objectAtIndex:k] intValue] toX2:[[arrayX objectAtIndex:h] intValue] Y2:[[arrayY objectAtIndex:h] intValue]]) {
                        
                        return NO;
                    }
                }
            }
        }
    }
    
    return YES;
}

- (BOOL)checkRouteFormX1:(NSInteger)x1 Y1:(NSInteger)y1 toX2:(NSInteger)x2 Y2:(NSInteger)y2 {
    int temp = [[_CardMatrix objectForRow:x2 atColumn:y2] intValue];
    
    [_CardMatrix setObject:[NSNumber numberWithInt:-1] forRow:x2 atColumn:y2];
    [_CardMatrix setObject:[NSNumber numberWithInt:-1] forRow:x1 atColumn:y1];
    
    _rCount = INT32_MAX;
    _tCount = 0;
    
    [self findRouteWithCard1X:x1 Card1Y:y1 andCard2X:x2 andCard2Y:y2 direction:DirectionNone];
    
    [_CardMatrix setObject:[NSNumber numberWithInt:temp] forRow:x2 atColumn:y2];
    [_CardMatrix setObject:[NSNumber numberWithInt:temp] forRow:x1 atColumn:y1];
    
    if (_rCount != INT32_MAX) {
        return YES;
    }
    
    return NO;
}


@end
