//
//  YBMarcos.h
//  YBImageBrowser
//
//  Created by Administer on 2022/1/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define kSize(x) ceilf(((x)*[[UIScreen mainScreen] bounds].size.width/375.f))

//获取系统对象
#define kApplication        [UIApplication sharedApplication]
#define kAppWindow          [UIApplication sharedApplication].delegate.window
#define kRootViewController [UIApplication sharedApplication].delegate.window.rootViewController
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]


// main screen's size (portrait)
#ifndef kScreenSize
#define kScreenSize UIScreen.mainScreen.bounds.size
#endif

// main screen's width (portrait)
#ifndef kScreenWidth
#define kScreenWidth kScreenSize.width
#endif

// main screen's height (portrait)
#ifndef kScreenHeight
#define kScreenHeight kScreenSize.height
#endif

/// 设备宽度，跟横竖屏无关
#define kDeviceWidth MIN([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)
/// 设备高度，跟横竖屏无关
#define kDeviceHeight MAX([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)

/// 状态栏高度(来电等情况下，状态栏高度会发生变化，所以应该实时计算，iOS 13 起，来电等情况下状态栏高度不会改变)
#define kStatusBarHeight (UIApplication.sharedApplication.statusBarHidden ? 0 : UIApplication.sharedApplication.statusBarFrame.size.height)
/// navigationBar 的静态高度
#define kNavigationBarHeight 44
/// 代表(导航栏+状态栏)，这里用于获取其高度
#define kNavigationContentTop (kStatusBarHeight + kNavigationBarHeight)
/// iPhoneX 系列全面屏手机的安全区域的静态值
#define kSafeAreaInsetsConstant [UIDevice ybib_safeAreaInsetsForDeviceWithNotch]
//判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//判断iPhone6 6s 7系列
#define kIsIPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)



// TabBar高度
#define kTabBarHeight (49 + kSafeAreaInsetsConstant.bottom)

#define WeakS(ws) __weak __typeof(self) ws = self;
#define StrongS(ss) __strong __typeof(ws)ss = ws;


#pragma mark ————————————————字体————————————————
#define kRegularFont(x)  [UIFont fontWithName:@"PingFangSC-Regular" size:x]
#define kLightFont(x)    [UIFont fontWithName:@"PingFangSC-Light" size:x]
#define kMediumFont(x)   [UIFont fontWithName:@"PingFangSC-Medium" size:x]
#define kSemiboldFont(x) [UIFont systemFontOfSize:x weight:UIFontWeightSemibold]
#define kBoldFont(x)     [UIFont boldSystemFontOfSize:x]

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (YBIBAdd)
+ (UIEdgeInsets)ybib_safeAreaInsetsForDeviceWithNotch;
@end

@interface NSString (YBAdd)

- (BOOL)isNotBlank;

- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

- (CGFloat)widthForFont:(UIFont *)font;

- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width;

@end


@interface UIView (YBAdd)

@property (nonatomic) CGFloat left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  size;        ///< Shortcut for frame.size.

@end


@interface UIColor (YBAdd)

+ (instancetype)colorWithHexString:(NSString *)hexStr;

@end

@interface UIImage (YBAdd)

+ (nullable UIImage *)imageWithSize:(CGSize)size drawBlock:(void (^)(CGContextRef context))drawBlock;

@end



NS_ASSUME_NONNULL_END

