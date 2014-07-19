//
//  XYZViewController.m
//  UDPEcho
//
//  Created by Matt Zhu on 7/18/14.
//  Copyright (c) 2014 SunlightPhotonics. All rights reserved.
//

#import "XYZViewController.h"
#import "MainClass.h"

@interface XYZViewController ()

@end

@implementation XYZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    char **argv = (char *[]){"UDPEcho", "192.168.20.3", "7777"};
//    [self startProgram:argv];
    char **argv = (char *[]){"UDPEcho", "-l", "7776"};
    [self startProgram:argv];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startProgram:(char **)argv
{
    int argc = 3;
    int                 retVal;
    BOOL                success;
    MainClass *              mainObj;
    int                 port;
    
    @autoreleasepool {
        retVal = EXIT_FAILURE;
        success = YES;
        if ( (argc >= 2) && (argc <= 3) ) {
            if (argc == 3) {
                port = atoi(argv[2]);
            } else {
                port = 7;
            }
            if ( (port > 0) && (port < 65536) ) {
                if (strcmp(argv[1], "-l") == 0) {
                    retVal = EXIT_SUCCESS;
                    
                    // server mode
                    
                    mainObj = [[MainClass alloc] init];
                    assert(mainObj != nil);
                    
                    success = [mainObj runServerOnPort:(NSUInteger) port];
                } else {
                    NSString *  hostName;
                    
                    hostName = [NSString stringWithUTF8String:argv[1]];
                    if (hostName == nil) {
                        fprintf(stderr, "%s: invalid host host: %s\n", getprogname(), argv[1]);
                    } else {
                        retVal = EXIT_SUCCESS;
                        
                        // client mode
                        
                        mainObj = [[MainClass alloc] init];
                        assert(mainObj != nil);
                        
                        success = [mainObj runClientWithHost:hostName port:(NSUInteger) port];
                    }
                }
            }
        }
        
        if (success) {
            if (retVal == EXIT_FAILURE) {
                fprintf(stderr, "usage: %s -l [port]\n",   getprogname());
                fprintf(stderr, "       %s host [port]\n", getprogname());
            }
        } else {
            retVal = EXIT_FAILURE;
        }
    }
}

@end
