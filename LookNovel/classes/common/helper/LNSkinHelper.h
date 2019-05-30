//
//  LNSkinHelper.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/9.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "singleton.h"

@interface LNSkin : NSObject
@property (nonatomic, copy) NSString *appMainColor;
@property (nonatomic, copy) NSString *tabBarOneNormalImage;
@property (nonatomic, copy) NSString *tabBarOneSelectImage;
@property (nonatomic, copy) NSString *tabBarThreeNormalImage;
@property (nonatomic, copy) NSString *tabBarThreeSelectImage;
@property (nonatomic, copy) NSString *tabBarTitleNormalColor;
@property (nonatomic, copy) NSString *tabBarTitleSelectColor;
@property (nonatomic, copy) NSString *tabBarTwoNormalImage;
@property (nonatomic, copy) NSString *tabBarTwoSelectImage;
@end

@interface LNReaderSkin : NSObject

@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *normalIcon;
@property (nonatomic, copy) NSString *selectIcon;
@property (nonatomic, copy) NSString *color;
@property (nonatomic, copy) NSString *controlViewBgColor;
@property (nonatomic, copy) NSString *textColor;
@property (nonatomic, copy) NSString *settingTextColor;
@property (nonatomic, copy) NSString *sliderThumb;
@property (nonatomic, copy) NSString *settingBtnColor;
@property (nonatomic, copy) NSString *bgImage;
@property (nonatomic, copy) NSString *chapterColor;
@property (nonatomic, copy) NSString *sourceColor;
@end

@interface LNSkinHelper : NSObject

/**当前的skin*/
@property (nonatomic, strong) LNSkin *currentSkin;
/**当前的skin*/
@property (nonatomic, strong) LNReaderSkin *currentReaderSkin;
@property (nonatomic, strong) LNReaderSkin *dayModeSkin;
@property (nonatomic, strong) LNReaderSkin *nightModeSkin;
@property (nonatomic, strong) NSArray<LNReaderSkin *> *readerSkinList;

singletonH(Helper)

- (LNSkin *)skinWithFileName:(NSString *)fileName;

- (void)saveCurrentReaderSkin;

@end
