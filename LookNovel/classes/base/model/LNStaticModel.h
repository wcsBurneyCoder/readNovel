//
//  LNStaticModel.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/20.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LNStaticModel : NSObject
/**icon*/
@property (nonatomic, copy) NSString *icon;
/**标题*/
@property (nonatomic, copy) NSString *title;
/**cell高度*/
@property (nonatomic, assign) CGFloat cellHeight;
/**需要跳转的类*/
@property (nonatomic) Class destClass;
/**cell类*/
@property (nonatomic) Class cellClass;
/**点击操作*/
@property (nonatomic, copy) void(^operationBlock)(void);
/**扩展信息*/
@property (nonatomic, strong) id extra;

@end
