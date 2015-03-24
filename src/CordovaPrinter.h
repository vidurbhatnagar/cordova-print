//
//  CordovaPrinter.h
//  HelloCordova
//
//  Created by Liam Bateman on 24/03/2015.
//
//

#import <Cordova/CDVPlugin.h>

@interface CordovaPrinter : CDVPlugin
- (BOOL) cordovaPrint :(NSString *)labelData;
@end
