//
//  ItemDetailView.m
//  Pikachu
//
//  Created by Phi Long on 4/3/13.
//
//

#import "ItemDetailView.h"

@implementation ItemDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items {
    self = [super initWithFrame:frame];
    if (self) {
        _items = [[NSArray alloc]initWithArray:items];
        int count = [items count];
        NSLog(@"count: %d",count);
        int width = self.frame.size.width;
        
        UIImage *item;
        int x = 10;
        int y = 0;
        
        _itemWidth = 123;
        _itemHeight = 157;
        
        for (int i = 0; i < count; i++) {
            item = [items objectAtIndex:i];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            if (x + _itemWidth > width) {
                y += _itemHeight;
                x = 10;
            }
            
            button.frame = CGRectMake(x, y, _itemWidth, _itemHeight);
            button.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
            [button setImage:item forState:UIControlStateNormal];
            button.tag = i;
			[button addTarget:self action:@selector(itemDidClick:) forControlEvents:UIControlEventTouchUpInside];
			[self addSubview:button];
			x += _itemWidth;
        }
    }
    return self;
}

- (void)itemDidClick:(id)sender {
	NSLog(@"detail item button clicked");
}


@end
