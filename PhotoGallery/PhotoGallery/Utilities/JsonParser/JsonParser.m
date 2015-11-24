//
//  JsonParser.m
//  PhotoGallery
//
//  Created by Cuelogic on 24/11/15.
//  Copyright © 2015 Cuelogic Technologies. All rights reserved.
//

#import "JsonParser.h"
#import "GalleryModel.h"

@implementation JsonParser

+(id)sharedInstance
{
    static JsonParser *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(NSMutableArray *)parseTheJsonResponse:(id)jsonResponse
{
    NSMutableArray *responseArray = [[NSMutableArray alloc] init];
    if ([jsonResponse isKindOfClass:[NSDictionary class]])
    {
        for (id key in jsonResponse)
        {
            GalleryModel *model = [[GalleryModel alloc] init];
            [model.array addObject:key];
            for (NSDictionary *dic in [jsonResponse objectForKey:key])
            {
                [model.imgArray addObject:dic];
            }
            [responseArray addObject:model];
        }
        
    }
    return responseArray;
}


@end
