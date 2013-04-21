//
//  MyGameCenter.m
//  Pikachu
//
//  Created by Phi Long on 4/10/13.
//
//

#import "MyGameCenter.h"

@implementation MyGameCenter

+ (id)sharedMyGameCenter {
    static MyGameCenter *sharedMyGameCenter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyGameCenter = [[MyGameCenter alloc] init];
    });
    return sharedMyGameCenter;
}

#pragma mark Player Authentication

- (void)authenticateLocalPlayer {
    
    GKLocalPlayer* localPlayer = [GKLocalPlayer localPlayer];
    
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error) {
        [self setLastError:error];
        
        if ([CCDirector sharedDirector].isPaused)
            [[CCDirector sharedDirector] resume];
        
        if (localPlayer.authenticated) {
            _gameCenterFeaturesEnabled = YES;
        } else if(viewController) {
            [[CCDirector sharedDirector] pause];
            [self presentViewController:viewController];
        } else {
            _gameCenterFeaturesEnabled = NO;
        }
    };
}


#pragma mark Property setters

- (void)setLastError:(NSError*)error {
    _lastError = [error copy];
    if (_lastError) {
        NSLog(@"MyGameCenter ERROR: %@", [[_lastError userInfo]description]);
    }
}


#pragma mark UIViewController stuff

- (UIViewController*)getRootViewController {
    return [UIApplication sharedApplication].keyWindow.rootViewController;
}

- (void)presentViewController:(UIViewController*)vc {
    UIViewController* rootVC = [self getRootViewController];
    [rootVC presentViewController:vc animated:YES completion:nil];
}

#pragma mark - Sumit HighScore
-(void) submitScore:(int64_t)score category:(NSString*)category {
    //1: Check if Game Center features are enabled
    if (!_gameCenterFeaturesEnabled) {
        CCLOG(@"Player not authenticated");
        return;
    }
    
    //2: Create a GKScore object
    GKScore* gkScore = [[GKScore alloc] initWithCategory:category];
    
    //3: Set the score value
    gkScore.value = score;
    
    //4: Send the score to Game Center
    [gkScore reportScoreWithCompletionHandler:^(NSError* error) {
        
        [self setLastError:error];
        
        BOOL success = (error == nil);
        
        if ([_delegate respondsToSelector:@selector(onScoresSubmitted:)]) {
            
            [_delegate onScoresSubmitted:success];
        }
    }];
}

@end
