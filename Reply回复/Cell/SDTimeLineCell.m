//
//  SDTimeLineCell.m
//  GSD_WeiXin(wechat)
//
//  Created by gsd on 16/2/25.
//  Copyright © 2016年 GSD. All rights reserved.
//

/*
 
 *********************************************************************************
 *
 * GSD_WeiXin
 *
 * QQ交流群: 459274049
 * Email : gsdios@126.com
 * GitHub: https://github.com/gsdios/GSD_WeiXin
 * 新浪微博:GSD_iOS
 *
 * 此“高仿微信”用到了很高效方便的自动布局库SDAutoLayout（一行代码搞定自动布局）
 * SDAutoLayout地址：https://github.com/gsdios/SDAutoLayout
 * SDAutoLayout视频教程：http://www.letv.com/ptv/vplay/24038772.html
 * SDAutoLayout用法示例：https://github.com/gsdios/SDAutoLayout/blob/master/README.md
 *
 *********************************************************************************
 
 */

#import "SDTimeLineCell.h"

#import "SDTimeLineCellModel.h"
#import "UIView+SDAutoLayout.h"
#import "SDTimeLineCellCommentView.h"
#import "SDWeiXinPhotoContainerView.h"
//#import "SDTimeLineCellOperationMenu.h"


const CGFloat contentLabelFontSize = 15;
CGFloat maxContentLabelHeight = 0; // 根据具体font而定

NSString *const kSDTimeLineCellOperationButtonClickedNotification = @"SDTimeLineCellOperationButtonClickedNotification";

@interface SDTimeLineCell ()<SDTimeLineCommentDelegate>

@end

@implementation SDTimeLineCell

{
//    UIImageView *_iconView;
//    UILabel *_nameLable;
//    UILabel *_contentLabel;
    SDWeiXinPhotoContainerView *_picContainerView;
//    UILabel *_timeLabel;
//    UIButton *_moreButton;
//    UIButton *_operationButton;
    
    MyLabel * _userNameLabel;
    MyLabel * _contentLabel;
    MyLabel * _timeLabel;
    
    BaseImageView * _logo;
    
    UIButton * _replyBtn;
    UIButton * _leterBtn;
    
    SDTimeLineCellCommentView *_commentView;
//    SDTimeLineCellOperationMenu *_operationMenu;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setup];
        

        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setup
{
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveOperationButtonClickedNotification:) name:kSDTimeLineCellOperationButtonClickedNotification object:nil];
    _commentView = [[SDTimeLineCellCommentView alloc] init];
    _commentView.delegate = self;
    _picContainerView = [[SDWeiXinPhotoContainerView alloc] init];
    
    _logo = [[BaseImageView alloc] initWithRadius:15];
    [self.contentView addSubview:_logo];
    
    _userNameLabel = [[MyLabel alloc] init];
    [self.contentView addSubview:_userNameLabel];
    
    _contentLabel = [[MyLabel alloc] init];
    [self.contentView addSubview:_contentLabel];
    
    _timeLabel = [[MyLabel alloc] init];
    _timeLabel.textColor = [CommonTools getColorWithHexString:@"999999"];
    [self.contentView addSubview:_timeLabel];
    
    _replyBtn = [[UIButton alloc] init];
    _replyBtn.tag = 100;
    _replyBtn.layer.cornerRadius = 10.5;
    _replyBtn.layer.masksToBounds = 1;
    _replyBtn.layer.borderWidth = 1;
    _replyBtn.layer.borderColor = [CommonTools getColorWithHexString:@"c9c9c9"].CGColor;
    [_replyBtn setTitleColor:[CommonTools getColorWithHexString:@"666666"] forState:(UIControlStateNormal)];
    _replyBtn.titleLabel.font = [CommonTools getPXFontSize:22];
    [_replyBtn setTitle:@"回复" forState:(UIControlStateNormal)];
    [_replyBtn setImage:[UIImage imageNamed:@"回复"] forState:(UIControlStateNormal)];
    _replyBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
    [_replyBtn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.contentView addSubview:_replyBtn];
    
    _leterBtn = [[UIButton alloc] init];
    _leterBtn.layer.cornerRadius = 10.5;
    _leterBtn.layer.masksToBounds = 1;
    _leterBtn.layer.borderWidth = 1;
    _leterBtn.layer.borderColor = [CommonTools getColorWithHexString:@"c9c9c9"].CGColor;
    [_leterBtn setTitleColor:[CommonTools getColorWithHexString:@"666666"] forState:(UIControlStateNormal)];
    _leterBtn.titleLabel.font = [CommonTools getPXFontSize:22];
    [_leterBtn setTitle:@"私信" forState:(UIControlStateNormal)];
    [_leterBtn setImage:[UIImage imageNamed:@"私信"] forState:(UIControlStateNormal)];
    _leterBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
    [_replyBtn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.contentView addSubview:_leterBtn];
    
    NSArray *views = @[_userNameLabel, _contentLabel, _contentLabel, _timeLabel, _commentView, _picContainerView, _logo, _replyBtn, _leterBtn];
    
    [self.contentView sd_addSubviews:views];
    
    _logo.sd_layout.widthIs(30).heightIs(30).leftSpaceToView(self.contentView, 15).topSpaceToView(self.contentView, 20);
    _userNameLabel.sd_layout.heightIs(20).centerYEqualToView(_logo).leftSpaceToView(_logo, 7.5).rightSpaceToView(self.contentView, 15);
    _contentLabel.sd_layout.leftSpaceToView(self.contentView, 15).rightSpaceToView(self.contentView, 15).topSpaceToView(_logo, 13.5);
    
    _picContainerView.sd_layout.leftSpaceToView(self.contentView, 15).rightSpaceToView(self.contentView, 15).topSpaceToView(_contentLabel, 10);
    
    _commentView.sd_layout.leftEqualToView(_contentLabel).rightSpaceToView(self.contentView, 15); // 已经在内部实现高度自适应所以不需要再设置高度

    _timeLabel.sd_layout.widthIs(150).leftSpaceToView(self.contentView, 15).topSpaceToView(_commentView, 23).heightIs(20);
    _leterBtn.sd_layout.widthIs(58).heightIs(21).centerYEqualToView(_timeLabel).rightSpaceToView(self.contentView, 15);
    _replyBtn.sd_layout.widthIs(58).heightIs(21).centerYEqualToView(_timeLabel).rightSpaceToView(_leterBtn, 12.5);  
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setModel:(ChargePileCommentOneInfoModel *)model {
    _model = model;
    
    _userNameLabel.text = [CommonTools hiddenPhone:model.NCOName];
    _contentLabel.text = model.NCOContent;
    _timeLabel.text = model.NCOCreate_time;
    _commentView.sd_layout.topSpaceToView(_contentLabel, 25);
    
    _contentLabel.sd_layout.heightIs([CommonTools getSizeHeightForText:_contentLabel.text font:_contentLabel.font weight:kScreenW-30]).maxHeightIs(_contentLabel.font.lineHeight * 3);;
    
    [_logo sd_setImageWithURL:userHeadImage(model.NCOSmallpic) placeholderImage:kPlaceholderUserImage];
    
    if (model.pic != nil) {
        _picContainerView.hidden = 0;
        _picContainerView.picPathStringsArray = model.pic;
        _commentView.sd_resetLayout.topSpaceToView(_picContainerView, 25).leftEqualToView(_contentLabel).rightSpaceToView(self.contentView, 15);
        _timeLabel.sd_resetLayout.topSpaceToView(_commentView, 23).widthIs(150).leftSpaceToView(self.contentView, 15).heightIs(20);

    }else {
        _picContainerView.hidden = 1;
    }
    if (model.two != nil) {
        _commentView.hidden = 0;
        [_commentView setupWithLikeItemsArray:nil commentItemsArray:model.two];
        
    }else {
        _commentView.hidden = 1;
        _timeLabel.sd_resetLayout.topSpaceToView(_picContainerView, 23).widthIs(150).leftSpaceToView(self.contentView, 15).heightIs(20);
    }
    if (model.two == nil && model.pic == nil) {
        _timeLabel.sd_resetLayout.widthIs(150).leftSpaceToView(self.contentView, 15).topSpaceToView(_contentLabel, 23).heightIs(20);
    }
    
    
    
//    _timeLabel.sd_resetLayout.leftSpaceToView(self.contentView, 15).rightSpaceToView(_commentView, 15).topSpaceToView(_contentLabel, 23).heightIs(20);
    
//    UIView *bottomView;
    
//    if (!model.info.count) {
//        bottomView = _timeLabel;
//    } else {
//        bottomView = _commentView;
//    }
    
    [self setupAutoHeightWithBottomView:_timeLabel bottomMargin:15];
    
}

//- (void)setFrame:(CGRect)frame
//{
//    [super setFrame:frame];
////    if (_operationMenu.isShowing) {
////        _operationMenu.show = NO;
////    }
//}

#pragma mark - private actions

-(void)btnClick:(UIButton *)btn {
//    if (self.ButtonClickedBlock) {
//        self.ButtonClickedBlock(self.indexPath, btn);
//    }
    if (btn.tag == 100) {
        if ([self.delegate respondsToSelector:@selector(didClickCommentButtonInCell:idd:name:label:)]) {
            [self.delegate didClickCommentButtonInCell:self idd:nil name:nil label:nil];
        }
    }else {
        if ([self.delegate respondsToSelector:@selector(didClickSixinButtonInCell:)]) {
            [self.delegate didClickSixinButtonInCell:self];
        }
    }
}

-(void)didNameClick:(NSString *)idd name:(NSString *)name label:(MLLinkLabel *)label {
    if ([self.delegate respondsToSelector:@selector(didClickCommentButtonInCell:idd:name:label:)]) {
        [self.delegate didClickCommentButtonInCell:self idd:idd name:name label:label];
    }
}

//- (void)moreButtonClicked
//{
//    if (self.moreButtonClickedBlock) {
//        self.moreButtonClickedBlock(self.indexPath);
//    }
//}
//
//- (void)operationButtonClicked
//{
//    [self postOperationButtonClickedNotification];
////    _operationMenu.show = !_operationMenu.isShowing;
//}
//
//- (void)receiveOperationButtonClickedNotification:(NSNotification *)notification
//{
////    UIButton *btn = [notification object];
//    
////    if (btn != _operationButton && _operationMenu.isShowing) {
////        _operationMenu.show = NO;
////    }
//}
//
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [super touchesBegan:touches withEvent:event];
//    [self postOperationButtonClickedNotification];
////    if (_operationMenu.isShowing) {
////        _operationMenu.show = NO;
////    }
//}
//
//- (void)postOperationButtonClickedNotification
//{
////    [[NSNotificationCenter defaultCenter] postNotificationName:kSDTimeLineCellOperationButtonClickedNotification object:_operationButton];
//}

@end

