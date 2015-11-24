 //
//  ServiceManager.m
//  PhotoGallery
//
//  Created by Cuelogic on 24/11/15.
//  Copyright © 2015 Cuelogic Technologies. All rights reserved.
//

#import "ServiceManager.h"

@implementation ServiceManager

+(id)sharedInstance
{
    static ServiceManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(void)getImagesFromServerWithUrl:(NSString *)url callBackBlock:(CallBackBlock)callBack
{
    _reachability = [Reachability reachabilityForInternetConnection];
    if (!([_reachability currentReachabilityStatus] == NotReachable))
    {
        _reachability = [Reachability reachabilityWithHostName:baseUrl];
        if (!([_reachability currentReachabilityStatus] == NotReachable))
        {
            dispatch_queue_t backgroundQueue = dispatch_queue_create("com.myApp.myQueue", 0);
            __block NSMutableURLRequest *request;
            dispatch_async(backgroundQueue, ^{
               
                request = ({
                   
                    NSURLComponents *components = [NSURLComponents componentsWithString:url];
                    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[components URL]];
                    [request setHTTPMethod:@"GET"];
                    [request setTimeoutInterval:60.0];
                    request;
                });
                [self callTheServiceWithRequest:request callBackBlock:callBack];
            });
        }
        else
        {
            [self problemInConnection:NotReachable callBackBlock:callBack];
        }
    }
    else
    {
        [self problemInConnection:NotReachable callBackBlock:callBack];
    }
}

-(void)callTheServiceWithRequest:(NSMutableURLRequest *)request callBackBlock:(CallBackBlock)callBack
{
    NSURLSessionConfiguration *defaultSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultSessionConfiguration delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    _dataTask = [defaultSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                callBack(data,nil);
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                callBack(nil,error);
            });
        }
    }];
    [_dataTask resume];
}

-(void)problemInConnection:(NSInteger)errorCode callBackBlock:(CallBackBlock)callBack
{
    NSError *error = [NSError errorWithDomain:@"Internet Connection" code:NotReachable userInfo:nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        callBack(nil,error);
    });
}

@end
