//
//  RootViewController.h
//  Xtenscape
//
//  Created by Scott Hather on 15/12/2008.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//
 
#import <UIKit/UIKit.h>
#import "SettingsViewController.h"
#import "HelpViewController.h" 
#import "ControlViewController.h"
#import "scottCell.h"


@interface RootViewController : UITableViewController {
	SettingsViewController *mySettingsViewController;
	HelpViewController *myHelpViewController;
	ControlViewController *myControlViewController;
	
	IBOutlet UITableView *myTableView;
	NSInteger mModuleCount;
	
	IBOutlet scottCell *cell;

 
} 

@property(nonatomic,retain) SettingsViewController *mySettingsViewController;
@property(nonatomic,retain) HelpViewController *myHelpViewController;
@property(nonatomic,retain) ControlViewController *myControlViewController;

	NSString *lastCommandSent;  //static variable



- (IBAction)BUThelp;
- (IBAction)BUTsettings;

-(void)loadModuleList;
-(NSString*)getModuleField:(NSInteger)fieldNumber moduleIndex:(NSInteger)moduleIndex;
+(NSString*)sendCommand:(NSString*)command;


@end
