//
//  TableViewCell.m
//  PhotoGallery
//
//  Created by Cuelogic on 24/11/15.
//  Copyright © 2015 Cuelogic Technologies. All rights reserved.
//

#import "TableViewCell.h"
#import "ViewController.h"
#import "CollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "Constant.h"

static NSString *collectionCellIdentifier = @"collectionCell";
@interface TableViewCell()<UICollectionViewDelegate, UICollectionViewDataSource,viewControllerDelegate>
@property (nonatomic)id<viewControllerDelegate>delegate;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic)NSMutableArray *imageArray;

@end


@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    flowLayout.itemSize = CGSizeMake(130, 125);
    [_collectionView setCollectionViewLayout:flowLayout];
}

-(void)setCollectionData:(NSMutableArray *)arrayData
{
    _imageArray = arrayData;
    [_collectionView setContentOffset:CGPointZero animated:NO];
    [_collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_imageArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionCellIdentifier forIndexPath:indexPath];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseUrl,[[_imageArray objectAtIndex:indexPath.row] objectForKey:@"imgURL"]]];
    [cell.cellImage sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        cell.cellImage.image = image;
    }];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:cell.cellImage.image,@"image", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"image" object:self userInfo:dic];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
