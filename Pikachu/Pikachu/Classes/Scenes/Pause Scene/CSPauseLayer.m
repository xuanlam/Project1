//
//  CSPauseLayer.m
//  Pikachu
//
//  Created by Xuan Lam on 3/8/14.
//
//

#import "CSPauseLayer.h"

@implementation CSPauseLayer


- (void)setupPauseLayer {
    CCLayerColor *grayLayer = [[CCLayerColor alloc] initWithColor:ccc4(0, 0, 0, 0.5f)];
    [self addChild:grayLayer];
}

- (id)init {
    self = [super init];
    if (self) {
        [self setupPauseLayer];
    }
    return self;
}

@end
