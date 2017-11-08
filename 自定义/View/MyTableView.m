//
//  MyTableView.m
//  RenCaiKu
//
//  Created by mac on 16/6/14.
//  Copyright © 2016年 LingFeng. All rights reserved.
//

#import "MyTableView.h"

@interface MyTableView ()<DZNEmptyDataSetDelegate, DZNEmptyDataSetSource>

@end

@implementation MyTableView

-(void)awakeFromNib {
    [super awakeFromNib];
    [self setMyTableView];
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self == [super initWithFrame:frame style:style]) {
        [self setMyTableView];
    }
    return self;
}

-(void)setMyTableView {
    self.tableFooterView = [[UIView alloc] init];
    self.emptyDataSetDelegate = self;
    self.emptyDataSetSource = self;
    
    
//    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerR)];
//    footer.automaticallyChangeAlpha = YES;
//    footer.automaticallyHidden = YES;
//    [footer setTitle:@"点击或上拉加载更多" forState:MJRefreshStateIdle];
//    [footer setTitle:@"正在加载更多的数据" forState:MJRefreshStateRefreshing];
//    [footer setTitle:@"沒有了" forState:MJRefreshStateNoMoreData];
//    self.mj_footer = footer;
}

-(MJRefreshNormalHeader *)headerSetup {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerR)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在刷新数据中..." forState:MJRefreshStateRefreshing];
    self.mj_header = header;
    return header;
}

-(MJRefreshAutoNormalFooter *)footerSetup {
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerR)];
    footer.automaticallyChangeAlpha = YES;
    footer.automaticallyHidden = YES;
    [footer setTitle:@"点击或上拉加载更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载更多的数据" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"沒有了" forState:MJRefreshStateNoMoreData];
    return footer;
}

-(void)headerR {
    if (self.headerRefresh) {
        self.headerRefresh();
    }
}

-(void)footerR {
    if (self.footerRefresh) {
        self.footerRefresh();
    }
}

#pragma mark - 空白页
-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    if (self.loading) {
        //        @"沒有網路下拉重新加載"
        NSString *text = _loadTitle;
        if (text == nil) {
            text = @"无";
        }
        NSDictionary * att = @{NSFontAttributeName : [CommonTools getPXFontSize:28], NSForegroundColorAttributeName : [CommonTools getColorWithHexString:@"333333"]};
        return [[NSMutableAttributedString alloc] initWithString:text attributes:att];
    }else {
        return nil;
    }
}

-(UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor whiteColor];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -150;
}
//-(CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
//    return -300;
//}

-(UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView {
    return nil;
}
//source
-(BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return YES;
}
-(BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

- (void)setLoading:(BOOL)loading{
    if (_loading != loading) {
        _loading = loading;
    }
    [self reloadEmptyDataSet];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
