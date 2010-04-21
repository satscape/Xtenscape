//
//  RootViewController.m
//  Xtenscape
//
//  Created by Scott Hather on 15/12/2008.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "RootViewController.h"
#import "XtenscapeAppDelegate.h"
#import "scott.h"
#import "AdMobView.h"

@implementation RootViewController

@synthesize mySettingsViewController;
@synthesize myHelpViewController;
@synthesize myControlViewController;

+(NSString*)sendCommand:(NSString*)command {
	NSString *myURL;
	NSString *IP;
	NSString *port;
	NSString *pass;
	NSURL *url;
	NSString *myResponse;
	
	NSRange r=[command rangeOfString:@":status"];
	if ([command isEqualToString:lastCommandSent] && r.location>200 ) { return @"OK"; }

	lastCommandSent=command;
	[lastCommandSent retain];
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	
	if ([[prefs stringForKey:@"LANIP"] isEqualToString:@""]) {
		return @"INIT";
	}
	
	if ([prefs boolForKey:@"internetMode"]==YES) {
		IP=[prefs stringForKey:@"internetIP"];
		port=[prefs stringForKey:@"internetPort"];
	} else {
		IP=[prefs stringForKey:@"LANIP"];
		port=[prefs stringForKey:@"LANport"];
	}
	
	pass=[prefs stringForKey:@"thePassword"];
	
	myURL=[NSString stringWithFormat:@"http://%@:%@/%@:%@",IP,port,pass,command];
	url = [ NSURL URLWithString:myURL ] ;
	myResponse = [ NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding  error:nil ] ;
	
	if (myResponse==nil) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Connection" message:@"Could not connect to Xtenscape server" delegate:self cancelButtonTitle:@"Help!" otherButtonTitles: @"Go to Settings", nil];
		[alert show];
		[alert release];
		return @"ERROR - Could not connect to Xtenscape server;";
	}
	
	NSLog([NSString stringWithFormat:@"Command Sent:%@ - Response:%@",myURL,myResponse]);
	return myResponse;
}

//NO CONNECTION ALERT HANDLER
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
		
	
	if (buttonIndex == 0)
	{
		[self BUThelp];
	}
	else
	{
		[self BUTsettings];
	}
}

-(void)loadModuleList{
	NSLog(@"loadModuleList starting");
	mModuleCount=0;
	
	NSString *myResponse=[RootViewController sendCommand:@"list::"];
	NSString *temp;
	
		@try {
			
	//K6:Living room lamp:L;
	if ([scott doesContainString:@"nvalid" inThisString:myResponse]==YES || myResponse==@"") {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password error" message:@"Your Password is not correct" delegate:self cancelButtonTitle:@"Help!" otherButtonTitles: @"Go to Settings", nil];
		[alert show];
		[alert release];
		return;
	}
			if ( myResponse==@"INIT") {
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome" message:@"This is the first time you have ran this app, you will need to go to the settings to set it up before you can use it" delegate:self cancelButtonTitle:@"Help!" 
otherButtonTitles: @"Go to Settings", nil];
				[alert show];
				[alert release];
				return;
			}
	
			if ([scott doesContainString:@"ERROR" inThisString:myResponse]==YES) {
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:myResponse delegate:self cancelButtonTitle:@"Help!" otherButtonTitles: @"Go to Settings", nil];
				[alert show];
				[alert release];
				return;
			}

	
	temp=[myResponse substringToIndex:[myResponse length]-5];  //remove the OK CR LF
	NSArray *a=[temp componentsSeparatedByString:@";"];
	mModuleCount=[a count];
	

		
		
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	[prefs setObject:temp forKey:@"ModuleList"];

	} @catch (NSException *ex) {
		mModuleCount=0;
	} @finally {
		
	}
	
}


//  field : 0 is address   1 is name   2 is A or L
-(NSString*)getModuleField:(NSInteger)fieldNumber moduleIndex:(NSInteger)moduleIndex{
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSString *ModuleList = [prefs stringForKey:@"ModuleList"];
	
	NSString *full;
	
	NSArray *a= [ModuleList componentsSeparatedByString: @";"];   //<<<<<
	full=[a objectAtIndex:moduleIndex];
	
	NSArray *b=[full componentsSeparatedByString:@":"];
	NSString *fuck=[b objectAtIndex:fieldNumber];
	return fuck;
}

- (IBAction)BUThelp{
	if (self.myHelpViewController==nil) {
		HelpViewController *view2=[[HelpViewController alloc] initWithNibName:@"HelpViewController" bundle:[NSBundle mainBundle]];
		self.myHelpViewController=view2;
		[view2 release];
	}
	[self.navigationController pushViewController:self.myHelpViewController  animated:YES];
}


- (IBAction)BUTsettings{
	if (self.mySettingsViewController==nil) {
		SettingsViewController *view2=[[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:[NSBundle mainBundle]];
		self.mySettingsViewController=view2;
		[view2 release];
	}
	[self.navigationController pushViewController:self.mySettingsViewController  animated:YES];	
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Xtenscape";
	[self loadModuleList]; //grabs module list from Xtenscape over lan/wan and stores in user pref
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	[prefs setBool:NO forKey:@"reloadModuleList"];
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}


- (void)viewDidAppear:(BOOL)animated {
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	
	//only refresh each 'appear' when coming from the Settings View (just in case something changed)
	if ([prefs boolForKey:@"reloadModuleList"]==YES) {
		[prefs setBool:NO forKey:@"reloadModuleList"];
		lastCommandSent=@"xxx";
		[self loadModuleList];
	}
	
	[myTableView reloadData];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

		return mModuleCount;

}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
	static NSString *CellIdentifier = @"Cell";


	//Just a normal tableCell
    cell = ((scottCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier]);
    if (cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"scottCell" owner:self options:nil];
    }

	NSString *mName=[self getModuleField:1 moduleIndex:indexPath.row];
	NSString *mAddress=[self getModuleField:0 moduleIndex:indexPath.row];
	NSString *mType=[self getModuleField:2 moduleIndex:indexPath.row];
	if ([mType isEqualToString:@"L"]) {
		mType=@"Lamp Module";
	} else {
		mType=@"Appliance Module";
	}
	
    [cell setCellProperties:mName inSubLabel:[NSString stringWithFormat:@"Address : %@ - %@", mAddress,mType]];

	return cell;

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
	if (self.myControlViewController==nil) {
		ControlViewController *view2=[[ControlViewController alloc] initWithNibName:@"ControlViewController" bundle:[NSBundle mainBundle]];
		self.myControlViewController=view2;
		[view2 release];
	}
	self.myControlViewController.mModuleName=[self getModuleField:1 moduleIndex: indexPath.row];
	self.myControlViewController.mModuleAddress=[self getModuleField:0 moduleIndex:indexPath.row];
	self.myControlViewController.mModuleType=[self getModuleField:2 moduleIndex:indexPath.row];
	
	[self.navigationController pushViewController:self.myControlViewController  animated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	CGFloat f=48.0;
	return f;
}

/*
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"will select event");	
	return indexPath;
}
*/

- (void)dealloc {
    [super dealloc];
}





@end

