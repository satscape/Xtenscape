//
//  SettingsViewController.h
//  Xtenscape
//
//  Created by Scott Hather on 15/12/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SettingsViewController : UIViewController {
	IBOutlet UISwitch *internetMode;
	IBOutlet UITextField *LANIP;
	IBOutlet UITextField *LANport;
	IBOutlet UITextField *internetIP;
	IBOutlet UITextField *internetPort;
	IBOutlet UITextField *thePassword;
	
}

- (IBAction)internetModeAction;


@end
