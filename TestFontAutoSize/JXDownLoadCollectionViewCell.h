//
//  JXDownLoadCollectionViewCell.h
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/6/1.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCustomDownLoadBtn.h"
@class JXDownLoadCollectionViewCell;
@protocol TableViewCellDelegate <NSObject>

- (void)cell:(JXDownLoadCollectionViewCell *)cell didClickedBtn:(UIButton *)btn;

@end

typedef void (^clickCars)(JXCustomDownLoadBtn *myBtn,int state,UIImageView *goodImageView);
@interface JXDownLoadCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)JXCustomDownLoadBtn *myBtn;

@property (strong , nonatomic)clickCars clickCars;
@property (strong, nonatomic) UIImageView *goodImageView;
@property (nonatomic, weak) id <TableViewCellDelegate> delegate;
@property (nonatomic,copy)NSString *url;
@end
