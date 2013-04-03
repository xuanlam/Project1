//
//  StoreItemDetailView.h
//  Pikachu
//
//  Created by Phi Long on 4/3/13.
//
//

#import <UIKit/UIKit.h>

@interface StoreItemDetailView : UIView <UIScrollViewDelegate> {
    UIScrollView* scrollView;
	UIPageControl* pageControl;
	NSMutableArray* items;
	NSInteger kNumberOfPages;
	BOOL pageControlUsed;
	NSMutableArray* pageViews;
}

- (void)loadPage:(int)pageIndex;

@end
