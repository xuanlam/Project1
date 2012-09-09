//
//  GameCell.m
//  Pikachu
//
//  Created by Xuan Lam on 8/8/12.
//
//

#import "GameCell.h"

@implementation GameCell
@synthesize selected = _selected;
@synthesize cellID = _cellID;
@synthesize type = _type;
@synthesize row = _row;
@synthesize column = _column;

- (void)setUpCell {
    _selected = NO;
    _cellID = -1;
    _type = -1;
    _row = -1;
    _column = -1;
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

@end
