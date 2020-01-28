/********* curlrequest.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>

@interface curlrequest : CDVPlugin {
  // Member variables go here.
}

- (void)curl:(CDVInvokedUrlCommand*)command;
@end

@implementation curlrequest

- (void)curl:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* echo = [command.arguments objectAtIndex:0];

    NSURL *url = [NSURL URLWithString: echo];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    NSError *error;
    NSURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];

    if (data != nil && [data length] > 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:data];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
