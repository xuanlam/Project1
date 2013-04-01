//
//  PKCUserInfo.m
//  Pikachu
//
//  Created by Xuan Lam on 4/1/13.
//
//

#import "PKCUserInfo.h"

@implementation PKCUserInfo

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


@end