//
//  StoreMenuView.m
//  Pikachu
//
//  Created by Phi Long on 4/4/13.
//
//

#import "StoreMenuView.h"

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
        
        // add shop wood 1
        UIImage *imageShopWood1 = [UIImage imageNamed:@"b_0011_Shop_WOOD.png"];
        UIImageView *imageViewShopWood1 = [[UIImageView alloc]initWithImage:imageShopWood1];
        imageViewShopWood1.frame = CGRectMake(130, 300, imageShopWood1.size.width, imageShopWood1.size.height);
        [self addSubview:imageViewShopWood1];
        
        // add scrollview for shop wood 1
        

    }
    return self;
}

- (void)buttonBackPressed:(id)sender {
	NSLog(@"button Back clicked");
    [self removeFromSuperview];
}

- (void)buttonPausePressed:(id)sender {
	NSLog(@"button Pause clicked");
}

@end
