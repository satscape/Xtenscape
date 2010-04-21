//
//  scott.h
//  Xtenscape
//
//  Created by Scott Hather on 28/12/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface scott : NSObject {

}

+(BOOL)doesContainString:(NSString*)thisString inThisString:(NSString*)inThisString;

+(NSInteger)stringPosition:(NSString*)thisString inThisString:(NSString*)inThisString;

+(NSString*)subString:(NSString*)bigString startPosition:(NSInteger)startPosition length:(NSInteger)length;

@end
