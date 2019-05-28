//
//  LNClassifyBookModel.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/16.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LNBook.h"

NS_ASSUME_NONNULL_BEGIN

@interface LNClassifyBookModel : LNBook
@property (nonatomic, assign) BOOL allowMonthly;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, assign) NSInteger banned;
@property (nonatomic, copy) NSString *contentType;
@property (nonatomic, copy) NSString *lastChapter;
@property (nonatomic, assign) NSInteger latelyFollower;
@property (nonatomic, copy) NSString *majorCate;
@property (nonatomic, copy) NSString *minorCate;
@property (nonatomic, assign) float retentionRatio;
@property (nonatomic, copy) NSString *shortIntro;
@property (nonatomic, copy) NSString *site;
@property (nonatomic, assign) NSInteger sizetype;
@property (nonatomic, copy) NSString *superscript;
@property (nonatomic, strong) NSArray<NSString *> *tags;
@end

NS_ASSUME_NONNULL_END
