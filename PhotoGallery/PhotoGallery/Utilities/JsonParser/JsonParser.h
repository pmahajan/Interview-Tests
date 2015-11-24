//
//  JsonParser.h
//  PhotoGallery
//
//  Created by Cuelogic on 24/11/15.
//  Copyright © 2015 Cuelogic Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonParser : NSObject

+(id)sharedInstance;
-(NSMutableArray *)parseTheJsonResponse:(id)jsonResponse;


@end
