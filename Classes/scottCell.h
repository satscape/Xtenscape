//
//  scottCell.h
//  Xtenscape
//
//  Created by Scott Hather on 30/12/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface scottCell : UITableViewCell {
IBOutlet UIImageView *imageOnOff;
IBOutlet UILabel *mainLabel;
IBOutlet UILabel *subLabel;
}

- (IBAction)BUTpress;

-(void)setCellProperties:(NSString *)inMainLabel inSubLabel:(NSString *)inSubLabel;

@end
