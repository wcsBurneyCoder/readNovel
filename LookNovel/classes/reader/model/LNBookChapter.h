//
//  LNBookChapter.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/10.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LNBookContent.h"

NS_ASSUME_NONNULL_BEGIN

@interface LNBookChapter : NSObject <YYModel, NSCoding>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *Id;
/**章节的内容*/
@property (nonatomic, strong) LNBookContent *content;
/**序号*/
@property (nonatomic, strong) NSNumber *sort;

@property (nonatomic, assign) BOOL isCurrent;
@end

NS_ASSUME_NONNULL_END
