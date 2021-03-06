//
//  GameManager.m
//  Pikachu
//
//  Created by Xuan Lam on 8/8/12.
//
//

#import "CSGameManager.h"
#import "CSSinglePlayerGameScene.h"
#import "CSMainMenuScene.h"

@implementation CSGameManager

static CSGameManager* _sharedGameManager = nil;

+(CSGameManager*)sharedGameManager {
    @synchronized([CSGameManager class])
    {
        if(!_sharedGameManager)
            [[self alloc] init];
        return _sharedGameManager;
    }
    return nil;
}

+(id)alloc {
    @synchronized ([CSGameManager class])
    {
        NSAssert(_sharedGameManager == nil, @"Attempted to allocate a second instance of the Game Manager singleton");
        _sharedGameManager = [super alloc];
        return _sharedGameManager;
    }
    return nil;
}

- (id)init {
    self = [super init];
    if (self) {
        _currentScene = kNoSceneUninitialized;
    }
    return self;
}

- (void) runSceneWithID:(SceneTypes)sceneID {
    [self runSceneWithID:sceneID animation:NO];
}

- (void)runSceneWithID:(SceneTypes)sceneID animation:(BOOL)animate {
    _oldScene = _currentScene;
    
    if (sceneID != kLevelCompleteScene)
        _currentScene = sceneID;
    
    id sceneToRun = nil;
    
    switch (sceneID) {
        case kGameSinglePlayer:
            sceneToRun = [CSSinglePlayerGameScene node];
            break;
        case kMainMenuScene:
            sceneToRun = [CSMainMenuScene node];
            break;
        default:
            CCLOG(@"Unknown ID, cannot switch scenes");
            return;
            break;
    }
    
    if (sceneToRun == nil) {
        _currentScene = _oldScene;
        return;
    }
    
    if ([[CCDirector sharedDirector] runningScene] == nil) {
        if (animate) {
            CCScene *scene = [[CCDirector sharedDirector] runningScene];
            [scene stopAllActions];
            [scene unscheduleAllSelectors];
            
            [[CCDirector sharedDirector] runWithScene:[CCTransitionFade transitionWithDuration:0.5f scene:sceneToRun]];
        } else {
            [[CCDirector sharedDirector] runWithScene:sceneToRun];
        }
        
    } else {
        if (animate) {
            CCScene *scene = [[CCDirector sharedDirector] runningScene];
            [scene stopAllActions];
            [scene unscheduleAllSelectors];
            
            
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f scene:sceneToRun]];
        } else {
            [[CCDirector sharedDirector] replaceScene:sceneToRun];
        }
        
    }
}


#pragma mark - Getters

//- (NSArray *)pathImages {
//    NSMutableArray *array = [NSMutableArray array];
//    
//    NSString *path = [[NSBundle mainBundle] resourcePath];
//    path = [path stringByAppendingPathComponent:@"path1.plist"];
//    
//    NSArray *data = [NSArray arrayWithContentsOfFile:path];
//    
//    for (NSDictionary *dic in data) {
//        NSString *imagePath = [dic objectForKey:@"Path"];
//        [array addObject:imagePath];
//    }    
//    
//    return array;
//}

- (NSArray *)pathImagesForPacketIndex:(NSInteger)packetIndex {
    
    NSMutableArray *pathImages = [NSMutableArray array];
    
    for (int i = 0; i < 32; i++) {
        NSString *pathImage = [NSString stringWithFormat:@"%.2d%.2d.png", packetIndex, i];
        [pathImages addObject:pathImage];
    }
    
    return pathImages;
}

- (NSInteger)numberOfPackets {
    return 9;
}


@end
