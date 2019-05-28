//
//  LNRecommnadBook.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/9.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LNBook.h"

NS_ASSUME_NONNULL_BEGIN

@interface LNRecommnadBook : LNBook

@property (nonatomic, assign) BOOL allowMonthly;
///作者
@property (nonatomic, copy) NSString *author;
@property (nonatomic, assign) NSInteger banned;
///最近的粉丝数
@property (nonatomic, assign) NSInteger latelyFollower;
///一级分类
@property (nonatomic, copy) NSString *majorCate;
///二级分类
@property (nonatomic, copy) NSString *minorCate;
///评分
@property (nonatomic, copy) NSString *retentionRatio;
///内容介绍
@property (nonatomic, copy) NSString *shortIntro;
///来源站点
@property (nonatomic, copy) NSString *site;

@end

NS_ASSUME_NONNULL_END
