//
//  AppDelegate.h
//  Pikachu
//
//  Created by Lam Xuan on 8/4/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//
// Long

#import <UIKit/UIKit.h>
#import "cocos2d.h"

@interface AppController : NSObject <UIApplicationDelegate, CCDirectorDelegate>
{
	UIWindow *window_;
	UINavigationController *navController_;

	CCDirectorIOS	*director_;							// weak ref
}

@property (nonatomic, retain) UIWindow *window;
@property (readonly) UINavigationController *navController;
@property (readonly) CCDirectorIOS *director;

@end
