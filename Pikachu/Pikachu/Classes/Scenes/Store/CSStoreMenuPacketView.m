//
//  StoreMenuPacketView.m
//  Pikachu
//
//  Created by Phi Long on 4/5/13.
//
//

#import "CSStoreMenuPacketView.h"
#import "CSStorePacketDetailView.h"

@implementation CSStoreMenuPacketView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items pageIndex:(int)pageIndex {
    self = [super initWithFrame:frame];
    if (self) {
        _items = [[NSArray alloc]initWithArray:items];
        int count = [items count];
//        int width = self.frame.size.width;
        
        UIImage *item;
        int x = 10;
        int y = 0;
        
        _itemWidth = 123;
        _itemHeight = 157;
        
        UIImage *imageBuyNow = [UIImage imageNamed:@"b_0003_Shop_BUY-NOW.png"];
        
        for (int i = 0; i < count; i++) {
            item = [items objectAtIndex:i];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(x, y, _itemWidth, _itemHeight);
            button.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
            [button setImage:item forState:UIControlStateNormal];
            button.tag = pageIndex * NumberItemPerPagePacket + i;
			[button addTarget:self action:@selector(packetDidClick:) forControlEvents:UIControlEventTouchUpInside];
			[self addSubview:button];
			x += _itemWidth;
            
            // add Button buy packet
            UIButton *buttonBuyPacket = [UIButton buttonWithType:UIButtonTypeCustom];
            buttonBuyPacket.frame = CGRectMake(button.frame.origin.x + 15, button.frame.origin.y + 170, 80, 40);
            buttonBuyPacket.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
            [buttonBuyPacket setImage:imageBuyNow forState:UIControlStateNormal];
            [buttonBuyPacket addTarget:self action:@selector(buttonBuyPacketDidClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:buttonBuyPacket];
        }
    }
    return self;
}

- (void)packetDidClick:(id)sender {
	// add UIView
    UIButton *buttonClicked = (UIButton*)sender;
    int tagButtonClicked = buttonClicked.tag;
    
    CSStorePacketDetailView *myview=[[CSStorePacketDetailView alloc] initWithFrame: CGRectMake(0, 0, 1024, 768) andNumberPacket:tagButtonClicked];
    [self.superview.superview addSubview:myview];
    [myview release];
}

- (void)buttonBuyPacketDidClick:(id)sender {
    
}

@end
