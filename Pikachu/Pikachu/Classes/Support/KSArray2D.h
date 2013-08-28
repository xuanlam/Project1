//
//  KSArray2D.h
//  Pikachu
//
//  Created by Xuan Lam on 8/12/12.
//
//

//#import <Foundation/Foundation.h>

@interface KSArray2D : NSObject {
    NSMutableArray *sections;
}

- (id)initWithRows:(NSUInteger)numberOfRow andColumn:(NSUInteger)numberOfColumn;
- (id)objectForRow:(NSUInteger)row atColumn:(NSUInteger)column;
- (void)setObject:(id)object forRow:(NSUInteger)row atColumn:(NSUInteger)column;
- (void)randomObject;
@end
