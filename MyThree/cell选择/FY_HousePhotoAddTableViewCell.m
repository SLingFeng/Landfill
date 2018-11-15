//
//  FY_HousePhotoAddTableViewCell.m
//  房源管理
//
//  Created by 孙凌锋 on 2018/6/9.
//  Copyright © 2018年 孙凌锋. All rights reserved.
//

#import "FY_HousePhotoAddTableViewCell.h"


@implementation FY_HousePhotoAddTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.photoView = [[TZSelectView alloc] init];
//        self.photoView.layer.cornerRadius = kAW(5);
//        self.photoView.layer.masksToBounds = YES;
        [self.contentView addSubview:_photoView];
        [_photoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.offset(0);
            make.height.mas_equalTo(120);
        }];
        
        [self setupAutoHeightWithBottomView:self.photoView bottomMargin:0];
    }
    return self;
}

- (CGFloat)cellHeight {
    return 120.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
