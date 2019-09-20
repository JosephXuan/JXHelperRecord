//
//  代码地址: https://github.com/Gfengwei/GZActionSheet.git
//
//  GZActionSheet.h
//  GZActionSheet
//
//  Created by guifengwei on 2017/3/21.
//  Copyright © 2017年 Gfengwei. All rights reserved.
//

#import <UIKit/UIKit.h>
//仿微信 弹出action
@class GZActionSheet;

@protocol GZActionSheetDelegate <NSObject>

- (void)actionSheet:(GZActionSheet *)actionSheet clickButtonAtIndex:(NSInteger )buttonIndex;

@end

@interface GZActionSheet : UIView

/** 1.支持代理 */
@property (nonatomic,weak) id <GZActionSheetDelegate> delegate;

/** 2.支持block */
@property (nonatomic,copy) void (^ClickIndex) (NSInteger index);


/**
 根据数组进行文字显示,返回index
 @param titleArr 传入显示的数组
 @param show 是否显示取消按钮
 @return return value description
 */
- (instancetype)initWithTitleArray:(NSArray *)titleArr
                     andShowCancel:(BOOL )show;

@end
