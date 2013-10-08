//
//  GameCell.h
//  Pikachu
//
//  Created by Xuan Lam on 8/8/12.
//
//

#import "CCSprite.h"

@interface CSGameCell : CCSprite 

@property (nonatomic) BOOL highlighted;
@property (nonatomic) NSInteger cellID;
@property (nonatomic) NSInteger type;
@property (nonatomic) NSInteger row;
@property (nonatomic) NSInteger column;

- (BOOL)isContainPoint:(CGPoint)point;

@end
