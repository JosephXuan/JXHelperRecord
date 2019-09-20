//
//  RTProgressView.h
//  RTProgressView
//
//  Created by ROOT on 16/6/22.
//  Copyright © 2016年 root. All rights reserved.
//
//http://code.cocoachina.com/view/131918 进度条 时间轴 步骤 下一步
//展开折叠 iOS 沙龙3群文件 单元格收缩与展开 U盘已有 可以搜课程(展开)
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,kProgressStyle) {
    
    kProgressStyleNormal,
    kProgressStyleSpecial
};

@interface RTProgressView : UIView

/**
 *  显示 progressView
 *
 *  @param titleArr     主标题数组(默认元素类型为 NSString, 若元素为空或占位则赋值 @"")
 *  @param detailArr    副标题数组(默认元素类型为 NSString, 若元素为空或占位则赋值 @"")
 *  @param isHorizontal 是否是水平展示
 *  @param style         展示样式(目前普通和特殊两种)
 */
- (void)showProgressViewWithTitleArray:(NSArray *)titleArr detailArray:(NSArray *)detailArr isHorizontal:(BOOL)isHorizontal style:(kProgressStyle)style;


/**
 *  设置高亮展示的元素(将需要高亮展示的字符串或关键字添加到此数组--kProgressStyleNormal 时有效)
 *
 *  @param errorArr 高亮数组
 */
- (void)setWarningArray:(NSArray *)warningArr;


/**
 *  设置节点序号以及进度成功状态(kProgressStyleSpecial 时有效)
 *
 *  @param nodeOrdinal     当前节点序号
 *  @param statusCodeError 是否成功
 */

- (void)setNodeOrdinal:(NSInteger)nodeOrdinal statusCodeError:(BOOL)statusCodeError;

@end
