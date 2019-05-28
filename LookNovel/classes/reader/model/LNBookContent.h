//
//  LNBookContent.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/10.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LNBookContent : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger chapterOrder;
@property (nonatomic, copy) NSString *body;

@property (nonatomic, strong) NSAttributedString *titleAttribute;
@property (nonatomic, strong) NSAttributedString *bodyAttribute;

@property (nonatomic, strong) NSNumber *cellHeight;
@end
