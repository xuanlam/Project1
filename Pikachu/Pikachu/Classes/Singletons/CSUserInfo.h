//
//  PKCUserInfo.h
//  Pikachu
//
//  Created by Xuan Lam on 4/1/13.
//
//

#import <Foundation/Foundation.h>

@interface CSUserInfo : NSObject

+ (NSInteger)numberOfHintCount;
+ (void)setNumberOfHintCount:(NSInteger)numberOfHintCount;

+ (NSInteger)numberOfRandomCount;
+ (void)setNumberOfRandomCount:(NSInteger)numberOfRandomCount;

+ (NSInteger)numberOfAddTimeCount;
+ (void)setNumberOfAddTimeCount:(NSInteger)numberOfAddTimeCount;

+ (NSInteger)currentPacketIndex;
+ (void)setCurrentPacketIndex:(NSInteger)currentPacketIndex;

@end
