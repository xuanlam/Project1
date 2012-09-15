//
//  SinglePlayerGameLayer.m
//  Pikachu
//
//  Created by Xuan Lam on 8/8/12.
//
//
#define PKCBOARD_COLUMN 16
#define PKCBOARD_ROW 8

const int CardNo = 32;
const int GameWidth = 16;
const int GameHeight = 8;
const int CardSizeW = 60;
const int CardSizeH = 80;

#import "SinglePlayerGamePlayLayer.h"
#import "GameManager.h"
#import "KSArray2D.h"
#import "SimpleAudioEngine.h"

@interface SinglePlayerGamePlayLayer()

@property (nonatomic) NSInteger highlightedCellIndex;
@property (nonatomic, strong)   KSArray2D       *CardMatrix;
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
@property (nonatomic)           float           timeLeft;

@end

@implementation SinglePlayerGamePlayLayer
@synthesize delegate = _delegate;
@synthesize highlightedCellIndex = _highlightedCellIndex;
@synthesize RemainingCount = _RemainingCount;
@synthesize CardColumn = _CardColumn;
@synthesize CardRow = _CardRow;
@synthesize rCount = _rCount;
@synthesize tX = _tX;
@synthesize tY = _tY;
@synthesize d = _d;

@synthesize level = _level;
@synthesize timeLeft = _timeLeft;

- (id)init {
    self = [super init];
    if (self) {
        self.isTouchEnabled = YES;
        self.CardMatrix = [[KSArray2D alloc] initWithRows:GameHeight + 2 andColumn:GameWidth + 2];
        
        int MAX = (GameHeight + 2) * (GameWidth + 2);
        self.rX = [NSMutableArray arrayWithCapacity:MAX];
        self.rY = [NSMutableArray arrayWithCapacity:MAX];
        self.tX = [NSMutableArray arrayWithCapacity:MAX];
        self.tY = [NSMutableArray arrayWithCapacity:MAX];
        self.d = [NSMutableArray arrayWithCapacity:MAX];        
        
        _timeLeft = 100.0f;
        _level = 1;
        
        [self setUpNewGameWithLevel:1];
        
        [self schedule:@selector(updateTime) interval:1.0f];
    }
    return self;
}

- (void)setUpNewGameWithLevel:(NSInteger)level {
    [self removeAllChildrenWithCleanup:YES];
    _timeLeft = 100.0f;
    
    int i, j, k;
    
    //Mảng này cho biết mỗi hình xuất hiện mấy lần
    NSMutableArray *CardCount = [NSMutableArray arrayWithCapacity:CardNo];
    for (k = 0; k < CardNo; k++) {
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
        for (j = 1; j <= GameWidth; j++)
        {
            do
            {
                k = arc4random() % CardNo;
            } while ([[CardCount objectAtIndex:k] intValue] == 0);    // Nếu CardCount[k] == 0 nghĩa là
            //hình thứ k đã sử dụng hết
            //các thẻ hình, cần tìm k khác.
            [_CardMatrix setObject:[NSNumber numberWithInt:k] forRow:i atColumn:j];    //thẻ hình tại ô i, j là hình thứ k
            
            GameCell *cell = [self cellForRow:i atColumn:j];
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
    _highlightedCellIndex = 0;      //Thẻ hình thứ nhất chưa được chọn
}



#pragma mark - Handle Taps

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [touch locationInView: [touch view]];
    touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    touchLocation = [self convertToNodeSpace:touchLocation];
    
    for (GameCell *cell in [self children]) {
        if ([cell isContainPoint:touchLocation]) {
            
            if (!_highlightedCellIndex) {
                _highlightedCellIndex = 1;
                _CardColumn = cell.column;
                _CardRow = cell.row;
                
            } else {
                if (cell.column != _CardColumn || cell.row != _CardRow) {
                    
                    if ([[_CardMatrix objectForRow:_CardRow atColumn:_CardColumn] intValue] == [[_CardMatrix objectForRow:cell.row atColumn:cell.column] intValue]) {
                        
                        //Find route
                        
                        BOOL canEat = [self checkRouteFormX1:_CardRow Y1:_CardColumn toX2:cell.row Y2:cell.column];
                        
                        //Process Result
                        if (canEat)   
                        {
                            [_CardMatrix setObject:[NSNumber numberWithInt:-1] forRow:cell.row atColumn:cell.column];
                            [_CardMatrix setObject:[NSNumber numberWithInt:-1] forRow:_CardRow atColumn:_CardColumn];
                            
                            _RemainingCount -= 2;
                            _highlightedCellIndex = 0;
                            
                            [self drawLineConnect];
                            [self drawGame];
                            
                            if (_RemainingCount == 0) {
                                _level += 1;
                                [self setUpNewGameWithLevel:_level];
                            }
                        } else {  //nếu không tìm thấy đường đi 
                            _highlightedCellIndex = 0;   // hủy chọn thẻ hình thứ nhất
                            [self drawGame];
                        }
                    } else {
                        _highlightedCellIndex = 0;
                        [self drawGame];
                    }
                    
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
    for (GameCell *cell in [self children]) {
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

- (void)findRouteWithCard1X:(NSInteger)x1 Card1Y:(NSInteger)y1 andCard2X:(NSInteger)x andCard2Y:(NSInteger)y direction:(Direction)direct
{
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

- (void)drawGame {
    for (int i = 1; i <= GameHeight; i++) {
        for (int j = 1; j <= GameWidth; j++) {
            if ([[_CardMatrix objectForRow:i atColumn:j] intValue] == -1) {
                GameCell *cell = (GameCell *)[self getChildByTag:i * (GameWidth + 2) + j];
                if (cell && [cell isKindOfClass:[GameCell class]]) {
                    [cell removeFromParentAndCleanup:YES];
                }
            }
        }
    }
}

- (void)drawLineConnect {
    NSMutableArray *points = [NSMutableArray array];
    
    for (int i = 0; i < _rCount; i ++) {
        CGPoint point = [self pointForCellWithRow:[[_rX objectAtIndex:i] intValue] andColumn:[[_rY objectAtIndex:i] intValue]];
        [points addObject:[NSValue valueWithCGPoint:point]];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(gamePlayLayerNeedDrawLine:withPoints:andDirections:)]) {
        [_delegate gamePlayLayerNeedDrawLine:self withPoints:points andDirections:_d];
    }

    //Play effect sound
    [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];
}


#pragma mark - Getters

- (GameCell *)cellForRow:(NSInteger)row atColumn:(NSInteger)column {
    int cellTag = row * (GameWidth + 2) + column;
    
    GameCell *cell = (GameCell *)[self getChildByTag:cellTag];
    if (!cell) {
        NSArray *array = [[GameManager sharedGameManager] pathImages];
        int type = [[_CardMatrix objectForRow:row atColumn:column] intValue];
        cell = [GameCell spriteWithFile:[array objectAtIndex:type]];
        
        CGPoint cellPosition = CGPointMake((column -1 ) * 60 + 32, (row - 1) * 80 + 65);
        cell.anchorPoint = CGPointZero;
        [cell setPosition:cellPosition];
        cell.cellID = cellTag;
        cell.type = type;
        cell.column = column;
        cell.row = row;
    }
    
    return cell;
}

- (CGPoint)pointForCellWithRow:(NSInteger)row andColumn:(NSInteger)column {
    CGPoint location = CGPointMake((column -1 ) * 60 + 62, (row - 1) * 80 + 105);
    return location;
}


#pragma mark - Actions

- (void)updateTime {
    _timeLeft -= (_level * 2);
    
    if (_timeLeft <= 0.0f) {
        [self setUpNewGameWithLevel:_level];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(gamePlayLayerNeedUpdateTimeLeft:WithValue:)]) {
        [_delegate gamePlayLayerNeedUpdateTimeLeft:self WithValue:_timeLeft];
    }
}

- (void)randomMap {
    [self removeAllChildrenWithCleanup:YES];
    
    NSMutableArray *CardCount = [NSMutableArray arrayWithCapacity:CardNo];
    for (int type = 0; type < CardNo; type++) {
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
                    k = arc4random() % CardNo;
                } while ([[CardCount objectAtIndex:k] intValue] == 0);    // Nếu CardCount[k] == 0 nghĩa là
                //hình thứ k đã sử dụng hết
                //các thẻ hình, cần tìm k khác.
                [_CardMatrix setObject:[NSNumber numberWithInt:k] forRow:l atColumn:h];    //thẻ hình tại ô i, j là hình thứ k
                
                GameCell *cell = [self cellForRow:l atColumn:h];
                if (cell) {
                    [self addChild:cell z:1 tag:cell.cellID];
                }
                
                int cCount = [[CardCount objectAtIndex:k] intValue];
                
                [CardCount replaceObjectAtIndex:k withObject:[NSNumber numberWithInt:cCount - 1]];                   //hình thứ k đã dùng 1 thẻ

            }
        }
    }

}

- (BOOL)isNoWay {
    
    for (int type = 0; type < CardNo; type++) {
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

- (void)showHint {
    if ([self isNoWay]) {
        CCLOG(@"No way");
    } else {
        [self drawLineConnect];
    }
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
