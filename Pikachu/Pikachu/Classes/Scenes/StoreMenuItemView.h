//
//  StoreMenuItemView.h
//  Pikachu
//
//  Created by Phi Long on 4/4/13.
//
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

@interface StoreMenuItemView : UIView {
    CGFloat _itemWidth;
	CGFloat _itemHeight;
	NSArray* _items;
}

- (id)initWithFrame:(CGRect)frame items:(NSArray*) items;

@end
