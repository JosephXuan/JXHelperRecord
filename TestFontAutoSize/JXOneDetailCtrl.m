//
//  JXOneDetailCtrl.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/10/20.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "JXOneDetailCtrl.h"
#import "UIScrollView+MyCategory.h"
@interface JXOneDetailCtrl ()<UIScrollViewDelegate>
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation JXOneDetailCtrl
- (NSArray *)images {
    if (!_images) {
        NSMutableArray *images = [NSMutableArray new];
        for (NSInteger i = 0; i < 3; i++) {
            NSString *imageName = [NSString stringWithFormat:@"0%zd", i + 1];
            
            [images addObject:[UIImage imageNamed:imageName]];
        }
        _images = [NSArray arrayWithArray:images];
    }
    return _images;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor grayColor]];
    
    [self setupUI];
}
- (void)setupUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.delegate        = self;
    self.scrollView.pagingEnabled   = YES;
    self.scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.scrollView];
    
    CGFloat scrollW = self.scrollView.frame.size.width;
    CGFloat scrollH = self.scrollView.frame.size.height;
    
    for (NSInteger i = 0; i < self.images.count; i++) {
        UIImageView *imageView = [UIImageView new];
        imageView.frame = CGRectMake(i * scrollW, 0, scrollW, scrollH);
        imageView.image = self.images[i];
        [self.scrollView addSubview:imageView];
    }
    [self.scrollView setContentSize:CGSizeMake(self.images.count * scrollW, 0)];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
