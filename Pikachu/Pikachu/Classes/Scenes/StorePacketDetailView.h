//
//  StorePacketDetailView.h
//  Pikachu
//
//  Created by Phi Long on 4/5/13.
//
//

#import <UIKit/UIKit.h>

@interface StorePacketDetailView : UIView <UIScrollViewDelegate> {
    UIScrollView* scrollView;
	UIPageControl* pageControl;
	NSMutableArray* items;
	NSInteger kNumberOfPages;
	BOOL pageControlUsed;
	NSMutableArray* pageViews;
}

- (void)loadPage:(int)pageIndex;

@end
