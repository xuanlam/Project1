//
//  PacketDetailView.h
//  Pikachu
//
//  Created by Phi Long on 4/5/13.
//
//

#import <UIKit/UIKit.h>

@interface PacketDetailView : UIView {
    CGFloat _packetWidth;
	CGFloat _packetHeight;
	NSArray* _packets;
}

- (id)initWithFrame:(CGRect)frame packets:(NSArray*)packets;

@end
