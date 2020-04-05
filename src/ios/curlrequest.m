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
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"curl/7.54.0" forHTTPHeaderField:@"User-Agent"];

    NSError *error;
    NSURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString* result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    

    if (data != nil && [data length] > 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
