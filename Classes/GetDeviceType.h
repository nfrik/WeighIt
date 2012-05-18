//
//  GetDeviceType.h
//  weigh it
//
//  Created by nikolay on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetDeviceType : NSObject

-(NSString*)machine;
-(CGPoint)AngleOfView;
-(BOOL)isDeviceSupported;
-(NSString*)getDeviceType;

@end
