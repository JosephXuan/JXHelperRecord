//
//  ViewController.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/2/23.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "ViewController.h"
#import "LGGradientBackgroundView.h"
#import "JXNetTestCtrl.h"
#import "MHConstant.h"
#import "UIColor+Wonderful.h"
////https://github.com/ywdonga/FontSizeModify 适配字体
//http://transcoder.tradaquan.com/from=2001a/bd_page_type=1/ssid=0/uid=0/pu=usm%402%2Csz%401320_2003%2Cta%40iphone_1_10.3_1_11.5/baiduid=55352E6E986934F3A889FC55DAB4D75A/w=0_10_/t=iphone/l=3/tc?ref=www_iphone&lid=14124884345530352668&order=3&fm=alhm&h5ad=1&srd=1&dict=32&tj=h5_mobile_3_0_10_title&w_qd=IlPT2AEptyoA_yiwI6DhHSw7qsLIKren&sec=22234&di=cecd07182630f5f6&bdenc=1&tch=124.116.271.571.0.0&nsrc=IlPT2AEptyoA_yixCFOxXnANedT62v3IEQGG_yRR1zShpVjte4viZQRAUnKhVir3UpDwbD34gssIwa&eqid=c405ab79b4d0080010000005595b6bed&wd=&clk_info=%7B%22srcid%22%3A%221599%22%2C%22tplname%22%3A%22h5_mobile%22%2C%22t%22%3A1499163757271%2C%22sig%22%3A%22127771%22%2C%22xpath%22%3A%22div-a-h3%22%7D
//https://github.com/Miao123/JHChangeFontSize 更改字体大小
//https://yq.aliyun.com/articles/39394 改变全局 字体
//
//改变全局字体大小
/*
 http://www.jianshu.com/p/efa162957d89
 
  全局都要这样去改, 未免也太麻烦了. 应该是有一个类的扩展或者基类, 调用对应的方法, 每次修改直接通知到基类创建的时候就修改好. 
 http://blog.csdn.net/zhangqipu000/article/details/43968997
 通知 传userInfo dic 属性 改变 调方法
  如果工程已经完毕(控件创建完毕), 最好用运行时去替换字体大小的方法. 计算 cellFrame 也要提前知道字体, 方便去计算 cell 的高度缓存
 
 * 继承类 或者 扩展类
 * 描述属性 
 * 自定义一个 改变 font 方法 改变 自定义属性
 * 利用通知 改变属性
 * UIFont+adapt
 */
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define SizeScale (ScreenWidth != 414 ? 1 : 1.2)
#define kFont(value) [UIFont systemFontOfSize:value * SizeScale]

/*
 * 适配
 */
//kScaleSize(80)
//5s
#define kScaleSize(sizew) [UIScreen mainScreen].bounds.size.width*sizew/320

// 80/MYWIDTH
#define MYWIDTH 375.0*ScreenWeidth
#define MYHEIGHT 667.0*ScreenHeight

//http://blog.sina.com.cn/s/blog_14c9cd5a30102wni4.html

@interface ViewController ()
@property(nonatomic,strong)UIView *backView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor grayColor];
    
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    if (self.navigationController.viewControllers.count % 2) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
        view.backgroundColor = [UIColor redColor];
        self.navigationItem.titleView = view;
    } else {
        self.navigationItem.title = [@(self.navigationController.viewControllers.count) stringValue];
    }
    [self addNav];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 50);
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    //表情
   // NSString *str=[[NSString alloc]initWithBytes:&sym length:sizeof(sym) encoding:NSUTF8StringEncoding];
    UITextField *startTextField = [[UITextField alloc] initWithFrame:CGRectMake(60, 180, 250, 30)];
    //startTextField.delegate = self;
    startTextField.font = [UIFont systemFontOfSize:18];
    startTextField.text = @"我的位置";
    startTextField.borderStyle = UITextBorderStyleRoundedRect;
    startTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    UILabel *startLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    startLabel.backgroundColor = [UIColor clearColor];
    startLabel.font = [UIFont systemFontOfSize:17];
    startLabel.textColor = [UIColor lightGrayColor];
    startLabel.text = @"起点:";
    startTextField.rightView = (UIView *)startLabel;
    startTextField.rightViewMode = UITextFieldViewModeAlways;

    [self.view addSubview:startTextField];
    
    
    /*
     
     UIFont+adapt.h
    self.view.backgroundColor=[UIColor greenColor];
    UILabel *fontLab=[[UILabel alloc]init];
    fontLab.center=self.view.center;
    fontLab.bounds=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/2);
    fontLab.textAlignment=NSTextAlignmentCenter;
    fontLab.backgroundColor=[UIColor redColor];
    fontLab.textColor=[UIColor whiteColor];
     //
    fontLab.font=[UIFont systemFontOfSize:12];
   // fontLab.font=kFont(12);
    NSLog(@"%@>>>>%f>>>>>%@",fontLab.font,ceilf(12*ScreenWidth/375),kFont(12));
    
    
    //三个方法
     //5s 12pt 11pt 12pt
     //6s 14pt 12pt 14pt
     //6p 17.4pt 14pt 17.4pt
     
    fontLab.text=@"字体屏幕适配";
    [self.view addSubview:fontLab];
    */
    
    
    /*
     *渐变色
     
    self.backView=[[UIView alloc]init];
    self.backView.frame=CGRectMake(0, 100, ScreenWidth, ScreenWidth);
    [self.view addSubview:self.backView];
    
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    
    gradientLayer.colors = @[(__bridge id)SXRGB16Color(0xff8800).CGColor,(__bridge id)SXRGB16Color(0xff5100).CGColor];
    //位置x,y    自己根据需求进行设置   使其从不同位置进行渐变
    gradientLayer.startPoint = CGPointMake(0, 0.5);
    
    gradientLayer.endPoint = CGPointMake(1, 1);
    
    gradientLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.backView.frame), CGRectGetHeight(self.backView.frame));
    
    [self.backView.layer addSublayer:gradientLayer];
    */
    /*
     *渐变色
     1.
     *http://blog.csdn.net/lgouc/article/details/47254839
     *https://github.com/RungeZhai/LGGradientBackgroundView
     
     
     */
    /*
     渐变色
    LGGradientBackgroundView *gview=[[LGGradientBackgroundView alloc]init];
    gview.frame=CGRectMake(0, 100, ScreenWidth, ScreenWidth);
    gview.inputColor0=[UIColor redColor];
    gview.inputColor1=[UIColor greenColor];
    

gview.implementMethod=LGGradientBGViewImplementMethodCAGradientLayer;
    gview.inputPoint0=CGPointMake(0.1,0);
    gview.inputPoint1=CGPointMake(1, 0);
    [self.view addSubview:gview];
    */
    
    /*
     2.
     *http://www.cocoachina.com/ios/20161009/17704.html
     *https://github.com/xiaochaofeiyu/YSCAnimation
     *圆形渐变
     */
    //创建CGContextRef
    //self.view.bounds.size
    //CGSizeMake(ScreenWidth, ScreenWidth)
    UIGraphicsBeginImageContext(self.view.bounds.size);
    //获取图文上下文
    CGContextRef gc = UIGraphicsGetCurrentContext();
    
    //创建CGMutablePathRef
    CGMutablePathRef path = CGPathCreateMutable();
    
    //绘制Path
    //http://blog.csdn.net/trandy/article/details/6667127
    //https://www.mgenware.com/blog/?p=493
    //http://blog.csdn.net/reylen/article/details/22038607 切圆角
    //http://www.cnblogs.com/wendingding/p/3782679.html
    //http://blog.csdn.net/qiwancong/article/details/7823027
    //http://blog.csdn.net/xcysuccess3/article/details/24001571
    //http://blog.csdn.net/rhljiayou/article/details/9919713
    //http://www.cocoachina.com/ios/20150629/12278.html 画线 1像素的线
    CGRect rect = CGRectMake(0, 100,ScreenWidth,ScreenWidth);
    /*
   
    //将路径移动到一个点作为起点
    //CGRectGetMinX(rect)
    CGPathMoveToPoint(path, NULL, 0, CGRectGetMinY(rect));
    NSLog(@"%f>>>%f",CGRectGetMidX(rect),CGRectGetMinY(rect));

    //添加一条直线 从初始点到该函数指定的坐标点
    //CGRectGetMidX(rect)
    //左下定点
    CGPathAddLineToPoint(path, NULL, 0, CGRectGetMaxY(rect));
    NSLog(@"%f>>>%f",CGRectGetMidX(rect),CGRectGetMaxY(rect));
    //右下定点
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(rect), CGRectGetMaxY(rect));
    NSLog(@"%f>>>%f",CGRectGetWidth(rect),CGRectGetMaxY(rect));
    //右上定点
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(rect), CGRectGetMinY(rect));
    NSLog(@"%f>>>%f",CGRectGetWidth(rect),CGRectGetMinY(rect));

    //关闭该path 路径最后的端点将和起点闭合
    CGPathCloseSubpath(path);
     
   
    //绘制渐变
    [self drawRadialGradient:gc path:path startColor:[UIColor greenColor].CGColor endColor:[UIColor redColor].CGColor];
    
    //注意释放CGMutablePathRef
    CGPathRelease(path);
    
    //从Context中获取图像，并显示在界面上
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    [self.view addSubview:imgView];
     */
    
    
    /*
     *图片缩放
     
    
    //self.view.bounds
    //苹方常规字体
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(10, 30, ScreenWidth/2, 40)];
    lable.text=@"这是一个UIlableDemo的实例";
   // lable.font=[UIFont fontWithName:@"Arial" size:35];
    lable.font=MHRegularFont_12;
    lable.textColor=[UIColor yellowColor];
   // lable.textAlignment=UITextAlignmentCenter;
    lable.backgroundColor=[UIColor blueColor];
   // lable.lineBreakMode=UILineBreakModeWordWrap;
    lable.numberOfLines=0;
     [lable sizeToFit];
    [self.view addSubview:lable];
    */
    /** 中粗体
    UILabel *lable1=[[UILabel alloc]initWithFrame:CGRectMake(10, 80, ScreenWidth/2, 40)];
    lable1.text=@"这是一个UIlableDemo的实例";
    // lable.font=[UIFont fontWithName:@"Arial" size:35];
    lable1.font=MHSemiboldFont(12.0f);
    lable1.textColor=[UIColor yellowColor];
    // lable.textAlignment=UITextAlignmentCenter;
    lable1.backgroundColor=[UIColor blueColor];
    // lable.lineBreakMode=UILineBreakModeWordWrap;
    lable1.numberOfLines=0;
     [lable1 sizeToFit];
    [self.view addSubview:lable1];
    
    //中等
    UILabel *lable2=[[UILabel alloc]initWithFrame:CGRectMake(10, 130, ScreenWidth/2, 40)];
    lable2.text=@"这是一个UIlableDemo的实例";
    // lable.font=[UIFont fontWithName:@"Arial" size:35];
    lable2.font=MHMediumFont(12.0f);
    lable2.textColor=[UIColor yellowColor];
    // lable.textAlignment=UITextAlignmentCenter;
    lable2.backgroundColor=[UIColor blueColor];
    // lable.lineBreakMode=UILineBreakModeWordWrap;
    lable2.numberOfLines=0;
     [lable2 sizeToFit];
    [self.view addSubview:lable2];
    */
    /** 极细体
    UILabel *lable3=[[UILabel alloc]initWithFrame:CGRectMake(10, 180, ScreenWidth/2, 40)];
    lable3.text=@"这是一个UIlableDemo的实例";
    // lable.font=[UIFont fontWithName:@"Arial" size:35];
    lable3.font=MHUltralightFont(12.0f);
    lable3.textColor=[UIColor yellowColor];
    // lable.textAlignment=UITextAlignmentCenter;
    lable3.backgroundColor=[UIColor blueColor];
    // lable.lineBreakMode=UILineBreakModeWordWrap;
    lable3.numberOfLines=0;
     [lable3 sizeToFit];
    [self.view addSubview:lable3];
    */
    /** 纤细体
    UILabel *lable4=[[UILabel alloc]initWithFrame:CGRectMake(10, 230, ScreenWidth/2, 40)];
    lable4.text=@"这是一个UIlableDemo的实例";
    // lable.font=[UIFont fontWithName:@"Arial" size:35];
    lable4.font=MHThinFont(12.0f);
    lable4.textColor=[UIColor yellowColor];
    // lable.textAlignment=UITextAlignmentCenter;
    lable4.backgroundColor=[UIColor blueColor];
    // lable.lineBreakMode=UILineBreakModeWordWrap;
    lable4.numberOfLines=0;
     [lable4 sizeToFit];
    [self.view addSubview:lable4];
    */
    /** 细体
    UILabel *lable5=[[UILabel alloc]initWithFrame:CGRectMake(10, 280, ScreenWidth/2, 40)];
    lable5.text=@"这是一个UIlableDemo的实例";
    // lable.font=[UIFont fontWithName:@"Arial" size:35];
    lable5.font= MHLightFont(12.0f);
    lable5.textColor=[UIColor yellowColor];
    // lable.textAlignment=UITextAlignmentCenter;
    lable5.backgroundColor=[UIColor blueColor];
    // lable.lineBreakMode=UILineBreakModeWordWrap;
    lable5.numberOfLines=0;
     [lable5 sizeToFit];
    [self.view addSubview:lable5];
    
    //设置系统的字体大小 粗体
    UILabel *lable6=[[UILabel alloc]initWithFrame:CGRectMake(10, 330, ScreenWidth/2, 40)];
    lable6.text=@"这是一个UIlableDemo的实例";
    // lable.font=[UIFont fontWithName:@"Arial" size:35];
    lable6.font=MHFont(12.0f,YES);
    lable6.textColor=[UIColor yellowColor];
    // lable.textAlignment=UITextAlignmentCenter;
    lable6.backgroundColor=[UIColor blueColor];
    // lable.lineBreakMode=UILineBreakModeWordWrap;
    lable6.numberOfLines=0;
    [lable6 sizeToFit];
    [self.view addSubview:lable6];
    
    
    ///设置系统的字体大小 常规
    UILabel *lable7=[[UILabel alloc]init];
    //WithFrame:CGRectMake(10, 380, ScreenWidth/2, 40)
    lable7.frame = (CGRect){{10 , 380} , {ScreenWidth/2 , 40}};
    lable7.adjustsFontSizeToFitWidth = YES;
    lable7.text=@"这是一个UIlableDemo的实例";
    // lable.font=[UIFont fontWithName:@"Arial" size:35];
    lable7.font=MHFont(12.0f,NO);
    lable7.textColor=[UIColor yellowColor];
    // lable.textAlignment=UITextAlignmentCenter;
    lable7.backgroundColor=[UIColor blueColor];
    // lable.lineBreakMode=UILineBreakModeWordWrap;
    lable7.numberOfLines=0;
    [lable7 sizeToFit];
    [self.view addSubview:lable7];
    
    UILabel *lable8=[[UILabel alloc]init];
    //WithFrame:CGRectMake(10, 380, ScreenWidth/2, 40)
    lable8.frame = (CGRect){{10 , 440} , {ScreenWidth/2 , 40}};
    lable8.adjustsFontSizeToFitWidth = YES;
    lable8.text=@"这是一个UIlableDemo的实例";
    // lable.font=[UIFont fontWithName:@"Arial" size:35];
    lable8.font=[UIFont systemFontOfSize:12.0f];
    lable8.textColor=[UIColor yellowColor];
    // lable.textAlignment=UITextAlignmentCenter;
    lable8.backgroundColor=[UIColor blueColor];
    // lable.lineBreakMode=UILineBreakModeWordWrap;
    lable8.numberOfLines=0;
    [lable8 sizeToFit];
    [self.view addSubview:lable8];
    */
   // CGSize size =[lable.text sizeWithFont:<#(UIFont *)#> constrainedToSize:<#(CGSize)#>];
    
    // //imageView 在屏幕上的位置
  //  CGRect convertRect = [[tmpView superview] convertRect:tmpView.frame toView:self.view];
   
}
#pragma mark --跳转界面
-(void)clicked:(UIButton*)btn{
     [self.navigationController pushViewController:[ViewController new] animated:YES];
}
-(void)addNav{
    
    if (self.navigationController.viewControllers.count % 2) {
        //单个按钮,这里增加了快捷创建的方式
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button addTarget:self action:@selector(pushAction) forControlEvents:UIControlEventTouchUpInside];
        
        [button setImage:[[UIImage imageNamed:@"first_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
       
        [button sizeToFit];
        if (button.bounds.size.width < 40) {
            CGFloat width = 40 / button.bounds.size.height * button.bounds.size.width;
            button.bounds = CGRectMake(0, 0, width, 40);
        }
        if (button.bounds.size.height > 40) {
            CGFloat height = 40 / button.bounds.size.width * button.bounds.size.height;
            button.bounds = CGRectMake(0, 0, 40, height);
        }
        button.imageEdgeInsets = UIEdgeInsetsZero;
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    } else {
        //多个按钮(或者其他任意控件比如segment|slider.....)可以使用自定义视图的方式
        //此方式也可以自定义多个按钮之间的间距
        UIView *barView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
        
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(0, 0, 40, 40);
        [btn1 setImage:[UIImage imageNamed:@"first_selected"] forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(pushAction) forControlEvents:UIControlEventTouchUpInside];
        [barView addSubview:btn1];
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(40, 0, 40, 40);
        [btn2 setImage:[UIImage imageNamed:@"first_selected"] forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(pushAction) forControlEvents:UIControlEventTouchUpInside];
        [barView addSubview:btn2];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:barView];
        
        //此方式为系统方法不可以自定义多个按钮之间的间距
        //        self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem itemWithTarget:self action:@selector(pushAction) image:[UIImage imageNamed:@"nav_add"]],[UIBarButtonItem itemWithTarget:self action:@selector(pushAction) image:[UIImage imageNamed:@"nav_add"]]];
        
    }
    if (self.navigationController.viewControllers.count > 1) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button addTarget:self action:@selector(pushAction) forControlEvents:UIControlEventTouchUpInside];
        
        [button setImage:[[UIImage imageNamed:@"first_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        
        [button sizeToFit];
        if (button.bounds.size.width < 40) {
            CGFloat width = 40 / button.bounds.size.height * button.bounds.size.width;
            button.bounds = CGRectMake(0, 0, width, 40);
        }
        if (button.bounds.size.height > 40) {
            CGFloat height = 40 / button.bounds.size.width * button.bounds.size.height;
            button.bounds = CGRectMake(0, 0, 40, height);
        }
        button.imageEdgeInsets = UIEdgeInsetsZero;
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
}
-(void)pushAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)drawRadialGradient:(CGContextRef)context
                      path:(CGPathRef)path
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };//0.0
    //后边设置小 都是红色
    //
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    
    CGRect pathRect = CGPathGetBoundingBox(path);
    CGPoint center = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMidY(pathRect));
    //  / 2.0 控制 path 圆角
    CGFloat radius = MAX(pathRect.size.width/2.0 , pathRect.size.height/2.0) * sqrt(2);//2
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextEOClip(context);
    
    CGContextDrawRadialGradient(context, gradient, center, 0, center, radius, 0);
    
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
