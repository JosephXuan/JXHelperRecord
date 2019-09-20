//
//  RootOneViewController.h
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/5/26.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//
/*
 * 可以隐藏视图的tableView
 */
#import <UIKit/UIKit.h>
/** BXImageH */
#define imageH [UIScreen mainScreen].bounds.size.width
@interface RootOneViewController : UIViewController
/** tableView */
@property (nonatomic, strong) UITableView *tableView;

/** 头部图片 */
@property (nonatomic, strong) UIImageView *headerImage;

/** 标题 */
@property (nonatomic, copy) NSString *titleName;
@end
