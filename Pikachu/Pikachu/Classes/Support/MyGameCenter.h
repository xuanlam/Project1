//
//  MyGameCenter.h
//  Pikachu
//
//  Created by Phi Long on 4/10/13.
//
//

#import <GameKit/GameKit.h>

@protocol MyGameCenterProtocol<NSObject>
@end


@interface MyGameCenter : NSObject <GKGameCenterControllerDelegate> {
    BOOL _gameCenterFeaturesEnabled;
}
@property (nonatomic, assign) id<MyGameCenterProtocol> delegate;
@property (nonatomic, readonly) NSError* lastError;

+ (id)sharedMyGameCenter;
- (void)authenticateLocalPlayer;

@end
