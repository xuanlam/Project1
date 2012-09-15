//
//  SinglePlayerGameInterfaceLayer.h
//  Pikachu
//
//  Created by Xuan Lam on 8/8/12.
//
//

#import "CCLayer.h"
#import "cocos2d.h"

@protocol SinglePlayerGameInterfaceLayerDelegate;

@interface SinglePlayerGameInterfaceLayer : CCLayer
@property (nonatomic, unsafe_unretained) id<SinglePlayerGameInterfaceLayerDelegate> delegate;

- (void)updateTimeBarWithValue:(float)value;
@end

@protocol SinglePlayerGameInterfaceLayerDelegate <NSObject>

- (void)gameInterfaceDidSelectHintButton:(SinglePlayerGameInterfaceLayer *)gameInterface;
- (void)gameInterfaceDidSelectRandomButton:(SinglePlayerGameInterfaceLayer *)gameInterface;


@end