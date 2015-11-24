//
//  ServiceManager.h
//  PhotoGallery
//
//  Created by Cuelogic on 24/11/15.
//  Copyright © 2015 Cuelogic Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "Constant.h"

@interface ServiceManager : NSObject<NSURLSessionDataDelegate>

@property (nonatomic)BOOL isPost;
@property (nonatomic)Methods method;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
@property (nonatomic, strong) Reachability *reachability;

+(id)sharedInstance;
-(void)getImagesFromServerWithUrl:(NSString *)url callBackBlock:(CallBackBlock)callBack;

@end
