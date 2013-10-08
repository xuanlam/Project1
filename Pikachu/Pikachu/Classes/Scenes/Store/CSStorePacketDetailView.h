//
//  StorePacketDetailView.h
//  Pikachu
//
//  Created by Phi Long on 4/5/13.
//
//

#import <UIKit/UIKit.h>

@interface CSStorePacketDetailView : UIView <UIScrollViewDelegate> {
    UIScrollView* scrollView;
	UIPageControl* pageControl;
	NSMutableArray* packets;
	NSInteger kNumberOfPages;
	BOOL pageControlUsed;
	NSMutableArray* pageViews;
}

- (id)initWithFrame:(CGRect)frame andNumberPacket:(int)numberPacket;
- (void)loadPage:(int)pageIndex;

@end
