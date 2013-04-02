//
//  GameCell.m
//  Pikachu
//
//  Created by Xuan Lam on 8/8/12.
//
//

#import "GameCell.h"

@interface GameCell()

@property (nonatomic, strong) CCSprite *highlightedLight;

@end

@implementation GameCell

- (void)setUpCell {
    _highlighted = NO;
    _cellID = -1;
    _type = -1;
    _row = -1;
    _column = -1;
    
    _highlightedLight = [[CCSprite alloc] initWithFile:@"cellHighlightedLight.png"];
    _highlightedLight.opacity = 0.0f;
    _highlightedLight.anchorPoint = CGPointZero;
    _highlightedLight.scale = CC_CONTENT_SCALE_FACTOR() / 2;
    [self addChild:_highlightedLight];
}

- (id)init {
    self = [super init];
    if (self) {
        //
        [self setUpCell];
    }
    return self;
}

- (id)initWithFile:(NSString *)filename {
    self = [super initWithFile:filename];
    if (self) {
        [self setUpCell];
    }
    return self;
}

- (BOOL)isContainPoint:(CGPoint)point {
    return CGRectContainsPoint(self.boundingBox, point);
}


#pragma mark - Setters

- (void)setHighlighted:(BOOL)highlighted {
    _highlighted = highlighted;
    if (highlighted) {
        _highlightedLight.opacity = 255.0f;
    } else {
        _highlightedLight.opacity = 0.0f;
    }
}

@end
