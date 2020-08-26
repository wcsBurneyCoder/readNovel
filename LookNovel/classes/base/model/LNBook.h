//
//  LNBook.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/17.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LNBook : NSObject <YYModel, NSCoding>
///主键
@property (nonatomic, copy) NSString *_id;
///封面图片
@property (nonatomic, copy) NSString *cover;
///标题
@property (nonatomic, copy) NSString *title;

@end

