//
//  StorePacketDetailView.m
//  Pikachu
//
//  Created by Phi Long on 4/5/13.
//
//

#import "StorePacketDetailView.h"
#import "ItemDetailView.h"
#import "GameManager.h"

#define NumberOfPages       3
#define NumberItemPerPage   12

@implementation StorePacketDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        
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
        
        
        pageViews = [[NSMutableArray alloc] initWithCapacity:NumberOfPages];
		for(int i = 0; i < NumberOfPages; i++) {
			[pageViews addObject:[NSNull null]];
		}
        
        // add array UIImage
        //        items = [[NSMutableArray alloc] initWithCapacity:60];
        //        UIImage *image = [UIImage imageNamed:@"b_0009_Shop_Piece_Pack.png"];
        //		for(int i = 0; i < 60; i++) {
        //			[items addObject:image];
        //		}
        
        // add array item
        NSMutableArray *imageItem  = [[NSMutableArray alloc]initWithArray:[[GameManager sharedGameManager] pathImagesForPacketIndex:1]];
        items = [[NSMutableArray alloc] initWithCapacity:[imageItem count]];
        for (int i = 0; i < [imageItem count]; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[imageItem objectAtIndex:i]]];
            [items addObject:image];
        }
        
        
        // add scroll View
        scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, imageNavigationbar.size.height, self.frame.size.width, self.frame.size.height - imageNavigationbar.size.height)];
        scrollView.pagingEnabled = YES;
        scrollView.contentSize = CGSizeMake(self.frame.size.width * NumberOfPages, self.frame.size.height - imageNavigationbar.size.height);
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.scrollsToTop = NO;
        scrollView.delegate = self;
        
        [self addSubview:scrollView];
        
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
		range.location = pageIndex * NumberItemPerPage;
		range.length = fmin(NumberItemPerPage, [items count] - range.location);
		
		ItemDetailView* itemView = [[ItemDetailView alloc] initWithFrame:frame items:[items subarrayWithRange:range]];
        //		itemView.delegate = self;
		[scrollView addSubview:itemView];
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
