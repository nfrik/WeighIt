//
//  GetDeviceType.m
//  weigh it
//
//  Created by nikolay on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#include <sys/types.h>
#include <sys/sysctl.h>
#import "GetDeviceType.h"

@implementation GetDeviceType

-(NSString*)machine{
    size_t size;
    
    // Set 'oldp' parameter to NULL to get the size of the data
    // returned so we can allocate appropriate amount of space
    sysctlbyname("hw.machine", NULL, &size, NULL, 0); 
    
    // Allocate the space to store name
    char *name = malloc(size);
    
    // Get the platform name
    sysctlbyname("hw.machine", name, &size, NULL, 0);
    
    // Place name into a string
    NSString *machine = [NSString stringWithCString:name];
    
    // Done with this
    free(name);
    
    return machine;    
}

-(CGPoint)AngleOfView{
    NSString *platform = [self machine];
    CGPoint viewAngle;
    if ([platform isEqualToString:@"iPhone1,1"]) {viewAngle.x=0.0;  viewAngle.y=0.0;}     //iPhone 1G -- NO GYROSCOPE
    if ([platform isEqualToString:@"iPhone1,2"]) {viewAngle.x=0.0;  viewAngle.y=0.0;}     //iPhone 3G -- NO GYROSCOPE
    if ([platform isEqualToString:@"iPhone2,1"]) {viewAngle.x=0.0;  viewAngle.y=0.0;}     //iPhone 3GS -- NO GYROSCOPE
    if ([platform isEqualToString:@"iPhone3,1"]) {viewAngle.x=47.5;  viewAngle.y=60.8;}   //iPhone 4
    if ([platform isEqualToString:@"iPhone3,3"]) {viewAngle.x=47.5;  viewAngle.y=60.8;}   //Verizon iPhone 4
    if ([platform isEqualToString:@"iPhone4,1"]) {viewAngle.x=43.2;  viewAngle.y=55.7;}   //iPhone 4S
    if ([platform isEqualToString:@"iPod1,1"])   {viewAngle.x=0.0;  viewAngle.y=0.0;}     //iPod Touch 1G -- NO CAMERA
    if ([platform isEqualToString:@"iPod2,1"])   {viewAngle.x=0.0;  viewAngle.y=0.0;}     //iPod Touch 2G -- NO CAMERA
    if ([platform isEqualToString:@"iPod3,1"])   {viewAngle.x=0.0;  viewAngle.y=0.0;}     //iPod Touch 3G -- NO CAMERA
    if ([platform isEqualToString:@"iPod4,1"])   {viewAngle.x=36.01;  viewAngle.y=46.68;} //iPod Touch 4G check: http://www.extinguishedscholar.com/wpglob/?p=806
    if ([platform isEqualToString:@"iPad1,1"])   {viewAngle.x=0.0;  viewAngle.y=0.0;}     //iPad -- NO GYROSCOPE
    if ([platform isEqualToString:@"iPad2,1"])   {viewAngle.x=35.3;  viewAngle.y=45.8;}   //iPad 2 (WiFi) check: http://hunter.pairsite.com/blogs/20110317/
    if ([platform isEqualToString:@"iPad2,2"])   {viewAngle.x=35.3;  viewAngle.y=45.8;}   //iPad 2 (GSM) check: http://hunter.pairsite.com/blogs/20110317/
    if ([platform isEqualToString:@"iPad2,3"])   {viewAngle.x=35.3;  viewAngle.y=45.8;}   //iPad 2 (CDMA) check: http://hunter.pairsite.com/blogs/20110317/
    if ([platform isEqualToString:@"iPad3,1"])   {viewAngle.x=47.5;  viewAngle.y=60.8;}     //"iPad-3G (WiFi) check: http://www.digitalcupcake.net/2012/03/17/ipad-3-same-camera-sensors-iphone-4/
    if ([platform isEqualToString:@"iPad3,2"])   {viewAngle.x=47.5;  viewAngle.y=60.8;}     //iPad-3G (4G) check: http://www.digitalcupcake.net/2012/03/17/ipad-3-same-camera-sensors-iphone-4/
    if ([platform isEqualToString:@"iPad3,3"])   {viewAngle.x=47.5;  viewAngle.y=60.8;}     //iPad-3G (4G) check: http://www.digitalcupcake.net/2012/03/17/ipad-3-same-camera-sensors-iphone-4/   
    if ([platform isEqualToString:@"i386"])      {viewAngle.x=0.0;  viewAngle.y=0.0;}     //Simulator
    if ([platform isEqualToString:@"x86_64"])    {viewAngle.x=0.0;  viewAngle.y=0.0;}     //Simulator
    return viewAngle;
}

-(NSString*)getDeviceType{
    NSString *platform = [self machine];
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"Verizon iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2";    
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (CDMA)";
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    return platform;
}

-(BOOL)isDeviceSupported{
    CGPoint aov = [self AngleOfView];
    if (aov.x==0) {
        return FALSE;
    }
    return TRUE;
}

@end
