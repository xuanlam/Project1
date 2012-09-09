//
//  EffectLayer.m
//  Pikachu
//
//  Created by Xuan Lam on 8/18/12.
//
//

#import "EffectLayer.h"

@implementation EffectLayer

- (void)drawLineFromPoint:(CGPoint)point1 toPoint:(CGPoint)point2 {
    CCSprite *line = [CCSprite spriteWithFile:@"line.png"];
    line.anchorPoint = CGPointMake(0.0f, 0.5f);

    if (point1.x == point2.x) {
        float scale = point2.y - point1.y;
        line.rotation = -90.0f;
        line.scaleX = scale;
    } else {
        float scale = point2.x - point1.x;
        line.scaleX = scale;
    }
    
    line.position = point1;
    [self addChild:line];
}

- (void)drawLineWithPoints:(NSArray *)arrayPoint andDirections:(NSArray *)arrayDirection {
    for (int i = 1; i < arrayPoint.count; i++) {
        [self drawLineFromPoint:[[arrayPoint objectAtIndex:i - 1] CGPointValue] toPoint:[[arrayPoint objectAtIndex:i] CGPointValue]];
//        [self drawLineWithPoints:[arrayPoint objectAtIndex:i - 1] andDirections:[arrayPoint objectAtIndex:i]];
    }
    
    [self performSelector:@selector(cleanUpEffect) withObject:nil afterDelay:0.5f];
}

- (void)cleanUpEffect {
    [self removeAllChildrenWithCleanup:YES];
}

@end
