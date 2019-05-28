//
//  LNBaseCollectionViewCell.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/10.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LNBaseCollectionViewCell : UICollectionViewCell

+ (instancetype)cellForCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;
@end

