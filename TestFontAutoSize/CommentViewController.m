//
//  CommentViewController.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/6/21.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "CommentViewController.h"
#import "MHConstant.h"
#define WINDOW [UIScreen mainScreen]
#define WIDTH WINDOW.bounds.size.width
#define HEIGHT WINDOW.bounds.size.height
@interface CommentViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CommentViewController
//三角
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title=@"评论/回复";
    [self addPopView];
    
    /*
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, WIDTH, HEIGHT-49-64) style:UITableViewStyleGrouped];
    
    tableView.backgroundColor =[UIColor whiteColor];
    tableView.dataSource =self;
    tableView.delegate =self;
    [self.view addSubview:tableView];
     */
}
-(void)addPopView{
    /*
     * 自定义lable类
     *
     self.userInteractionEnabled = YES;
     UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)];
     [self addGestureRecognizer:tap];
     */
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 200, 50)];
    CGFloat cornerRadius = 4;
    view.backgroundColor = [UIColor lightGrayColor];
    [self .view addSubview:view];
    
    CGFloat viewWidth = CGRectGetWidth(view.frame);
    CGFloat viewHeight = CGRectGetHeight(view.frame);
    
    CGFloat arrowX = 55.; //位置
    CGFloat arrowY = 7.; //高度
    CGFloat arrowLength = MHGlobalViewTopInset; //宽度
    CGPoint point1 = CGPointMake(0, 0);
    CGPoint point2 = CGPointMake(viewWidth, 0);
    CGPoint point3 = CGPointMake(viewWidth, viewHeight - arrowY);
    //key point 4,5,6
    CGPoint point4 = CGPointMake(arrowX + arrowLength, viewHeight - arrowY);
    CGPoint point5 = CGPointMake(arrowX + arrowLength/2.0, viewHeight);
    CGPoint point6 = CGPointMake(arrowX, viewHeight - arrowY);
    
    CGPoint point7 = CGPointMake(0, viewHeight - arrowY);
    UIBezierPath *path = [UIBezierPath bezierPath];
    if (cornerRadius == 0) {
        [path moveToPoint:point1];
        [path addLineToPoint:point2];
        [path addLineToPoint:point3];
        [path addLineToPoint:point4];
        [path addLineToPoint:point5];
        [path addLineToPoint:point6];
        [path addLineToPoint:point7];
    }else{
        //顺序有影响
        [path addArcWithCenter:CGPointMake(cornerRadius, cornerRadius) radius:cornerRadius startAngle:2*M_PI_2 endAngle:3*M_PI_2 clockwise:YES];
        [path addArcWithCenter:CGPointMake(viewWidth-cornerRadius, cornerRadius) radius:cornerRadius startAngle:3*M_PI_2 endAngle:0 clockwise:YES];
        [path addArcWithCenter:CGPointMake(viewWidth-cornerRadius, viewHeight-cornerRadius-arrowY) radius:cornerRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        [path addLineToPoint:point4];
        [path addLineToPoint:point5];
        [path addLineToPoint:point6];
        [path addArcWithCenter:CGPointMake(cornerRadius, viewHeight-cornerRadius-arrowY) radius:cornerRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    }
    [path closePath];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    view.layer.mask = layer;
}
/*
// 点击评论回复按钮
-(void)reply:(UIButton *)button{
    NSDetailCommentCellModel *model = _dataArray[button.tag];
    [_textFieldView.commentField becomeFirstResponder];
    _textFieldView.model = model;
    _textFieldView.placeHolderLabel.text = [NSString stringWithFormat:@"回复:%@",model.nick_name];
}
//点击发布回复按钮
- (void)publish{
    if (!_textFieldView.model) {
        [self comment];
    }else{
        [self replyAction:_textFieldView.model];
    }
}
// 评论
- (void)comment{
    if ([NSString isBlankString:_textFieldView.commentField.text]||[_textFieldView.commentField.text isEqualToString:@"｜说说你的看法～"]) {
        [WKProgressHUD popMessage:@"请输入评论文字" inView:self.view duration:HUD_DURATION animated:YES];
    }else{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [_textFieldView.commentField resignFirstResponder];
        
        NSDictionary *parameters = @{@"dyStateDesId":self.dyStateDesId,@"add":@"1",@"content":_textFieldView.commentField.text};
        
        [[NSNetworking sharedManager]get:COMMUNITY_DETAIL_COMMENT parameters:parameters success:^(id response) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [WKProgressHUD popMessage:@"评论成功" inView:self.view duration:HUD_DURATION animated:YES];
            [_textFieldView.commentField resignFirstResponder];
            
            _textFieldView.commentField.textColor = TEXT_COLOR4;
            _textFieldView.commentField.contentInset = UIEdgeInsetsMake(-2,0,2,0);
            _longDetailView.tableview.hidden = NO;
            [_longDetailView.tableview reloadData];
            
            if (self.pageNumber > _dynamicDetailCommentModel.totalPage.integerValue) {
                
                NSDictionary *dic =@{@"photo":kAccountManager.accountInfo.photo,@"nick_name":kAccountManager.accountInfo.nick_name,@"content":_textFieldView.commentField.text,@"time":@"刚刚"};
                NSDetailCommentCellModel *model = [[NSDetailCommentCellModel alloc]initWithDictionary:dic error:nil];
                [_dataArray addObject:model];
                [self insertTableviewRow];
                _dynamicDetailCommentModel.totalRow = [NSString stringWithFormat:@"%ld",_dynamicDetailCommentModel.totalRow.integerValue+1];
                CGSize size = CGSizeMake(screenWidth-63,MAXFLOAT); //设置一个行高上限
                NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:12]};
                _hotCommentSize = [model.content boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
                [_longDetailView.tableview mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(@(_longDetailView.tableview.contentSize.height+57+_hotCommentSize.height+64));
                }];
                [_longDetailView.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.bottom.mas_equalTo(_longDetailView.tableview.mas_bottom);
                    make.bottom.mas_greaterThanOrEqualTo(_longDetailView);
                }];
            }else{
                [_longDetailView.tableview mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(@(_longDetailView.tableview.contentSize.height+64));
                }];
                [_longDetailView.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.bottom.mas_equalTo(_longDetailView.tableview.mas_bottom);
                    make.bottom.mas_greaterThanOrEqualTo(_longDetailView);
                }];
            }
            _textFieldView.commentField.text = @"｜说说你的看法～";
            [self textViewDidChange:_textFieldView.commentField];
            
        } failure:^(NSString *error,int errorCode) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [WKProgressHUD popMessage:error inView:self.view duration:HUD_DURATION animated:YES];
            _textFieldView.commentField.text = @"｜说说你的看法～";
            [self textViewDidChange:_textFieldView.commentField];
            _textFieldView.commentField.textColor = TEXT_COLOR4;
            _textFieldView.commentField.contentInset = UIEdgeInsetsMake(-2,0,2,0);
            
        }];
    }
}
// 回复
- (void)replyAction:(NSDetailCommentCellModel *)model{
    NSDictionary *parameters = @{@"dyStateDesId":self.dyStateDesId,@"add":@"1",@"toUser":model.commentUser,@"toComment":model.commentDesId,@"content":_textFieldView.commentField.text};
    
    [[NSNetworking sharedManager]get:COMMUNITY_DETAIL_COMMENT parameters:parameters success:^(id response) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [WKProgressHUD popMessage:@"回复成功" inView:self.view duration:HUD_DURATION animated:YES];
        _longDetailView.tableview.hidden = NO;
        [_longDetailView.tableview reloadData];
        
        if (self.pageNumber > _dynamicDetailCommentModel.totalPage.integerValue) {
            NSDetailCommentCellModel *responseModel = [[NSDetailCommentCellModel alloc]initWithDictionary:response[@"items"][0] error:nil];
            NSDictionary *dic =@{@"photo":kAccountManager.accountInfo.photo,@"nick_name":kAccountManager.accountInfo.nick_name,@"content":_textFieldView.commentField.text,@"time":@"刚刚",@"photoTo":model.photo,@"nick_nameTo":model.nick_name,@"timeTo":model.time,@"contentTo":model.content,@"commentUser":responseModel.commentUser,@"commentDesId":responseModel.commentDesId};
            
            NSDetailCommentCellModel *model = [[NSDetailCommentCellModel alloc]initWithDictionary:dic error:nil];
            [_dataArray addObject:model];
            [self insertTableviewRow];
            _dynamicDetailCommentModel.totalRow = [NSString stringWithFormat:@"%ld",_dynamicDetailCommentModel.totalRow.integerValue+1];
            CGSize size = CGSizeMake(screenWidth-112,MAXFLOAT); //设置一个行高上限
            NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:12]};
            CGSize hotCommentSize = [model.content boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
            CGSize size2 = CGSizeMake(screenWidth-110,MAXFLOAT); //设置一个行高上限
            CGSize replySize = [model.contentTo boundingRectWithSize:size2 options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
            [_longDetailView.tableview mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(_longDetailView.tableview.contentSize.height+107+hotCommentSize.height+replySize.height+64));
            }];
            [_longDetailView.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(_longDetailView.tableview.mas_bottom);
                make.bottom.mas_greaterThanOrEqualTo(_longDetailView);
            }];
            _textFieldView.commentField.text = @"｜说说你的看法～";
            [self textViewDidChange:_textFieldView.commentField];
            [_textFieldView.commentField resignFirstResponder];
        }else{
            [_longDetailView.tableview mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(_longDetailView.tableview.contentSize.height+64));
            }];
            [_longDetailView.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(_longDetailView.tableview.mas_bottom);
                make.bottom.mas_greaterThanOrEqualTo(_longDetailView);
            }];
        }
        
    } failure:^(NSString *error,int errorCode) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [WKProgressHUD popMessage:error inView:self.view duration:HUD_DURATION animated:YES];
        _textFieldView.commentField.text = @"｜说说你的看法～";
        [self textViewDidChange:_textFieldView.commentField];
        _textFieldView.commentField.textColor = TEXT_COLOR4;
        _textFieldView.commentField.contentInset = UIEdgeInsetsMake(-2,0,2,0);
        [_textFieldView.commentField resignFirstResponder];
    }];
}
// 评论或回复成功后在底部插入一行
- (void)insertTableviewRow{
    [_longDetailView.tableview beginUpdates];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_dataArray.count-1 inSection:0];
    [_longDetailView.tableview insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    [_longDetailView.tableview endUpdates];
}
#pragma mark - UITextViewDelegate
-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    _textFieldView.placeHolderLabel.text = @"";
    _textFieldView.model = nil;
    return YES;
}
 */
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
