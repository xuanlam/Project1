//
//  MyGameCenter.h
//  Pikachu
//
//  Created by Phi Long on 4/10/13.
//
//

#import <GameKit/GameKit.h>

@protocol MyGameCenterProtocol<NSObject>
@optional
-(void)onScoresSubmitted:(bool)success;
@end


@interface MyGameCenter : NSObject <GKGameCenterControllerDelegate> {
    BOOL _gameCenterFeaturesEnabled;
}
@property (nonatomic, assign) id<MyGameCenterProtocol> delegate;
@property (nonatomic, readonly) NSError* lastError;
@property (nonatomic, readwrite) BOOL includeLocalPlayerScore;

+ (id)sharedMyGameCenter;
- (void)authenticateLocalPlayer;
// Scores
- (void)submitScore:(int64_t)score category:(NSString*)category;


@end
