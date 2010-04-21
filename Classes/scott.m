//
//  scott.m
//  Xtenscape
//
//  Created by Scott Hather on 28/12/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "scott.h"


@implementation scott

+(BOOL)doesContainString:(NSString*)thisString inThisString:(NSString*)inThisString {
	BOOL ret=NO;
	
	@try {
	NSRange range = [inThisString rangeOfString:thisString];
	if (range.location != NSNotFound) {
		ret=YES;
	} else {
		ret=NO;
	}
	} @catch (NSException *ex) {
		ret=NO;
	} @finally {
		return ret;
	}
}

+(NSInteger)stringPosition:(NSString*)thisString inThisString:(NSString*)inThisString{
	NSInteger ret=-1;
	
	@try {
	NSRange range = [inThisString rangeOfString:thisString];
	ret= range.location;
	
	} @catch (NSException *ex) {
		ret= -1;
	} @finally {
		return ret;
	}
}

+(NSString*)subString:(NSString*)bigString startPosition:(NSInteger)startPosition length:(NSInteger)length {
	NSString *ret=@"";
	
	@try {
		NSRange range;
		range.location=startPosition;
		range.length=length;
		
		ret= [bigString substringWithRange:range];
	} @catch (NSException *ex) {
		ret=@"";
	} @finally {
		return ret;
	}
}


@end
