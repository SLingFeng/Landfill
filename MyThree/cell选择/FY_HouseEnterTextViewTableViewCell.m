//
//  FY_HouseEnterTextViewTableViewCell.m
//  房源管理
//
//  Created by 孙凌锋 on 2018/6/9.
//  Copyright © 2018年 孙凌锋. All rights reserved.
//

#import "FY_HouseEnterTextViewTableViewCell.h"

@implementation FY_HouseEnterTextViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLabel = [[MyLabel alloc] initWithFontSize:30 fontColor:k333333 setText:@"标题"];
        [self.contentView addSubview:self.titleLabel];
//        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [SLFCommonTools pxBoldFont:30];

        
        FSTextView *textView = [[FSTextView alloc] init];
        textView.placeholder = @"请输入";
        [textView setFont:[SLFCommonTools pxFont:28]];
        textView.maxLength = 500;
        [self.contentView addSubview:textView];
        self.textView = textView;
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(20);
            make.left.offset(15);
            make.width.mas_equalTo(kAW(70));
        }];
        
        [textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(15);
            make.right.offset(-15);
            make.left.equalTo(self.titleLabel.mas_right).offset(30);
            make.height.offset(60);
        }];
        
        [self setupAutoHeightWithBottomView:textView bottomMargin:20];

    }
    return self;
}

- (CGFloat)cellHeight {
    return 100;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
