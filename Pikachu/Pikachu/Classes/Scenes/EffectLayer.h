//
//  EffectLayer.h
//  Pikachu
//
//  Created by Xuan Lam on 8/18/12.
//
//

#import "cocos2d.h"
#import "CCLayer.h"

@interface EffectLayer : CCLayer

- (void)drawLineWithPoints:(NSArray *)arrayPoint andDirections:(NSArray *)arrayDirection;

@end
