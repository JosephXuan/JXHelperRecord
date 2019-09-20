//
//  WCLActionSheet.h
//  WCLPictureClippingRotation
//
//  Created by wcl on 2016/12/28.
//  Copyright © 2016年 QianTangTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WCLActionSheet;
@protocol WCLActionSheetDelegate <NSObject>

@required
//点击按钮
- (void)actionImageSheet:(WCLActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

@optional
//取消按钮
- (void)actionSheetCancel:(WCLActionSheet *)actionSheet;

@end

@interface WCLActionSheet : UIView

/**
 *  type block
 *
 *  @param title                  title            (可以为空)
 *  @param delegate               delegate
 *  @param cancelButtonTitle      "取消"按钮         (默认有)
 *  @param destructiveButtonTitle "警示性"(红字)按钮  (可以为空)
 *  @param otherButtonTitles      otherButtonTitles
 */
- (instancetype)initWithTitle:(NSString *)title
                     delegate:(id<WCLActionSheetDelegate>)delegate
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@property(nonatomic,weak) id<WCLActionSheetDelegate> delegate;
@property(nonatomic,copy) NSString *title;

- (void)showInView:(UIView *)view;

@end
