//
//  Utils.h
//  Intuit
//
//  Created by Глеб Тарасов on 11.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

typedef void(^BasicBlock)(void);
typedef void(^StringBlock)(NSString *str);
typedef void(^NumberBlock)(NSNumber *num);
typedef void(^ArrayBlock)(NSArray *arr);
typedef void(^DictionaryBlock)(NSDictionary *dict);
typedef void(^SetBlock)(NSSet *set);
typedef void(^ErrorBlock)(NSError *error);

void doAfter(CGFloat delay, BasicBlock action);

#if DEBUG_LOG
#   define log(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define log(...)
#endif


#define APP_VERSION (NSBundle.mainBundle.infoDictionary)[@"CFBundleVersion"]


#import "NimbusCore.h"
#import "NimbusCore+Additions.h"
#import "Reachability.h"
#import "Reachability+P34Utils.h"
#import "EGOCache.h"
#import "UILabel+P34Utils.h"
#import "UITableViewCell+P34Utils.h"


#import "UIViewController+P34Utils.h"
#import "UIView+P34Utils.h"
#import "UIScrollView+P34Utils.h"
#import "UIView+Fading.h"
#import "UIWebView+P34Utils.h"
#import "UITableView+P34Utils.h"
#import "UIImage+P34Utils.h"
#import "UIApplication+P34Utils.h"
#import "UIColor+P34Utils.h"
#import "NSObject+P34Utils.h"
#import "NSString+P34Utils.h"
#import "NSDate+P34Utils.h"
#import "NSMutableString+P34Utils.h"
#import "NSMutableArray+P34Utils.h"
#import "NSArray+P34Utils.h"
#import "NSSet+P34Utils.h"
#import "NSManagedObject+P34Utils.h"
#import "NSFileManager+P34Utils.h"
#import "StringUtils.h"

#import "BlockButton.h"
#import "BlockAlertView.h"
#import "BlockTapGestureRecognizer.h"
#import "BlockSwipeGestureRecognizer.h"
#import "AlignedLabel.h"
#import "ImageViewWithPattern.h"
#import "VideoPlayingResolver.h"
#import "HiddenTabBarController.h"
#import "StretchableImageView.h"
#import "KeyboardListener.h"
#import "LoadingAlertView.h"

#import "DownloadProgress.h"
#import "FilesDownloader.h"
#import "DownloadPortion.h"

#import "Analytics.h"
#import "UIDevice+IdentifierAddition.h"



#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
