//
//  KSArray2D.m
//  Pikachu
//
//  Created by Xuan Lam on 8/12/12.
//
//

#import "KSArray2D.h"

@implementation KSArray2D

- (id)initWithRows:(NSUInteger)numberOfRow andColumn:(NSUInteger)numberOfColumn {
    self = [super init];
    
    if (self) {
        sections = [[NSMutableArray alloc] initWithCapacity:numberOfRow];
        for (int i = 0; i < numberOfRow; i++) {
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:numberOfColumn];
            for (int j = 0; j < numberOfColumn; j++) {
                [array insertObject:[NSNull null] atIndex:j];
            }
            [sections addObject:array];
        }
    }
    return self;
}

- (void)setObject:(id)object forRow:(NSUInteger)row atColumn:(NSUInteger)column {
    [[sections objectAtIndex:row] replaceObjectAtIndex:column withObject:object];
}

- (id)objectForRow:(NSUInteger)row atColumn:(NSUInteger)column {
    return [[sections objectAtIndex:row] objectAtIndex:column];
}

@end
