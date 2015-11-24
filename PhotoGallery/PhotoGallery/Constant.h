//
//  Constant.h
//  PhotoGallery
//
//  Created by Cuelogic on 24/11/15.
//  Copyright © 2015 Cuelogic Technologies. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

#define baseUrl @"http://192.168.10.104/"
static NSString *endString = @"imageData.php";

typedef enum
{
    GET,
    POST,
    PUT,
} Methods;

typedef void(^CallBackBlock)(NSData *jsonData, NSError *error);
//typedef void(^ErrorBlock)(NSError *error);


#endif /* Constant_h */
