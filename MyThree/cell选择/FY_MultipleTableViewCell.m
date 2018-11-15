//
//  FY_MultipleTableViewCell.m
//  房源管理
//
//  Created by 孙凌锋 on 2018/6/12.
//  Copyright © 2018年 孙凌锋. All rights reserved.
//

#import "FY_MultipleTableViewCell.h"

@implementation FY_MultipleTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.titleLabel = [[MyLabel alloc] initWithFontSize:30 fontColor:k333333 setText:@"标题"];
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.font = [SLFCommonTools pxBoldFont:30];

        self.titleLabel.sd_layout.topSpaceToView(self.contentView, 20).leftSpaceToView(self.contentView, kMainSpace).widthIs(kAW(70)).heightIs(20);
        
        self.mcView = [[ChoiceView alloc] init];
        [self.contentView addSubview:self.mcView];
        [self.mcView setupRadioSubView:nil];
        
        MyLabel *d = [[MyLabel alloc] initWithFontSize:22 fontColor:kAAAAAA setText:@"（最多可选3个标签）"];
        [self.contentView addSubview:d];
        
        self.mcView.sd_layout.topSpaceToView(self.contentView, 14).leftSpaceToView(self.titleLabel, 15).rightSpaceToView(self.contentView, 10);
        
        d.sd_layout.leftSpaceToView(self.titleLabel, 22).topSpaceToView(self.mcView, kAH(30)).widthIs(200).heightIs(kAH(26));
        
        [self setupAutoHeightWithBottomView:d bottomMargin:kMainSpace];
    }
    return self;
}

- (void)setModel:(FY_HouseAddCellModel *)model {
    _model = model;

    NSDictionary * style = @{@"font" : [SLFCommonTools pxFont:32],
                             @"font2" : [SLFCommonTools pxFont:32],
                             @"color" : [UIColor grayColor],
                             @"color2" : k333333,
                             @"color3" : HEXCOLOR(0xFF0000)};
    
    self.titleLabel.attributedText = [model.title attributedStringWithStyleBook:style];
    self.mcView.selectIDBlock = model.selectIDBlock;
    if (model.type == 40) {
        [self.mcView setupSubView:model.mulitpleData multiple:1];
    } else if (model.type == 41) {
        [self.mcView setupSubView:model.mulitpleData multiple:2];
    } else if (model.type == 42) {
        [self.mcView setupSubView:model.mulitpleData multiple:3];
    }
}

@end
