//
//  StoreMenuView.h
//  Pikachu
//
//  Created by Phi Long on 4/4/13.
//
//

#import <UIKit/UIKit.h>

@interface StoreMenuView : UIView <UIScrollViewDelegate> {
    UIScrollView* scrollViewItem;
    UIScrollView* scrollViewPacket;
    BOOL pageControlUsed;
    NSMutableArray* pageViews;
    NSMutableArray* pageViewsPacket;
    NSMutableArray* items;
    NSMutableArray* packets;
}

@end
