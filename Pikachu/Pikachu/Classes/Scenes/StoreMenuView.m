//
//  StoreMenuView.m
//  Pikachu
//
//  Created by Phi Long on 4/4/13.
//
//

#import "StoreMenuView.h"
#import "StoreMenuItemView.h"

#define NumberOfPagesItem           3
#define NumberOfPagesPacket         3
#define NumberItemPerPageItem       5
#define NumberItemPerPagePacket     5

@implementation StoreMenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor darkGrayColor];
        
        // add navigation bar UIImageView
        UIImage *imageNavigationbar = [UIImage imageNamed:@"background_statusbar.png"];
        UIImageView *imageViewNavigationbar = [[UIImageView alloc]initWithImage:imageNavigationbar];
        [self addSubview:imageViewNavigationbar];
        
        // add button Back
        UIImage *imageButtonBack = [UIImage imageNamed:@"b_0001_button_Back.png"];
        UIButton *buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonBack.frame = CGRectMake(0, 10, imageButtonBack.size.width, imageButtonBack.size.height);
        [buttonBack setImage:imageButtonBack forState:UIControlStateNormal];
        [buttonBack addTarget:self action:@selector(buttonBackPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonBack];
        
        // add button Pause
        UIImage *imageButtonPause = [UIImage imageNamed:@"menu_button_pause.png"];
        UIButton *buttonPause = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonPause.frame = CGRectMake(990, 10, imageButtonPause.size.width, imageButtonPause.size.height);
        [buttonPause setImage:imageButtonPause forState:UIControlStateNormal];
        [buttonPause addTarget:self action:@selector(buttonPausePressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonPause];
        
        // add pageview
        pageViews = [[NSMutableArray alloc] initWithCapacity:NumberOfPagesItem];
		for(int i = 0; i < NumberOfPagesItem; i++) {
			[pageViews addObject:[NSNull null]];
		}
        
        // add array UIImage
        items = [[NSMutableArray alloc] initWithCapacity:14];
        UIImage *image = [UIImage imageNamed:@"b_0009_Shop_Piece_Pack.png"];
		for(int i = 0; i < 15; i++) {
			[items addObject:image];
		}
        
        // add shop wood 1
        UIImage *imageShopWood1 = [UIImage imageNamed:@"b_0011_Shop_WOOD.png"];
        UIImageView *imageViewShopWood1 = [[UIImageView alloc]initWithImage:imageShopWood1];
        imageViewShopWood1.frame = CGRectMake(130, 300, imageShopWood1.size.width, imageShopWood1.size.height);
        [self addSubview:imageViewShopWood1];
        
        // add scrollview for shop wood 1
        scrollViewItem = [[UIScrollView alloc]initWithFrame:CGRectMake(180, 150, 650, 200)];
        scrollViewItem.pagingEnabled = YES;
        scrollViewItem.contentSize = CGSizeMake(650 * NumberOfPagesItem, 200);
        scrollViewItem.showsHorizontalScrollIndicator = NO;
        scrollViewItem.showsVerticalScrollIndicator = NO;
        scrollViewItem.scrollsToTop = NO;
        scrollViewItem.delegate = self;
        
        [self addSubview:scrollViewItem];
        [self loadPage:0];
        [self loadPage:1];

    }
    return self;
}


#pragma mark - ScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    if (pageControlUsed) {
        return;
    }
    
    CGFloat pageWidth = scrollViewItem.frame.size.width;
    int page = floor((scrollViewItem.contentOffset.x - pageWidth/2) / pageWidth) + 1;
//    pageControl.currentPage = page;
    
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
    if (pageIndex >= NumberOfPagesItem)
        return;
    
	if((NSNull*)[pageViews objectAtIndex:pageIndex] == [NSNull null]) {
		CGRect frame = scrollViewItem.frame;
		frame.origin.x = frame.size.width * pageIndex;
		frame.origin.y = 0;
		NSRange range;
		range.location = pageIndex * NumberItemPerPageItem;
		range.length = fmin(NumberItemPerPageItem, [items count] - range.location);
		
		StoreMenuItemView* itemView = [[StoreMenuItemView alloc] initWithFrame:frame items:[items subarrayWithRange:range]];
        //		itemView.delegate = self;
		[scrollViewItem addSubview:itemView];
		[pageViews replaceObjectAtIndex:pageIndex withObject:itemView];
		[itemView release];
	}
}

- (void)buttonBackPressed:(id)sender {
	NSLog(@"button Back clicked");
    [self removeFromSuperview];
}

- (void)buttonPausePressed:(id)sender {
	NSLog(@"button Pause clicked");
}

@end
