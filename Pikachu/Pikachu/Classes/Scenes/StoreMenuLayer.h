//
//  StoreMenuLayer.h
//  Pikachu
//
//  Created by Phi Long on 3/31/13.
//
//

#import "CCLayer.h"
#import "cocos2d.h"
#import "StoreItemDetailLayer.h"

@protocol StoreMenuLayerDelegate;

@interface StoreMenuLayer : CCLayer <StoreItemDetailLayerDelegate>

@property (nonatomic, unsafe_unretained) id<StoreMenuLayerDelegate> delegate;

@end


@protocol StoreMenuLayerDelegate <NSObject>

@required
- (void)storeMenuLayerDidSelectCloseButton:(StoreMenuLayer *)storeMenuLayer;

@end