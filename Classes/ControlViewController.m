//
//  ControlViewController.m
//  Xtenscape
//
//  Created by Scott Hather on 15/12/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ControlViewController.h"
#import "RootViewController.h"
#import "scott.h"

@implementation ControlViewController

@synthesize mModuleName;
@synthesize mModuleAddress;
@synthesize mModuleType;

//User has switched the on/off button, so send command to server
- (IBAction)onOffAction {
	NSString *sOnOff;
	NSString *responce;
	
	if (onOff.on==YES) {
		sOnOff=@"on";
	} else {
		sOnOff=@"off";
	}
	responce=[RootViewController sendCommand:[NSString stringWithFormat:@"%@:%@",mModuleAddress,sOnOff]];
	NSLog(responce);
	
}

//user has changed the brightness of the lamp module, so send the command
- (IBAction)brightnessAction  {

	NSInteger i=(float)brightness.value;
	
	NSString *responce;
	
	responce=[RootViewController sendCommand:[NSString stringWithFormat:@"%@:%dPERCENT",mModuleAddress,i ]];
	
}

//user is dragging the brightness slider, so change the label
- (IBAction)brightDrag {
	NSInteger i=(float)brightness.value;
	brightLabel.text=[NSString stringWithFormat: @"Brightness at %d percent",i];
}

//view is about to appear, so get the current state of this appliance and set the controls to match
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	moduleName.text=[NSString stringWithFormat:@"%@ (%@)", mModuleName,mModuleAddress];
	
	NSString *responce=[RootViewController sendCommand:[NSString stringWithFormat:@"%@:status",mModuleAddress ]];
	//responce will contain on off or number (brightness)
	if ([scott doesContainString:@"on" inThisString:responce]) {
		onOff.on=YES;
		brightLabel.text=@"N/A (Appliance module)";
		
		if ([mModuleType isEqualToString:@"L"]) {
			brightness.value=100;
			brightLabel.text=@"Brightness at 100 percent";
		}
	}
	else if ([scott doesContainString:@"off" inThisString:responce]) {
		onOff.on=NO;
		brightness.value=0;
		brightLabel.text=@"Brightness at 0 percent";
		
	} else {
		NSString *bl;
		NSInteger s;
		
		if ([scott doesContainString:@"PERCENT" inThisString:responce]) {
				s=[scott stringPosition:@"PERCENT" inThisString:responce];
		} else {
			s=[scott stringPosition:@"OK" inThisString:responce];
		}
		
		bl=[scott subString:responce startPosition:0 length:s];
		
		onOff.on=YES;
		brightness.value=[bl integerValue];
		brightLabel.text=[NSString stringWithFormat:@"Brightness at %@ percent", bl];
	}
	
	if (![mModuleType isEqualToString:@"L"]) {
		[brightness setEnabled:NO];
		brightness.value=0;
		brightLabel.text=@"N/A (Appliance module)";
		
	} else {
		[brightness setEnabled:YES];
	}

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}


@end
