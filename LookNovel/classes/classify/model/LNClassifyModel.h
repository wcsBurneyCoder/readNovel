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
/**ID*/
@property (nonatomic, copy) NSString *categoryId;
/**名称*/
@property (nonatomic, copy) NSString *categoryName;
/**书籍cover*/
@property (nonatomic, strong) NSArray<NSString *> *coverImgs;
@end

@interface LNClassifyGroupModel : NSObject <YYModel>
/**名称*/
@property (nonatomic, copy) NSString *channelName;
/**名称key*/
@property (nonatomic, copy) NSString *channelId;
/**是否选中*/
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, strong) NSArray<LNClassifyModel *> *categories;
@end

NS_ASSUME_NONNULL_END
