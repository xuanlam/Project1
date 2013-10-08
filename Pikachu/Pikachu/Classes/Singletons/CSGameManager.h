//
//  GameManager.h
//  Pikachu
//
//  Created by Xuan Lam on 8/8/12.
//
//

#import <Foundation/Foundation.h>
//#import "Constants.h"

typedef enum {
    kNoSceneUninitialized = 0,
    kMainMenuScene = 1,
    kLevelCompleteScene = 5,
    kGameSinglePlayer = 101,
    kGameMultiPlayer = 102
} SceneTypes;

@interface CSGameManager : NSObject

+(CSGameManager*)sharedGameManager;

@property (nonatomic, assign) SceneTypes currentScene;
@property (nonatomic, assign) SceneTypes oldScene;
@property (nonatomic)         NSInteger numberOfPackets;

- (void)runSceneWithID:(SceneTypes)sceneID;
- (void)runSceneWithID:(SceneTypes)sceneID animation:(BOOL)animate;
- (NSArray *)pathImagesForPacketIndex:(NSInteger)packetIndex;


@end
