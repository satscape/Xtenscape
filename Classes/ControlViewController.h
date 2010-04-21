//
//  ControlViewController.h
//  Xtenscape
//
//  Created by Scott Hather on 15/12/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdViewController.h"

@interface ControlViewController : UIViewController {

	IBOutlet UILabel *moduleName;
	IBOutlet UISwitch *onOff;
	IBOutlet UISlider *brightness;
	IBOutlet UILabel *brightLabel;
	
	NSString *mModuleName;
	NSString *mModuleAddress;
	NSString *mModuleType;
	
} 

@property(nonatomic,retain) NSString *mModuleName;
@property(nonatomic,retain) NSString *mModuleAddress;
@property(nonatomic,retain) NSString *mModuleType;


- (IBAction)onOffAction;
- (IBAction)brightnessAction;
- (IBAction)brightDrag;

@end
