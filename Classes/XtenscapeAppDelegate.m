//
//  XtenscapeAppDelegate.m
//  Xtenscape
//
//  Created by Scott Hather on 15/12/2008.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "XtenscapeAppDelegate.h"
#import "RootViewController.h"


@implementation XtenscapeAppDelegate

@synthesize window;
@synthesize navigationController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	// Configure and show the window
	[window addSubview:[navigationController view]];
	[window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}

@end
