//
//  LNSkinHelper.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/9.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNSkinHelper.h"

@implementation LNSkin

@end

@implementation LNReaderSkin

- (BOOL)isEqual:(LNReaderSkin *)object
{
    return [self.Id isEqualToString:object.Id];
}

@end

@implementation LNSkinHelper

singletonM(Helper)

+ (void)load
{
    LNSkinHelper *helper = [self sharedHelper];
    NSString *themeName = [[NSUserDefaults standardUserDefaults] stringForKey:appThemeKey]?:@"LNNormalTheme";
    helper.currentSkin = [helper skinWithFileName:themeName];
    
    NSArray *list = [helper readerAllSkinList];
    helper.nightModeSkin = list.firstObject;
    helper.dayModeSkin = [list objectAtIndex:3];
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] dictionaryForKey:LNReaderSkinKey];
    if (dict) {
        helper.currentReaderSkin = [LNReaderSkin modelWithDictionary:dict];
    }
    else{
        helper.currentReaderSkin = helper.dayModeSkin;
    }
    helper.readerSkinList = [list subarrayWithRange:NSMakeRange(1, list.count - 1)];
}

- (LNSkin *)skinWithFileName:(NSString *)fileName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    if (path == nil) {
        NSString *cachePath = cacheFilePathWithCompentPath([NSString stringWithFormat:@"skin/%@",fileName]);
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            path = cachePath;
        }
    }
    if (path == nil) {
        return nil;
    }
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [data jsonValueDecoded];
    LNSkin *skin = [LNSkin modelWithDictionary:dict];
    return skin;
}

- (NSArray *)readerAllSkinList
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"LNReadTheme" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *list = [data jsonValueDecoded];
    return [NSArray modelArrayWithClass:[LNReaderSkin class] json:list];
}

- (void)saveCurrentReaderSkin
{
    NSDictionary *dict = [self.currentReaderSkin modelToJSONObject];
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:LNReaderSkinKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
