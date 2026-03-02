//
//  YBIBImageScrollView.m
//  YBImageBrowserDemo
//
//  Created by 波儿菜 on 2019/6/10.
//  Copyright © 2019 波儿菜. All rights reserved.
//

#import "YBMarcos.h"
#import "YBIBImageScrollView.h"
#import "YBImageBrowser.h"

@interface YBIBImageScrollView ()
@property (nonatomic, strong) YYAnimatedImageView *imageView;
@property (nonatomic, strong) UIImageView *waterImageView;
@property (nonatomic, strong) UILabel *waterText;
@property (nonatomic, strong) UIView *waterTextBG;
@end

@implementation YBIBImageScrollView

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.maximumZoomScale = 1;
        self.minimumZoomScale = 1;
        self.alwaysBounceHorizontal = NO;
        self.alwaysBounceVertical = NO;
        self.layer.masksToBounds = NO;
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }

        [self addSubview:self.imageView];
        [self.imageView addSubview:self.waterImageView];
        self.waterImageView.frame = CGRectMake(0, 0, kSize(74), kSize(20));
        [self.imageView addSubview:self.waterTextBG];
        [self.imageView addSubview:self.waterText];
        self.waterTextBG.hidden = YES;
        [kNotificationCenter addObserver:self selector:@selector(noti_refreshWaterNick:) name:@"kNotificationScanUserMedia" object:nil];
    }
    return self;
}

- (void)noti_refreshWaterNick:(NSNotification *)notice {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([notice.object isKindOfClass:[NSString class]]) {
            if (self.userNick.isNotBlank) {
                self.waterText.text = [NSString stringWithFormat:@"@%@", self.userNick];
                self.waterTextBG.hidden = self.waterText.text.length <= 0;
            } else {
                self.waterText.text = @"";
                self.waterTextBG.hidden = self.waterText.text.length <= 0;
            }
        } else {
            self.waterText.text = @"";
            self.waterTextBG.hidden = self.waterText.text.length <= 0;
        }
        
        UIImage *image = self.imageView.image;
        if (!image) {
            self.waterImageView.hidden = YES;
            self.waterText.hidden = YES;
            self.waterTextBG.hidden = YES;
            return;
        }
        CGFloat trueWidth = image.size.width / image.size.height * kScreenHeight;
        trueWidth = trueWidth > kScreenWidth ? kScreenWidth : trueWidth;
        CGFloat trueHeight = trueWidth * image.size.height / image.size.width;
        CGFloat p = trueWidth / kScreenWidth;
        
        self.waterImageView.image = [UIImage imageNamed:[YBImageBrowser yb_waterImageName]];
        self.waterImageView.frame = CGRectMake(trueWidth - (kSize(65) + kSize(16)) * p, trueHeight - (kSize(8) + kSize(20)) * p, kSize(74) * p, kSize(20) * p);
        self.waterText.font = kSemiboldFont(kSize(14));
        CGFloat width = [self.waterText.text sizeForFont:self.waterText.font size:CGSizeMake(MAXFLOAT, kSize(34)) mode:(NSLineBreakByWordWrapping)].width;
        self.waterText.frame = CGRectMake((kSize(16) + kSize(10)) * p, self.waterImageView.top, (width + kSize(4)) * p, self.waterImageView.height);
        self.waterText.font = kSemiboldFont(kSize(14) * p);
        self.waterTextBG.frame = CGRectMake(self.waterText.left - kSize(10) * p, self.waterText.top, self.waterText.width + kSize(20) * p, self.waterText.height);
        
        self.waterImageView.hidden = NO;
        self.waterText.hidden = NO;
        self.waterTextBG.hidden = self.waterText.text.length <= 0;
    });
}

#pragma mark - public

- (void)setImage:(__kindof UIImage *)image type:(YBIBScrollImageType)type {
    self.imageView.image = image;
    self.imageType = type;
    
    if (self.userNick.isNotBlank) {
        self.waterText.text = [NSString stringWithFormat:@"@%@", self.userNick];
        self.waterTextBG.hidden = self.waterText.text.length <= 0;
    }
    
    if (!image) {
        self.waterImageView.hidden = YES;
        self.waterText.hidden = YES;
        self.waterTextBG.hidden = YES;
        return;
    }
    
    CGFloat trueWidth = image.size.width / image.size.height * kScreenHeight;
    trueWidth = trueWidth > kScreenWidth ? kScreenWidth : trueWidth;
    CGFloat trueHeight = trueWidth * image.size.height / image.size.width;
    CGFloat p = trueWidth / kScreenWidth;
    
    self.waterImageView.image = [UIImage imageNamed:[YBImageBrowser yb_waterImageName]];
    self.waterImageView.frame = CGRectMake(trueWidth - (kSize(65) + kSize(16)) * p, trueHeight - (kSize(8) + kSize(20)) * p, kSize(74) * p, kSize(20) * p);
    self.waterText.font = kSemiboldFont(kSize(14));
    CGFloat width = [self.waterText.text sizeForFont:self.waterText.font size:CGSizeMake(MAXFLOAT, kSize(34)) mode:(NSLineBreakByWordWrapping)].width;
    self.waterText.frame = CGRectMake((kSize(16) + kSize(10)) * p, self.waterImageView.top, (width + kSize(4)) * p, self.waterImageView.height);
    self.waterTextBG.frame = CGRectMake(self.waterText.left - kSize(10) * p, self.waterText.top, self.waterText.width + kSize(20) * p, self.waterText.height);
    self.waterText.font = kSemiboldFont(kSize(14) * p);
    self.waterImageView.hidden = NO;
    self.waterText.hidden = NO;
    self.waterTextBG.hidden = self.waterText.text.length <= 0;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    if (self.userNick.isNotBlank) {
        self.waterText.text = [NSString stringWithFormat:@"@%@", self.userNick];
        self.waterTextBG.hidden = self.waterText.text.length <= 0;
    }
    
    UIImage *image = self.imageView.image;
    if (!image) {
        self.waterImageView.hidden = YES;
        self.waterText.hidden = YES;
        self.waterTextBG.hidden = YES;
        return;
    }
    CGFloat trueWidth = image.size.width / image.size.height * kScreenHeight;
    trueWidth = trueWidth > kScreenWidth ? kScreenWidth : trueWidth;
    CGFloat trueHeight = trueWidth * image.size.height / image.size.width;
    CGFloat p = trueWidth / kScreenWidth;
    p = p > 1 ? 1 : p;
    
    self.waterImageView.image = [UIImage imageNamed:[YBImageBrowser yb_waterImageName]];
    self.waterImageView.frame = CGRectMake(trueWidth - (kSize(65) + kSize(16)) * p, trueHeight - (kSize(8) + kSize(20)) * p, kSize(74) * p, kSize(20) * p);
    self.waterText.font = kSemiboldFont(kSize(14));
    CGFloat width = [self.waterText.text sizeForFont:self.waterText.font size:CGSizeMake(MAXFLOAT, kSize(34)) mode:(NSLineBreakByWordWrapping)].width;
    self.waterText.frame = CGRectMake((kSize(16) + kSize(10)) * p, self.waterImageView.top, (width + kSize(4)) * p, self.waterImageView.height);
    self.waterTextBG.frame = CGRectMake(self.waterText.left - kSize(10) * p, self.waterText.top, self.waterText.width + kSize(20) * p, self.waterText.height);
    self.waterText.font = kSemiboldFont(kSize(14) * p);
    self.waterImageView.hidden = NO;
    self.waterText.hidden = NO;
    self.waterTextBG.hidden = self.waterText.text.length <= 0;
}

- (void)reset {
    self.zoomScale = 1;
    self.imageView.image = nil;
    self.imageType = YBIBScrollImageTypeNone;
    self.waterImageView.hidden = YES;
    self.waterText.hidden = YES;
    self.waterTextBG.hidden = YES;
}

#pragma mark - getters

- (YYAnimatedImageView *)imageView {
    if (!_imageView) {
        _imageView = [YYAnimatedImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.layer.masksToBounds = YES;
    }
    return _imageView;
}

- (UIImageView *)waterImageView {
    if (!_waterImageView) {
        _waterImageView = [[UIImageView alloc] init];
        _waterImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _waterImageView;
}

- (UILabel *)waterText {
    if (!_waterText) {
        _waterText = [[UILabel alloc] init];
        _waterText.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
        _waterText.font = kSemiboldFont(kSize(14));
        [_waterText setAlpha:0];
    }
    return _waterText;
}

- (UIView *)waterTextBG {
    if (!_waterTextBG) {
        _waterTextBG = [[UIView alloc] init];
        _waterTextBG.clipsToBounds = YES;
        _waterTextBG.layer.cornerRadius = kSize(17);
        _waterTextBG.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        [_waterTextBG setAlpha:0];
    }
    return _waterTextBG;
}

@end
