//
//  ItemDetailView.h
//  Pikachu
//
//  Created by Phi Long on 4/3/13.
//
//

#import <UIKit/UIKit.h>

@interface ItemDetailView : UIView {
    CGFloat _itemWidth;
	CGFloat _itemHeight;
	NSArray* _items;
}

- (id)initWithFrame:(CGRect)frame items:(NSArray*) items;

@end
