//
//  LNBaseCollectionViewCell.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/10.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBaseCollectionViewCell.h"

@implementation LNBaseCollectionViewCell

+ (instancetype)cellForCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifer = NSStringFromClass([self class]);
    if ([self viewFromNib]) {
        [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil] forCellWithReuseIdentifier:cellIdentifer];
    }
    else
        [collectionView registerClass:[self class] forCellWithReuseIdentifier:cellIdentifer];
    
    LNBaseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifer forIndexPath:indexPath];
    return cell;
}

@end
