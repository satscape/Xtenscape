//
//  scottCell.m
//  Xtenscape
//
//  Created by Scott Hather on 30/12/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "scottCell.h"


@implementation scottCell

- (IBAction)BUTpress {
	NSLog(@"BUT PRESSED");	
}

-(void)setCellProperties:(NSString *)inMainLabel inSubLabel:(NSString *)inSubLabel {
	mainLabel.text=inMainLabel;
	subLabel.text=inSubLabel;
}


- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


@end
