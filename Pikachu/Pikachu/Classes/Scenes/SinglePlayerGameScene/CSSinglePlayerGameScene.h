//
//  SinglePlayerGameScene.h
//  Pikachu
//
//  Created by Xuan Lam on 8/7/12.
//
//

#import <Foundation/Foundation.h>
#import "CSSinglePlayerGamePlayLayer.h"
#import "CSSinglePlayerGameInterfaceLayer.h"


@interface CSSinglePlayerGameScene : CCScene <CSSinglePlayerGamePlayDelegate, SinglePlayerGameInterfaceLayerDelegate>

@property (nonatomic, strong) CSSinglePlayerGameInterfaceLayer *interfaceLayer;

@end
