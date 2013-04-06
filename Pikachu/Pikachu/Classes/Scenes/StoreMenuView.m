//
//  StoreMenuView.m
//  Pikachu
//
//  Created by Phi Long on 4/4/13.
//
//

#import "StoreMenuView.h"
#import "StoreMenuPacketView.h"


#define NumberOfPagesPacket         2
#define NumberItemPerPagePacket     4

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
        
        // pageViews packet (just code, not add view)
        pageViewsPacket = [[NSMutableArray alloc] initWithCapacity:NumberOfPagesPacket];
		for(int i = 0; i < NumberOfPagesPacket; i++) {
			[pageViewsPacket addObject:[NSNull null]];
		}
        
        // add array UIImage packet
        packets = [[NSMutableArray alloc] initWithCapacity:NumberOfPagesPacket * NumberItemPerPagePacket];
        UIImage *imagePacket = [UIImage imageNamed:@"b_0009_Shop_Piece_Pack.png"];
		for(int i = 0; i < NumberOfPagesPacket * NumberItemPerPagePacket; i++) {
			[packets addObject:imagePacket];
		}
        
        // add shop wood 1
        UIImage *imageShopWood1 = [UIImage imageNamed:@"b_0011_Shop_WOOD.png"];
        UIImageView *imageViewShopWood1 = [[UIImageView alloc]initWithImage:imageShopWood1];
        imageViewShopWood1.frame = CGRectMake(130, 300, imageShopWood1.size.width, imageShopWood1.size.height);
        [self addSubview:imageViewShopWood1];
        
        // add 3 item for wood 1
        UIImage *imageItem = [UIImage imageNamed:@"b_0009_Shop_Piece_Pack.png"];
        UIImage *imageBuyNow = [UIImage imageNamed:@"b_0003_Shop_BUY-NOW.png"];
        
        // add button Item 1
        UIButton *buttonItem1 = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonItem1.frame = CGRectMake(330, 150, imageItem.size.width, imageItem.size.height);
        buttonItem1.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
        [buttonItem1 setImage:imageItem forState:UIControlStateNormal];
        buttonItem1.tag = 1;
        [buttonItem1 addTarget:self action:@selector(buttonItemDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonItem1];
        
        // add button buy Item 1
        UIButton *buttonBuyItem1 = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonBuyItem1.frame = CGRectMake(330, 330, 80, 40);
        buttonBuyItem1.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
        [buttonBuyItem1 setImage:imageBuyNow forState:UIControlStateNormal];
        buttonBuyItem1.tag = 11;
        [buttonBuyItem1 addTarget:self action:@selector(buttonBuyItemDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonBuyItem1];
        
        // add button Item 2
        UIButton *buttonItem2 = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonItem2.frame = CGRectMake(460, 150, imageItem.size.width, imageItem.size.height);
        buttonItem2.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
        [buttonItem2 setImage:imageItem forState:UIControlStateNormal];
        buttonItem2.tag = 2;
        [buttonItem2 addTarget:self action:@selector(buttonItemDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonItem2];
        
        // add button buy Item 2
        UIButton *buttonBuyItem2 = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonBuyItem2.frame = CGRectMake(460, 330, 80, 40);
        buttonBuyItem2.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
        [buttonBuyItem2 setImage:imageBuyNow forState:UIControlStateNormal];
        buttonBuyItem2.tag = 22;
        [buttonBuyItem2 addTarget:self action:@selector(buttonBuyItemDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonBuyItem2];
        
        // add button Item 3
        UIButton *buttonItem3 = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonItem3.frame = CGRectMake(590, 150, imageItem.size.width, imageItem.size.height);
        buttonItem3.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
        [buttonItem3 setImage:imageItem forState:UIControlStateNormal];
        buttonItem3.tag = 3;
        [buttonItem3 addTarget:self action:@selector(buttonItemDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonItem3];
        
        // add button buy Item 3
        UIButton *buttonBuyItem3 = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonBuyItem3.frame = CGRectMake(590, 330, 80, 40);
        buttonBuyItem3.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
        [buttonBuyItem3 setImage:imageBuyNow forState:UIControlStateNormal];
        buttonBuyItem3.tag = 33;
        [buttonBuyItem3 addTarget:self action:@selector(buttonBuyItemDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonBuyItem3];
        
        
        //add shop wood 2
        UIImage *imageShopWood2 = [UIImage imageNamed:@"b_0011_Shop_WOOD.png"];
        UIImageView *imageViewShopWood2 = [[UIImageView alloc]initWithImage:imageShopWood2];
        imageViewShopWood2.frame = CGRectMake(130, 600, imageShopWood2.size.width, imageShopWood2.size.height);
        [self addSubview:imageViewShopWood2];
        
        // add button buy Packet 1
        UIButton *buttonBuyPacket1 = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonBuyPacket1.frame = CGRectMake(310, 630, 80, 40);
        buttonBuyPacket1.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
        [buttonBuyPacket1 setImage:imageBuyNow forState:UIControlStateNormal];
        [buttonBuyPacket1 addTarget:self action:@selector(buttonBuyPacketDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonBuyPacket1];
        
        // add button buy Packet 2
        UIButton *buttonBuyPacket2 = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonBuyPacket2.frame = CGRectMake(430, 630, 80, 40);
        buttonBuyPacket1.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
        [buttonBuyPacket2 setImage:imageBuyNow forState:UIControlStateNormal];
        [buttonBuyPacket2 addTarget:self action:@selector(buttonBuyPacketDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonBuyPacket2];
        
        // add button buy Packet 3
        UIButton *buttonBuyPacket3 = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonBuyPacket3.frame = CGRectMake(550, 630, 80, 40);
        buttonBuyPacket1.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
        [buttonBuyPacket3 setImage:imageBuyNow forState:UIControlStateNormal];
        [buttonBuyPacket3 addTarget:self action:@selector(buttonBuyPacketDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonBuyPacket3];
        
        // add button buy Packet 4
        UIButton *buttonBuyPacket4 = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonBuyPacket4.frame = CGRectMake(680, 630, 80, 40);
        buttonBuyPacket1.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
        [buttonBuyPacket4 setImage:imageBuyNow forState:UIControlStateNormal];
        [buttonBuyPacket4 addTarget:self action:@selector(buttonBuyPacketDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonBuyPacket4];
        
        // add scrollview for shop wood 2
        scrollViewPacket = [[UIScrollView alloc]initWithFrame:CGRectMake(280, 450, 512, 200)];
        scrollViewPacket.pagingEnabled = YES;
        scrollViewPacket.contentSize = CGSizeMake(512 * NumberOfPagesPacket, 200);
        scrollViewPacket.showsHorizontalScrollIndicator = NO;
        scrollViewPacket.showsVerticalScrollIndicator = NO;
        scrollViewPacket.scrollsToTop = NO;
        scrollViewPacket.delegate = self;
        scrollViewPacket.tag = 1;
        
        [self addSubview:scrollViewPacket];
        [self loadPagePacket:0];
        [self loadPagePacket:1];

    }
    return self;
}


#pragma mark - ScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    if (pageControlUsed) {
        return;
    }
    
    CGFloat pageWidth = scrollViewPacket.frame.size.width;
    int page = floor((scrollViewPacket.contentOffset.x - pageWidth/2) / pageWidth) + 1;
//    pageControl.currentPage = page;
    
    [self loadPagePacket:page - 1];
    [self loadPagePacket:page];
    [self loadPagePacket:page + 1];
    
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

- (void)loadPagePacket:(int)pageIndex {
	if (pageIndex < 0)
        return;
    if (pageIndex >= NumberOfPagesPacket)
        return;
    
	if((NSNull*)[pageViewsPacket objectAtIndex:pageIndex] == [NSNull null]) {
		CGRect frame = scrollViewPacket.frame;
		frame.origin.x = frame.size.width * pageIndex;
		frame.origin.y = 0;
		NSRange range;
		range.location = pageIndex * NumberItemPerPagePacket;
		range.length = fmin(NumberItemPerPagePacket, [packets count] - range.location);
		
		StoreMenuPacketView* itemView = [[StoreMenuPacketView alloc] initWithFrame:frame items:[packets subarrayWithRange:range]];
        //		itemView.delegate = self;
		[scrollViewPacket addSubview:itemView];
		[pageViewsPacket replaceObjectAtIndex:pageIndex withObject:itemView];
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

- (void)buttonItemDidClick:(id)sender {
    NSLog(@"button Item clicked");
}

- (void)buttonBuyItemDidClick:(id)sender {
    NSLog(@"button Buy Item clicked");
}

- (void)buttonBuyPacketDidClick:(id)sender {
    NSLog(@"button Buy Packet clicked");
}

@end
