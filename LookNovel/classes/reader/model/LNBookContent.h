//
//  LNBookContent.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/10.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LNBookContent : NSObject <YYModel, NSCoding>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *chapterId;
@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) NSAttributedString *titleAttribute;
@property (nonatomic, strong) NSAttributedString *bodyAttribute;

@property (nonatomic, strong) NSNumber *cellHeight;
@end
