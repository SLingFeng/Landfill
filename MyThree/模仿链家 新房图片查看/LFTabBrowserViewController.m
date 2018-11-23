//
//  LFTabBrowserViewController.m
//
//  Created by 孙凌锋 on 2018/11/23.
//  Copyright © 2018 孙凌锋. All rights reserved.
//

#import "LFTabBrowserViewController.h"
#import "GX_LPImageViewController.h"
#import "LFTabBrowserCollectionViewCell.h"

@interface LFTabBrowserViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    LFTabTopView * _tv;
}
@property (nonatomic, retain) MyCollectionView *collectionView;

@property (nonatomic, retain) GX_LPImageModel *data;

@end

@implementation LFTabBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setStyle:3];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.data = self.obj;
    
    [self setNavigationTitle:[NSString stringWithFormat:@"1/%ld", self.data.xgC]];
    
    LFTabTopView * tv = [[LFTabTopView alloc] initWithSelectBtnArr:self.data.allTitles];
    [self.view addSubview:tv];
    _tv = tv;
    [tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(Height_NavBar);
        make.left.right.offset(0);
        make.height.mas_equalTo(50);
    }];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:(UICollectionViewScrollDirectionHorizontal)];
    
    self.collectionView = [[MyCollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tv.mas_bottom).offset(0);
        make.left.right.offset(0);
        make.bottom.offset(- iPhone_Bottom - 49);
//        make.edges.insets(UIEdgeInsetsMake(50, 0, 49 + iPhone_Bottom, 0));
    }];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.collectionView.pagingEnabled = 1;
    [self.collectionView registerClass:[LFTabBrowserCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"header_back_icon"] style:(UIBarButtonItemStylePlain) target:self action:@selector(back)];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"全部图片" style:(UIBarButtonItemStylePlain) target:self action:@selector(allPhoto)];

    kWeakSelf(weakSelf);
    //点击滚动
    tv.selectBtnClick = ^(NSInteger tag) {
        [weakSelf.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:tag] atScrollPosition:(UICollectionViewScrollPositionNone) animated:1];
    };
}

- (void)allPhoto {
    [self.navigationController popViewControllerAnimated:1];
}

- (void)back {
    [self.navigationController dismissViewControllerAnimated:1 completion:nil];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.data.allPhoto.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.data.allPhoto[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LFTabBrowserCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
   
    NSArray *arr = self.data.allPhoto[indexPath.section];
    NSDictionary *dic = arr[indexPath.row];
    NSString *url = dic[@"img_url"];
    
    [cell.imageview sd_setImageWithURL:kURL_Urlstring(url) placeholderImage:[UIImage imageNamed:@"gongyi_home_pic"]];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kScreenW, kScreenH - Height_NavBar - Height_TabBar - 50 - iPhone_Top);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - scrollview代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int index = (scrollView.contentOffset.x + self.collectionView.bounds.size.width * 0.5) / self.collectionView.bounds.size.width;
    
        NSLog(@"scr:%d", index);
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    for (LFTabBrowserCollectionViewCell *cell in self.collectionView.visibleCells) {
        cell.scrollview.zoomScale = 1.0;
    }
}
//scrollview结束滚动调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger autualIndex = scrollView.contentOffset.x  / self.collectionView.bounds.size.width + 1;
//    [self setNavigationTitle:[SLFCommonTools strToInt:autualIndex + 1]];
//    NSLog(@"end:%d", autualIndex);
    NSString *title;
    //滑动 top到相应标题
    if (autualIndex <= self.data.xgC) {
        _tv.isSelectBtn = 0;
        title = [NSString stringWithFormat:@"%ld/%ld", autualIndex, self.data.xg.count];
        
    }else if (autualIndex <= self.data.sjC) {
        _tv.isSelectBtn = 1;
        title = [NSString stringWithFormat:@"%ld/%ld", autualIndex - self.data.xgC, self.data.sj.count];
        
    }else if (autualIndex <= self.data.hxC) {
        _tv.isSelectBtn = 2;
        title = [NSString stringWithFormat:@"%ld/%ld", autualIndex - self.data.sjC, self.data.hx.count];

    }else if (autualIndex <= self.data.zbC) {
        _tv.isSelectBtn = 3;
        title = [NSString stringWithFormat:@"%ld/%ld", autualIndex - self.data.hxC, self.data.zb.count];

    }else if (autualIndex <= self.data.sbC) {
        _tv.isSelectBtn = 4;
        title = [NSString stringWithFormat:@"%ld/%ld", autualIndex - self.data.sjC, self.data.sb.count];

    }
    [self setNavigationTitle:title];
    
}

@end




@interface LFTabTopView ()
{
    UIView * _selectView;
    NSMutableArray *_btnArr;
//    UIButton * _lastBtn;
    
}
@property (nonatomic, retain) UIScrollView *sv;
@end
@implementation LFTabTopView

-(instancetype)initWithSelectBtnArr:(NSArray *)titles {
    if (self = [super init]) {
//        kWeakSelf(weakSelf);
//        CGFloat w = kScreenW / titles.count;

        self.sv = [[UIScrollView alloc] init];
        [self addSubview:self.sv];
        self.sv.showsVerticalScrollIndicator = NO;
        self.sv.showsHorizontalScrollIndicator = NO;
        
        self.sv.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
        
        UIView * select = [[UIView alloc] init];
        [self.sv addSubview:select];
        select.backgroundColor = HEXCOLORA(0xFFFFFF, 0.2);
        kViewBorderRadius(select, 16, 0, [UIColor clearColor]);
        _selectView = select;
        
        _btnArr = [NSMutableArray arrayWithCapacity:titles.count];
        UIView *l;
        for (int i=0; i<titles.count;i++) {
            UIButton * btn = [[UIButton alloc] init];
            btn.tag = i+10;
            [self.sv addSubview:btn];
            
            btn.titleLabel.font = [SLFCommonTools pxBoldFont:28];
            [btn setTitle:titles[i] forState:(UIControlStateNormal)];
            [btn setTitleColor:kFFFFFF forState:(UIControlStateNormal)];
            
//            [btn setTitleColor:self.selcectBtnTextColor forState:(UIControlStateSelected)];
            [btn addTarget:self action:@selector(selectClassClick:) forControlEvents:(UIControlEventTouchUpInside)];
            
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);

            CGFloat btnW = [SLFCommonTools textSize:titles[i] font:[SLFCommonTools pxFont:28]].width + 26;
            
            if (l == nil) {
                btn.sd_layout.leftSpaceToView(self.sv, kMainSpace).topSpaceToView(self.sv, 8).heightIs(35).widthIs(btnW);
                [btn updateLayout];
            }else {
                
//                if (kScreenW - CGRectGetMaxX(l.frame) > btnW) {
                    btn.sd_layout.centerYEqualToView(l).leftSpaceToView(l, 5).heightIs(32).widthIs(btnW);
                    [btn updateLayout];
//                }else {
//                    btn.sd_layout.leftSpaceToView(self, kMainSpace).topSpaceToView(l, 5).heightIs(35).widthIs(btnW);
//                    [btn updateLayout];
//                }
            }
            
//            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.width.mas_equalTo(w);
//                //.with.offset(CGRectGetWidth(weakSelf.frame)/2*i);
//                if (i == 0) {
//                    make.left.equalTo(weakSelf).with.offset(0);
//                    //                    make.right.equalTo(weakSelf.mas_centerX);
//                }else {
//                    make.left.equalTo(l.mas_right);
//                    //                    make.right.equalTo(@(CGRectGetWidth(weakSelf.frame)));
//                }
//                make.top.bottom.offset(0);
//            }];
            if (i == 0) {
//                btn.selected = 1;
//                _lastBtn = btn;
//                select.sd_layout.centerYEqualToView(btn).heightIs(32);
//                select.center = btn.center;
//                CGRect r = select.frame;
//                r.size.width = btn.width_sd;
//                select.frame = r;
                
                select.frame = CGRectMake(0, 0, btn.width_sd, 32);
                [self scrollTo:btn];

//                [select mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.centerY.equalTo(btn);
//                    make.width.mas_equalTo(btn.mas_width);
//                    make.height.mas_equalTo(32);
//                    make.centerX.equalTo(btn);
//                }];
            }
            l = btn;
            [_btnArr addObject:btn];
        }
        self.sv.contentSize = CGSizeMake(CGRectGetMaxX(l.frame) + 20, 50);
    }
    return self;
}

-(void)selectClassClick:(UIButton *)btn {
    
//    _lastBtn = btn;
    self.isSelectBtn = btn.tag - 10;
    if (self.selectBtnClick) {
        self.selectBtnClick(btn.tag-10);
    }
}


- (void)setIsSelectBtn:(NSInteger)isSelectBtn {
    _isSelectBtn = isSelectBtn;
    for (UIButton *b in _btnArr) {
        b.selected = NO;
    }
    UIButton * btn = [self viewWithTag:_isSelectBtn + 10];

    [self scrollTo:btn];
    
//    [UIView animateWithDuration:0.3 animations:^{
//        CGPoint p = self->_selectView.center;
//        p.x = btn.centerX;
//        self->_selectView.center = p;
//
//        CGSize s = self->_selectView.size;
//        s.width = btn.width_sd;
//        self->_selectView.size = s;
//    }];
//    btn.selected = 1;

}

- (void)scrollTo:(UIButton *)btn {
    
    [UIView animateWithDuration:0.33 animations:^{
        CGRect r = self->_selectView.frame;
        r.size.width = btn.width_sd;
        r.origin.y = btn.centerY - r.size.height * 0.5;
        r.origin.x = btn.centerX - r.size.width * 0.5;
        self->_selectView.frame = r;
    }];

//    [_selectView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(btn.mas_centerX);
//        make.width.mas_equalTo(btn.mas_width);
//    }];

    
    
    CGFloat offsetX = btn.centerX - btn.width_sd/2 - 5;
    if (offsetX < 0) {
        offsetX = 0;
    }
    
    CGFloat maxRight = self.sv.contentSize.width - kScreenW;
    if (offsetX > maxRight) {
        offsetX = maxRight;
    }
    [self.sv setContentOffset:CGPointMake(offsetX, 0) animated:1];
}

@end
