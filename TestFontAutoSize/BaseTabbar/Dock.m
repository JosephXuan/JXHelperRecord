//
//  Dock.m
//  SinnaWeiBoDemo
//

#import "Dock.h"
#import "DockItem.h"

@interface Dock ()
{
    DockItem *_selectItem;
}
@end
@implementation Dock

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)addItemWithIcon:(NSString *)iconStr selectedIcon:(NSString *)selected title:(NSString *)title andSelectedTitleColor:(UIColor *)selectedTextColor {
    //创建Item
    DockItem *item=[[DockItem alloc] init];
    //文字
    [item setTitle:title forState:UIControlStateNormal];
    [item setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [item setTitleColor:selectedTextColor forState:UIControlStateSelected];
    //图标
    [item setImage:[UIImage imageNamed:iconStr] forState:UIControlStateNormal];
    [item setImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
    //监听Item的点击
    [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchDown];
    
    //2.添加Item
    [self addSubview:item];
    
    //3.调整所有Item 的Frame
    int count =(int)self.subviews.count;
    
    if(count==1){
        [self itemClick:item];
    }
    
    CGFloat height=self.frame.size.height; //高度
    CGFloat width=self.frame.size.width/count;
    for(int i=0;i<count;i++){
        DockItem *dockItem=self.subviews[i];
        dockItem.tag=i;
        dockItem.frame=CGRectMake(i*width,0,width,height);
    }

}

-(void)itemClick:(DockItem *)item
{
    
    if([_delegate respondsToSelector:@selector(dock:itemSelectedFrom:to:)])
    {
        [_delegate dock:self itemSelectedFrom:(int)_selectItem.tag to:(int)item.tag];
    }
    
    //1.取消当前选中的Item
    _selectItem.selected=NO;
    //2.当前选中的Item
    item.selected=YES;
    //3.赋值
    _selectItem=item;
    //4.通知代理
    _selectIndex=(int)_selectItem.tag;
    
}



@end
