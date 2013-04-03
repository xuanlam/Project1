//
//  SinglePlayerGameScene.h
//  Pikachu
//
//  Created by Xuan Lam on 8/7/12.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SinglePlayerGamePlayLayer.h"
#import "SinglePlayerGameInterfaceLayer.h"


@interface SinglePlayerGameScene : CCScene <SinglePlayerGamePlayDelegate, SinglePlayerGameInterfaceLayerDelegate>

@property (nonatomic, strong) SinglePlayerGameInterfaceLayer *interfaceLayer;

@end
