//
//  StoreItemDetailView.m
//  Pikachu
//
//  Created by Phi Long on 4/3/13.
//
//

#import "StoreItemDetailView.h"
#import "ItemDetailView.h"

#define NumberOfPages   3

static NSUInteger kNumberItemPerPage = 20;

@implementation StoreItemDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        
        pageViews = [[NSMutableArray alloc] initWithCapacity:NumberOfPages];
		for(int i = 0; i < NumberOfPages; i++) {
			[pageViews addObject:[NSNull null]];
		}
        
        // add array UIImage
        items = [[NSMutableArray alloc] initWithCapacity:60];
        UIImage *image = [UIImage imageNamed:@"b_0009_Shop_Piece_Pack.png"];
		for(int i = 0; i < 60; i++) {
			[items addObject:image];
		}
        
        // add scroll View
        scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        scrollView.pagingEnabled = YES;
        scrollView.contentSize = CGSizeMake(self.frame.size.width * NumberOfPages, self.frame.size.height);
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.scrollsToTop = NO;
        scrollView.delegate = self;
        
        [self addSubview:scrollView];
        
        [self loadPage:0];
        [self loadPage:1];
        
        
//        UIImage *image = [UIImage imageNamed:@"b_0009_Shop_Piece_Pack.png"];
//        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
//        [self addSubview:imageView];
    }
    return self;
}


#pragma mark - ScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    if (pageControlUsed) {
        return;
    }

    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth/2) / pageWidth) + 1;
    pageControl.currentPage = page;

    [self loadPage:page - 1];
    [self loadPage:page];
    [self loadPage:page + 1];

}

// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}


#pragma mark - action

- (void)loadPage:(int)pageIndex {
	if (pageIndex < 0)
        return;
    if (pageIndex >= NumberOfPages)
        return;
    
	if((NSNull*)[pageViews objectAtIndex:pageIndex] == [NSNull null]) {
		CGRect frame = scrollView.frame;
		frame.origin.x = frame.size.width * pageIndex;
		frame.origin.y = 0;
		NSRange range;
		range.location = pageIndex * NumberOfPages;
		range.length = fmin(NumberOfPages, 60 - range.location);
		
		ItemDetailView* itemView = [[ItemDetailView alloc] initWithFrame:frame items:items];
//		itemView.delegate = self;
		[scrollView addSubview:itemView];
		[pageViews replaceObjectAtIndex:pageIndex withObject:itemView];
		[itemView release];
	}
}

@end
