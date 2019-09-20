//
//  LQCommentContentView.h
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/8/16.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import <UIKit/UIKit.h>
/**传递 "全部"按钮的事件 和 这个 按钮*/
typedef void(^ReturnAllCommentAction)(UIButton*button);
@interface LQCommentContentView : UIView
@property (nonatomic,strong)UILabel * contentLab;//主要label
@property (nonatomic,strong)UILabel * label;//最下一行的单独label
@property (nonatomic,strong)UIButton * button;//全部按钮
@property (nonatomic,strong)UIView * bottomV;//最下一行label下面的view
@property (nonatomic,copy)ReturnAllCommentAction returnAllCommentBtn;//
@end
