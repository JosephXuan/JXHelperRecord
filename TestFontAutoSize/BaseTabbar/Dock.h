//
//  Dock.h
//  SinnaWeiBoDemo
//
/*
 *选项卡
 */

#import <UIKit/UIKit.h>

@class Dock;

@protocol DockDelegate <NSObject>

@optional
-(void)dock:(Dock *)dock itemSelectedFrom:(int)from to:(int) to;

@end

@interface Dock : UIView

//添加选项卡
-(void)addItemWithIcon:(NSString *)iconStr selectedIcon:(NSString *)selected title:(NSString *)title andSelectedTitleColor:(UIColor *)selectedTextColor;
@property (nonatomic,weak) id<DockDelegate> delegate;
@property (nonatomic,assign) int selectIndex;

@end
