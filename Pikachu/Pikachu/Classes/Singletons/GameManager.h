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
    kOptionsScene = 2,
    kCreditsScene = 3,
    kIntroScene = 4,
    kLevelCompleteScene = 5,
    kGameSinglePlayer = 101,
    kGameMultiPlayer = 102
} SceneTypes;

@interface GameManager : NSObject
@property (nonatomic, assign) SceneTypes currentScene;
@property (nonatomic, assign) SceneTypes oldScene;
@property (nonatomic, strong) NSArray *pathImages;

+(GameManager*)sharedGameManager;
- (void)runSceneWithID:(SceneTypes)sceneID;
- (void)runSceneWithID:(SceneTypes)sceneID animation:(BOOL)animate;

@end
