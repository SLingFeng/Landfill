//
//  PersonnelView.m
//  jmxc
//
//  Created by 孙凌锋 on 2017/11/16.
//  Copyright © 2017年 孙凌锋. All rights reserved.
//

#import "PersonnelView.h"
#import "PersonnelCollectionViewCell.h"

NSInteger const rowMaxCount = 4;

@interface PersonnelView () <UICollectionViewDelegate, UICollectionViewDataSource>
{
    CGFloat _itemWH;
    CGFloat _margin;
}

@end

@implementation PersonnelView
//相关人员选择

- (instancetype)init {
    self = [super init];
    if (self) {
        self.selected = [NSMutableArray arrayWithCapacity:rowMaxCount];
        [self configCollectionView];
    }
    return self;
}

- (void)setSelected:(NSMutableArray *)selected {
    _selected = selected;
    [self.collectionView reloadData];
}

- (void)configCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _margin = kAW(10);
    _itemWH = ((kScreenW) - 4 * _margin - 4) / 4 - _margin;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(_itemWH, _itemWH);//[SLFCommonTools heightScale4_3:_itemWH]);

    layout.minimumInteritemSpacing = _margin;
    layout.minimumLineSpacing = _margin;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.contentInset = UIEdgeInsetsMake(0, kAW(10), 0, kAW(10));
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
//    _collectionView.scrollEnabled = 0;
    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self addSubview:_collectionView];
    [_collectionView registerClass:[PersonnelCollectionViewCell class] forCellWithReuseIdentifier:@"Personnel"];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.selected.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PersonnelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Personnel" forIndexPath:indexPath];

    if (indexPath.row == self.selected.count) {
        [cell addLayout];
    }else {
        [cell normalLayout];
        LYCommonOfficeUserListModel * model = self.selected[indexPath.row];
        [cell.logoIV sd_setImageWithURL:kURL_Image_Url(model.photo) placeholderImage:kPlaceholderUserImage];
        cell.titleLabel.text = model.name;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.selected.count) {
        if (self.addNew) {
            self.addNew();
        }
    }else {
        if (self.operating) {
            self.operating(indexPath);
        }
    }
}

    
    
@end
