//
//  PacketDetailView.m
//  Pikachu
//
//  Created by Phi Long on 4/5/13.
//
//

#import "CSPacketDetailView.h"

@implementation CSPacketDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame packets:(NSArray *)packets {
    self = [super initWithFrame:frame];
    if (self) {
        _packets = [[NSArray alloc]initWithArray:packets];
        int count = [packets count];
        NSLog(@"count: %d",count);
        int width = self.frame.size.width;
        
        UIImage *packet;
        int x = 10;
        int y = 0;
        
        _packetWidth = 123;
        _packetHeight = 157;
        
        for (int i = 0; i < count; i++) {
            packet = [packets objectAtIndex:i];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            if (x + _packetWidth > width) {
                y += _packetHeight;
                x = 10;
            }
            
            button.frame = CGRectMake(x, y, _packetWidth, _packetHeight);
            button.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
            [button setImage:packet forState:UIControlStateNormal];
            button.tag = i;
			[button addTarget:self action:@selector(packetDidClick:) forControlEvents:UIControlEventTouchUpInside];
			[self addSubview:button];
			x += _packetWidth;
        }
    }
    return self;
}

- (void)packetDidClick:(id)sender {
	NSLog(@"detail packet button clicked");
}


@end
