//
//  SettingsViewController.m
//  Xtenscape
//
//  Created by Scott Hather on 15/12/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"
#import "RootViewController.h"

@implementation SettingsViewController

//user has changed between internet and LAN modes, so store the setting
- (IBAction)internetModeAction {
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	[prefs setBool:internetMode.on forKey:@"internetMode"];
	
}

//User has fucked with the settings, so save them to user preferences and close keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	[LANIP resignFirstResponder];
	[LANport resignFirstResponder];
	[internetIP resignFirstResponder];
	[internetPort resignFirstResponder];
	[thePassword resignFirstResponder];
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	[prefs setObject:LANIP.text forKey:@"LANIP"];
	[prefs setObject:LANport.text forKey:@"LANport"];
	[prefs setObject:internetIP.text forKey:@"internetIP"];
	[prefs setObject:internetPort.text forKey:@"internetPort"];
	[prefs setObject:thePassword.text forKey:@"thePassword"];
	
	return YES;
}


//load up the settings and chuck them into the controls
- (void)viewWillAppear:(BOOL)animated {
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	
	internetMode.on=[prefs boolForKey:@"internetMode"];
	LANIP.text=[prefs stringForKey:@"LANIP"];
	LANport.text=[prefs stringForKey:@"LANport"];
	internetIP.text=[prefs stringForKey:@"internetIP"];
	internetPort.text=[prefs stringForKey:@"internetPort"];
	thePassword.text=[prefs stringForKey:@"thePassword"];
	
}

-(void)viewWillDisappear:(BOOL)animated {
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	[prefs setBool:YES forKey:@"reloadModuleList"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}


@end
