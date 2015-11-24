//
//  GalleryModel.m
//  PhotoGallery
//
//  Created by Cuelogic on 24/11/15.
//  Copyright © 2015 Cuelogic Technologies. All rights reserved.
//

#import "GalleryModel.h"

@implementation GalleryModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.array = [[NSMutableArray alloc] init];
        self.imgArray = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
