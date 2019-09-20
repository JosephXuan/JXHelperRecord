//
//  RTProgressView.m
//  RTProgressView
//
//  Created by ROOT on 16/6/22.
//  Copyright © 2016年 root. All rights reserved.
//

#import "RTProgressView.h"

#define kOrange [UIColor colorWithRed:228/255.0 green:141/255.0 blue:70/255.0 alpha:1.0]
#define kGreen  [UIColor colorWithRed:110/255.0 green:152/255.0 blue:114/255.0 alpha:1.0]
#define kRed    [UIColor colorWithRed:222/255.0 green:106/255.0 blue:83/255.0 alpha:1.0]
#define kGray   [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0]
#define kLineGray [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1.0]

typedef NS_ENUM(NSInteger,kProgressType) {
    
    kProgressTypeFirst = 0,
    kProgressTypePassNormal,
    kProgressTypePassError,
    kProgressTypeCurrentNormal,
    kProgressTypeCurrentError,
    kProgressTypeWarning,
    kProgressTypeEnd
    
};
static CGFloat const topMargin      = 10.0f;
static CGFloat const leftMargin     = 10.0f;
static CGFloat const rightMargin    = 10.0f;
static CGFloat const baseMargin     = 10.0f;

@interface RTProgressView ()

@property (nonatomic, assign) NSInteger titleCount; //记录 title 数组的个数
@property (nonatomic, strong) NSArray *warningArr;    // 高亮信息数组
@property (nonatomic, assign) NSInteger nodeOrdinal;  // 当前节点序号
@property (nonatomic, assign) BOOL statusCodeError;     // 当前节点是否错误

@end

@implementation RTProgressView

#pragma mark -show progressView
- (void)showProgressViewWithTitleArray:(NSArray *)titleArr detailArray:(NSArray *)detailArr isHorizontal:(BOOL)isHorizontal style:(kProgressStyle)style{
    
    self.titleCount = titleArr.count>detailArr.count?titleArr.count:detailArr.count;
    
    if (isHorizontal) {
        
        [self showProgressViewHorizontalWithTitleArray:titleArr detailArray:detailArr style:style];
        
    }else {
        
        [self showProgressViewVerticalWithTitleArray:titleArr detailArray:detailArr style:style];
    }
}


#pragma mark - set errorArr
- (void)setWarningArray:(NSArray *)warningArr {
    
    self.warningArr = warningArr;
}

#pragma mark - set node
- (void)setNodeOrdinal:(NSInteger)nodeOrdinal statusCodeError:(BOOL)statusCodeError {
    
    self.nodeOrdinal = nodeOrdinal;
    self.statusCodeError = statusCodeError;
}

#pragma mark -show progressView horizontal
- (void)showProgressViewHorizontalWithTitleArray:(NSArray *)titleArr detailArray:(NSArray *)detailArr style:(kProgressStyle)style{
    
    CGFloat singleWidth = self.bounds.size.width / self.titleCount;
    CGFloat singleHeight = self.bounds.size.height - topMargin;
    CGFloat y = 0;
    
    NSString *titleStr = @"";
    NSString *detailStr = @"";
    
    for (int i=0; i<self.titleCount; i++) {
        
        CGFloat x = i * singleWidth;
        CGRect frame = CGRectMake(x, y, singleWidth, singleHeight);
        
        if (titleArr[i]) {
            titleStr = titleArr[i];
        }
        if (detailArr[i]) {
            detailStr = detailArr[i];
        }
        
        bool isFirst = i==0?YES:NO;
        bool isEnd = i==self.titleCount-1?YES:NO;
        bool isWarning = ([self.warningArr containsObject:titleStr] || [self.warningArr containsObject:detailStr])==1?YES:NO;
        for (int i=0; i<self.warningArr.count; i++) {
            if ([titleStr containsString:self.warningArr[i]]||[detailStr containsString:self.warningArr[i]]) {
                isWarning = YES;
            }
        }
        
        if (style == kProgressStyleSpecial) {
            
            if (self.statusCodeError) {
                
                if (i==self.nodeOrdinal) {
                    
                    [self singleViewWithFrame:frame titleStr:titleStr detailStr:detailStr model:kProgressTypeCurrentError isFirst:isFirst isEnd:isEnd isHorizontal:YES style:style];
                    
                }else {
                    
                    [self singleViewWithFrame:frame titleStr:titleStr detailStr:detailStr model:kProgressTypePassError isFirst:isFirst isEnd:isEnd isHorizontal:YES style:style];
                }
            } else {
                
                if (i==self.nodeOrdinal) {
                    
                    [self singleViewWithFrame:frame titleStr:titleStr detailStr:detailStr model:kProgressTypeCurrentNormal isFirst:isFirst isEnd:isEnd isHorizontal:YES style:style];
                    
                }else if (isEnd||i>self.nodeOrdinal) {
                    
                    [self singleViewWithFrame:frame titleStr:titleStr detailStr:detailStr model:kProgressTypePassError isFirst:isFirst isEnd:isEnd isHorizontal:YES style:style];
                }else {
                    
                    [self singleViewWithFrame:frame titleStr:titleStr detailStr:detailStr model:kProgressTypePassNormal isFirst:isFirst isEnd:isEnd isHorizontal:YES style:style];
                }
            }
            
        }else {
            
            if (isWarning) {
                [self singleViewWithFrame:frame titleStr:titleStr detailStr:detailStr model:kProgressTypeWarning isFirst:isFirst isEnd:isEnd isHorizontal:YES style:style];
            }else {
                if (isFirst) {
                    [self singleViewWithFrame:frame titleStr:titleStr detailStr:detailStr model:kProgressTypeFirst isFirst:isFirst isEnd:isEnd isHorizontal:YES style:style];
                }else if (isEnd) {
                    [self singleViewWithFrame:frame titleStr:titleStr detailStr:detailStr model:kProgressTypeEnd isFirst:isFirst isEnd:isEnd isHorizontal:YES style:style];
                }else {
                    [self singleViewWithFrame:frame titleStr:titleStr detailStr:detailStr model:kProgressTypeCurrentNormal isFirst:isFirst isEnd:isEnd isHorizontal:YES style:style];
                }
            }
        }
    }
}


#pragma mark -show progressView vertical
- (void)showProgressViewVerticalWithTitleArray:(NSArray *)titleArr detailArray:(NSArray *)detailArr style:(kProgressStyle)style{
    
    CGFloat singleWidth = self.bounds.size.width - leftMargin - rightMargin;
    CGFloat singleHeight = self.bounds.size.height / self.titleCount;
    CGFloat x = leftMargin;
    
    NSString *titleStr = @"";
    NSString *detailStr = @"";
    
    for (int i=0; i<self.titleCount; i++) {
        
        CGFloat y = i * singleHeight;
        CGRect frame = CGRectMake(x, y, singleWidth, singleHeight);
        
        if (titleArr[i]) {
            titleStr = titleArr[i];
        }
        if (detailArr[i]) {
            detailStr = detailArr[i];
        }
        
        bool isFirst = i==0?YES:NO;
        bool isEnd = i==self.titleCount-1?YES:NO;
        bool isWarning = ([self.warningArr containsObject:titleStr] || [self.warningArr containsObject:detailStr])==1?YES:NO;
        for (int i=0; i<self.warningArr.count; i++) {
            if ([titleStr containsString:self.warningArr[i]]||[detailStr containsString:self.warningArr[i]]) {
                isWarning = YES;
            }
        }
        
        if (style == kProgressStyleSpecial) {
            
            if (i==self.nodeOrdinal && self.statusCodeError) {
                
                [self singleViewWithFrame:frame titleStr:titleStr detailStr:detailStr model:kProgressTypeCurrentError isFirst:isFirst isEnd:isEnd isHorizontal:NO style:style];
                
            }else if (i==self.nodeOrdinal && !self.statusCodeError) {
                
                [self singleViewWithFrame:frame titleStr:titleStr detailStr:detailStr model:kProgressTypeCurrentNormal isFirst:isFirst isEnd:isEnd isHorizontal:NO style:style];
                
            }else {
                
                [self singleViewWithFrame:frame titleStr:titleStr detailStr:detailStr model:kProgressTypeEnd isFirst:isFirst isEnd:isEnd isHorizontal:NO style:style];
            }
            
        }else {
            
            if (isWarning) {
                [self singleViewWithFrame:frame titleStr:titleStr detailStr:detailStr model:kProgressTypeWarning isFirst:isFirst isEnd:isEnd isHorizontal:NO style:style];
            }else {
                if (isFirst) {
                    [self singleViewWithFrame:frame titleStr:titleStr detailStr:detailStr model:kProgressTypeFirst isFirst:isFirst isEnd:isEnd isHorizontal:NO style:style];
                }else if (isEnd) {
                    [self singleViewWithFrame:frame titleStr:titleStr detailStr:detailStr model:kProgressTypeEnd isFirst:isFirst isEnd:isEnd isHorizontal:NO style:style];
                }else {
                    [self singleViewWithFrame:frame titleStr:titleStr detailStr:detailStr model:kProgressTypeCurrentNormal isFirst:isFirst isEnd:isEnd isHorizontal:NO style:style];
                }
            }
        }
    }
}


#pragma mark - Single progressView
- (void)singleViewWithFrame:(CGRect)frame titleStr:(NSString *)title detailStr:(NSString *)detail model:(kProgressType)type isFirst:(BOOL)isFirst isEnd:(BOOL)isEnd isHorizontal:(BOOL)isHorizontal style:(kProgressStyle)style{
    
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *singleView = [[UIView alloc] initWithFrame:frame];
    
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.text = title;
    titleLabel.numberOfLines = 0;
    
    UILabel *detalLabel = [[UILabel alloc] init];
    detalLabel.font = [UIFont systemFontOfSize:12];
    detalLabel.text = detail;
    detalLabel.numberOfLines = 0;
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = kLineGray;
    
    UIImageView *backImageView = [[UIImageView alloc] init];
    
    switch (type) {
            
        case kProgressTypeFirst:
            iconView.image = [UIImage imageNamed:@"nr_booking_green"];
            titleLabel.textColor = kGray;
            detalLabel.textColor = kGray;
            break;
        case kProgressTypePassNormal:
            iconView.image = [UIImage imageNamed:@"nr_booking_smallGreen"];
            titleLabel.textColor = kGreen;
            detalLabel.textColor = kGreen;
            if (style==kProgressStyleSpecial) {
                iconView.frame = CGRectMake(0, 0, 10, 10);
            }
            break;
        case kProgressTypePassError:
            iconView.image = [UIImage imageNamed:@"nr_booking_smallGray"];
            titleLabel.textColor = kGray;
            detalLabel.textColor = kGray;
            if (style==kProgressStyleSpecial) {
                iconView.frame = CGRectMake(0, 0, 10, 10);
            }
            break;
        case kProgressTypeCurrentNormal:
            iconView.image = [UIImage imageNamed:@"nr_booking_green"];
            backImageView.image = [UIImage imageNamed:@"order_log_back_green"];
            titleLabel.textColor = kGreen;
            detalLabel.textColor = kGray;
            if (style==kProgressStyleSpecial) {
                iconView.frame = CGRectMake(0, 0, 20, 20);
                if (isHorizontal) {
                    detalLabel.textColor = kGreen;
                }
            }
            break;
        case kProgressTypeCurrentError:
            iconView.image = [UIImage imageNamed:@"nr_booking_red"];
            backImageView.image = [UIImage imageNamed:@"order_log_back_red"];
            titleLabel.textColor = kRed;
            detalLabel.textColor = kGray;
            if (style==kProgressStyleSpecial) {
                iconView.frame = CGRectMake(0, 0, 20, 20);
                detalLabel.textColor = kRed;
            }
            break;
        case kProgressTypeWarning:
            iconView.image = [UIImage imageNamed:@"nr_booking_yellow"];
            titleLabel.textColor = kOrange;
            detalLabel.textColor = kGray;
            break;
        case kProgressTypeEnd:
            iconView.image = [UIImage imageNamed:@"nr_booking_gray"];
            backImageView.image = [UIImage imageNamed:@"order_log_back_gray"];
            titleLabel.textColor = kGray;
            detalLabel.textColor = kGray;
            break;
        default:
            break;
    }
    
    if (isHorizontal) {
        // 水平展示
        iconView.center = CGPointMake(frame.size.width * 0.5, 10);
        
        CGSize titleSize = [self string:title sizeWithFont:[UIFont systemFontOfSize:14] MaxSize:CGSizeMake(frame.size.width - leftMargin - rightMargin, frame.size.height * 0.3)];
        CGSize detailSize = [self string:detail sizeWithFont:[UIFont systemFontOfSize:14] MaxSize:CGSizeMake(frame.size.width - leftMargin - rightMargin, frame.size.height * 0.3)];
        
        titleLabel.frame = CGRectMake((frame.size.width - titleSize.width) * 0.5, 28, titleSize.width, titleSize.height);
        titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        detalLabel.frame = CGRectMake((frame.size.width - detailSize.width) * 0.5, CGRectGetMaxY(titleLabel.frame) + 8, detailSize.width, detailSize.height);
        detalLabel.font = [UIFont systemFontOfSize:11];
        
        if (style==kProgressStyleSpecial) {
            
            if (isFirst) {
                line.frame = CGRectMake(CGRectGetMaxX(iconView.frame)+baseMargin*2, iconView.center.y - 1, frame.size.width - CGRectGetMaxX(iconView.frame)- baseMargin*2, 2);
            }else if (isEnd) {
                line.frame = CGRectMake(0, iconView.center.y - 1, frame.size.width * 0.5-baseMargin*2, 2);
            }else {
                line.frame = CGRectMake(0, iconView.center.y - 1, iconView.frame.origin.x-baseMargin*2, 2);
                
                UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconView.frame)+ baseMargin*2, iconView.center.y - 1, line.bounds.size.width, 2)];
                line2.backgroundColor = kLineGray;
                [singleView addSubview:line2];
            }
        }else {
            
            if (isFirst) {
                line.frame = CGRectMake(iconView.center.x, iconView.center.y - 1, frame.size.width * 0.5, 2);
            }else if (isEnd) {
                line.frame = CGRectMake(0, iconView.center.y - 1, frame.size.width * 0.5, 2);
            }else {
                line.frame = CGRectMake(0, iconView.center.y - 1, frame.size.width, 2);
            }
        }
        
    }else {
        // 垂直展示
        iconView.center = CGPointMake(10,topMargin * 3);
        
        CGSize titleSize = [self string:title sizeWithFont:[UIFont systemFontOfSize:14] MaxSize:CGSizeMake(frame.size.width - rightMargin - CGRectGetMaxX(iconView.frame) - baseMargin, frame.size.height * 0.5)];
        CGSize detailSize = [self string:detail sizeWithFont:[UIFont systemFontOfSize:14] MaxSize:CGSizeMake(frame.size.width - rightMargin - CGRectGetMaxX(iconView.frame) - baseMargin, frame.size.height * 0.5)];
        
        titleLabel.frame = CGRectMake(CGRectGetMaxX(iconView.frame) + baseMargin, iconView.frame.origin.y, titleSize.width, titleSize.height);
        detalLabel.frame = CGRectMake(CGRectGetMaxX(iconView.frame) + baseMargin, CGRectGetMaxY(titleLabel.frame) + baseMargin, detailSize.width, detailSize.height);
        
        if (isFirst) {
            line.frame = CGRectMake(iconView.center.x - 1, iconView.center.y , 2,frame.size.height - topMargin * 3);
        }else if (isEnd) {
            line.frame = CGRectMake(iconView.center.x - 1, 0, 2 ,topMargin * 3);
        }else {
            line.frame = CGRectMake(iconView.center.x - 1, 0, 2 ,frame.size.height);
        }
        
        if (style==kProgressStyleSpecial) {
            
            if (isFirst) {
                line.frame = CGRectMake(iconView.center.x - 1, 0 , 2,frame.size.height);
            }
            backImageView.frame = CGRectMake(20, topMargin * 2, frame.size.width - CGRectGetMaxX(iconView.frame), frame.size.height - 2*topMargin);
            
            [singleView addSubview:backImageView];
            
            titleLabel.frame = CGRectMake(20 + baseMargin * 2, topMargin * 2.5, titleSize.width, titleSize.height);
            titleLabel.font = [UIFont systemFontOfSize:14];
            titleLabel.textColor = [UIColor whiteColor];
            
            detalLabel.frame = CGRectMake(20 + baseMargin * 2, CGRectGetMaxY(titleLabel.frame) + topMargin * 1.5, detailSize.width, detailSize.height);
            detalLabel.font = [UIFont systemFontOfSize:14];
        }
    }
    
    [singleView addSubview:iconView];
    [singleView addSubview:titleLabel];
    [singleView addSubview:detalLabel];
    [singleView addSubview:line];
    [self addSubview:singleView];
    [singleView bringSubviewToFront:iconView];
    
}

#pragma mark - get labelSize
- (CGSize)string:(NSString *)str sizeWithFont:(UIFont *)font MaxSize:(CGSize)maxSize
{
    CGSize resultSize;
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    CGRect rect = [str boundingRectWithSize:maxSize
                                    options:(NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading)
                                 attributes:attrs
                                    context:nil];
    resultSize = rect.size;
    resultSize = CGSizeMake(ceil(resultSize.width), ceil(resultSize.height));
    
    return resultSize;
}
@end
