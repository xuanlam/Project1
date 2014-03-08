//
//  PKCUserInfo.m
//  Pikachu
//
//  Created by Xuan Lam on 4/1/13.
//
//

#import "CSUserInfo.h"

@implementation CSUserInfo

+ (NSInteger)numberOfHintCount {
    NSNumber *numberOfHintCount = [[NSUserDefaults standardUserDefaults] objectForKey:@"numberOfHintCount"];
    if (!numberOfHintCount) {
        NSInteger defaultValue = 10;
        [self setNumberOfHintCount:defaultValue];
        return defaultValue;
    } else {
        return [numberOfHintCount intValue];
    }
}

+ (void)setNumberOfHintCount:(NSInteger)numberOfHintCount {
    [[NSUserDefaults standardUserDefaults] setObject:@(numberOfHintCount) forKey:@"numberOfHintCount"];
    [NSUserDefaults resetStandardUserDefaults];
}

+ (NSInteger)numberOfRandomCount {
    NSNumber *numberOfRandomCount = [[NSUserDefaults standardUserDefaults] objectForKey:@"numberOfRandomCount"];
    if (!numberOfRandomCount) {
        NSInteger defaultValue = 10;
        [self setNumberOfRandomCount:defaultValue];
        return defaultValue;
    } else {
        return [numberOfRandomCount intValue];
    }
}

+ (void)setNumberOfRandomCount:(NSInteger)numberOfRandomCount {
    [[NSUserDefaults standardUserDefaults] setObject:@(numberOfRandomCount) forKey:@"numberOfRandomCount"];
    [NSUserDefaults resetStandardUserDefaults];
}

+ (NSInteger)numberOfAddTimeCount {
    NSNumber *numberOfAddTimeCount = [[NSUserDefaults standardUserDefaults] objectForKey:@"numberOfAddTimeCount"];
    if (!numberOfAddTimeCount) {
        NSInteger defaultValue = 10;
        [self setNumberOfAddTimeCount:defaultValue];
        return defaultValue;
    } else {
        return [numberOfAddTimeCount intValue];
    }
}

+ (void)setNumberOfAddTimeCount:(NSInteger)numberOfAddTimeCount {
    [[NSUserDefaults standardUserDefaults] setObject:@(numberOfAddTimeCount) forKey:@"numberOfAddTimeCount"];
    [NSUserDefaults resetStandardUserDefaults];
}

+ (NSInteger)currentPacketIndex {
    NSNumber *currentPacketIndex = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentPacketIndex"];
    if (!currentPacketIndex) {
        NSInteger defaultValue = 0;
        [self setCurrentPacketIndex:defaultValue];
        return defaultValue;
    } else {
        return [currentPacketIndex intValue];
    }
}

+ (void)setCurrentPacketIndex:(NSInteger)currentPacketIndex {
    [[NSUserDefaults standardUserDefaults] setObject:@(currentPacketIndex) forKey:@"currentPacketIndex"];
    [NSUserDefaults resetStandardUserDefaults];
}


#pragma mark - Settings

+ (BOOL)enableSound {
    NSNumber *enableSound = [[NSUserDefaults standardUserDefaults] objectForKey:@"enableSound"];
    if (!enableSound) {
        BOOL defaultValue = YES;
        [self setEnableSound:defaultValue];
        return defaultValue;
    } else {
        return [enableSound boolValue];
    }
}

+ (void)setEnableSound:(BOOL)enableSound {
    [[NSUserDefaults standardUserDefaults] setObject:@(enableSound) forKey:@"enableSound"];
    [NSUserDefaults resetStandardUserDefaults];
}

+ (BOOL)enableMusic {
    NSNumber *enableMusic = [[NSUserDefaults standardUserDefaults] objectForKey:@"enableMusic"];
    if (!enableMusic) {
        BOOL defaultValue = YES;
        [self setEnableMusic:defaultValue];
        return defaultValue;
    } else {
        return [enableMusic boolValue];
    }
}

+ (void)setEnableMusic:(BOOL)enableMusic {
    [[NSUserDefaults standardUserDefaults] setObject:@(enableMusic) forKey:@"enableMusic"];
    [NSUserDefaults resetStandardUserDefaults];
}

@end
