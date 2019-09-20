//
//  MainDownLoadCtrl.h
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/6/1.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//
//易聊+淘宝购物车+YHDownLoad+MCDownloadManager
//http://code.cocoachina.com/view/135013 YH
//http://code.cocoachina.com/view/134751 MC
//http://www.jianshu.com/p/062327c5846a MC
//https://github.com/DeftMKJ/TaoBaoShoppingCart/blob/master/222.gif
//https://github.com/heysunnyboy/PurchaseCarAnimation 加入购物车动画
//http://www.jianshu.com/p/f1b93cfbc116?nomobile=yes 加入购物车动画
//https://github.com/HeroWqb/HWDownloadDemo //下载 HWDownload 和mc 一样 可以拼一拼
#import <UIKit/UIKit.h>
/*
 * 下载 判断:如果是同一剧集下载到同一文件夹
 *          如果不是直接下载 放入文件夹中
 * 展示 从沙盒目录中取出 文件夹内容展示
 *     判断:根文件夹中如果有文件夹 证明是剧集 可以点击进入
 *          根文件夹如果没有文件夹 点击播放
 */
@interface MainDownLoadCtrl : UIViewController

@end
