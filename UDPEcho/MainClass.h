//
//  MainClass.h
//  UDPEcho
//
//  Created by Matt Zhu on 7/18/14.
//  Copyright (c) 2014 SunlightPhotonics. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <netdb.h>
#import "UDPEcho.h"

@interface MainClass : NSObject <UDPEchoDelegate>

- (BOOL)runServerOnPort:(NSUInteger)port;
- (BOOL)runClientWithHost:(NSString *)host port:(NSUInteger)port;


@end
