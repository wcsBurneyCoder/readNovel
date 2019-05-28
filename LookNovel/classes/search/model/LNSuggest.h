//
//  LNSuggest.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/21.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    LNSuggestTypeNormal,
    LNSuggestTypeAuthor,
    LNSuggestTypeBook
} LNSuggestType;

@interface LNSuggest : NSObject<YYModel>
/**名字*/
@property (nonatomic, copy) NSString *text;
/**标签*/
@property (nonatomic, copy) NSString *tag;
/**类型*/
@property (nonatomic, assign) LNSuggestType type;
/**图标名称*/
@property (nonatomic, copy) NSString *iconName;
/**内容类型*/
@property (nonatomic, copy) NSString *contentType;
/**书Id*/
@property (nonatomic, copy) NSString *Id;
/**作者*/
@property (nonatomic, copy) NSString *author;

@end

NS_ASSUME_NONNULL_END
