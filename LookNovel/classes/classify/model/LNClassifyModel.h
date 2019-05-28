//
//  LNClassifyModel.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/15.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LNClassifyModel : NSObject
/**名称*/
@property (nonatomic, copy) NSString *name;
/**书籍数量*/
@property (nonatomic, assign) NSInteger bookCount;
/**月票数量*/
@property (nonatomic, assign) NSInteger monthlyCount;
/**图标*/
@property (nonatomic, copy) NSString *icon;
/**书籍cover*/
@property (nonatomic, strong) NSArray<NSString *> *bookCover;
@end

@interface LNClassifyGroupModel : NSObject
/**名称*/
@property (nonatomic, copy) NSString *name;
/**名称key*/
@property (nonatomic, copy) NSString *key;
/**是否选中*/
@property (nonatomic, assign) BOOL selected;
@end

NS_ASSUME_NONNULL_END
