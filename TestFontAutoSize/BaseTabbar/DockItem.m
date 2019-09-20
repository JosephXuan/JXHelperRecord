//
//  DockItem.m
//  SinnaWeiBoDemo
//


#import "DockItem.h"
#define kTitleRatio            0.3
#define titleFont              [UIFont systemFontOfSize:12.0f]
#define kDockItemSelectedBG    @"tabbar_slider.png"
@implementation DockItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //1.文字居中
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        //2.文字大小
        self.titleLabel.font=titleFont;
        //3.图片的内容模式
        self.imageView.contentMode=UIViewContentModeCenter;
        
    }
    return self;
}

#pragma mark 覆盖父类高亮的所有操作
-(void)setHighlighted:(BOOL)highlighted
{
   
}

#pragma Mark 调整内部ImageView 的frame
-(CGRect) imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imgX=0;
    CGFloat imgHeight=contentRect.size.height*(1-kTitleRatio);
    CGFloat imgY=0;
    CGFloat imgWidth=contentRect.size.width;
    return CGRectMake(imgX,imgY,imgWidth,imgHeight);
    
}

#pragma  Mark 调整内部UILabel的frame
-(CGRect) titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX=0;
    CGFloat titleHeight=contentRect.size.height*kTitleRatio;;
    CGFloat titleY=contentRect.size.height-titleHeight-3;
    CGFloat titleWidth=contentRect.size.width;
    return CGRectMake(titleX,titleY,titleWidth,titleHeight);
}

@end
