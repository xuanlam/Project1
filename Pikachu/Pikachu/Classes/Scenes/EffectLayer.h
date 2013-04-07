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

- (void)drawGuideWithPoints:(NSArray *)arrayPoint andDirections:(NSArray *)arrayDirection withTimeInterval:(CGFloat)timeInterval onCompletion:(void (^)())completion;

@end
