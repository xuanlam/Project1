//
//  StoreMenuPacketView.h
//  Pikachu
//
//  Created by Phi Long on 4/5/13.
//
//

#import <UIKit/UIKit.h>

@interface StoreMenuPacketView : UIView {
    CGFloat _itemWidth;
	CGFloat _itemHeight;
	NSArray* _items;

}

- (id)initWithFrame:(CGRect)frame items:(NSArray*) items;

@end
