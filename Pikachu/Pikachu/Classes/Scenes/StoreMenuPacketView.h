//
//  StoreMenuPacketView.h
//  Pikachu
//
//  Created by Phi Long on 4/5/13.
//
//

#import <UIKit/UIKit.h>


#define NumberOfPagesPacket         2
#define NumberItemPerPagePacket     4

@interface StoreMenuPacketView : UIView {
    CGFloat _itemWidth;
	CGFloat _itemHeight;
	NSArray* _items;

}

- (id)initWithFrame:(CGRect)frame items:(NSArray*)items pageIndex:(int)pageIndex;

@end
