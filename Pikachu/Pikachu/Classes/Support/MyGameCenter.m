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

@end
