//
//  SDTimeLineCellCommentView.m
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

#import "SDTimeLineCellCommentView.h"
#import "UIView+SDAutoLayout.h"
#import "SDTimeLineCellModel.h"


//#import "LEETheme.h"

@interface SDTimeLineCellCommentView () <MLLinkLabelDelegate>
{
    NSInteger _sum;
}
//@property (nonatomic, strong) NSArray *likeItemsArray;
@property (nonatomic, strong) NSArray *commentItemsArray;

//@property (nonatomic, strong) UIImageView *bgImageView;
//
//@property (nonatomic, strong) MLLinkLabel *likeLabel;
//@property (nonatomic, strong) UIView *likeLableBottomLine;

@property (nonatomic, strong) NSMutableArray *commentLabelsArray;


@end

@implementation SDTimeLineCellCommentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setCommentItemsArray:(NSArray *)commentItemsArray
{
    _commentItemsArray = commentItemsArray;
    long limian = 0;
    
    for (ChargePileCommentTwoInfoModel *model in self.commentItemsArray) {
        for (int i=0; i<model.three.count; i++) {
            limian += 1;
        }
    }

    long originalLabelsCount = self.commentLabelsArray.count;
    long needsToAddCount = commentItemsArray.count+limian > originalLabelsCount ? (commentItemsArray.count+limian - originalLabelsCount) : 0;
    
    _sum = commentItemsArray.count+limian;
    for (int i = 0; i < needsToAddCount; i++) {
        MLLinkLabel *label = [MLLinkLabel new];
        label.dataDetectorTypes = MLDataDetectorTypeAttributedLink;
        label.dataDetectorTypesOfAttributedLinkValue = MLDataDetectorTypeAttributedLink;
        label.linkTextAttributes = @{NSForegroundColorAttributeName : RGBCOLOR(50, 91, 123)};
        label.font = [CommonTools getPXFontSize:26];
        label.delegate = self;
        [self addSubview:label];
        [self.commentLabelsArray addObject:label];
        
    }
    int num = 0;
    int section = 0;
    for (ChargePileCommentTwoInfoModel *twomodel in commentItemsArray) {
        MLLinkLabel *label = self.commentLabelsArray[num];
        label.linkTextAttributes = @{NSForegroundColorAttributeName : RGBCOLOR(50, 91, 123),
                                     @"index" : [NSIndexPath indexPathForRow:0 inSection:section],
                                     @"lv" : @"2"};
        label.attributedText = [self generateAttributedStringWithCommentItemModel:twomodel type:0];
        section += 1;
        num += 1;
        if (twomodel.three != nil) {
            for (int x=0; x<twomodel.three.count; x++) {
                ChargePileCommentThreeInfoModel *threeModel = twomodel.three[x];
                MLLinkLabel *label = (MLLinkLabel *)self.commentLabelsArray[num];
                label.linkTextAttributes = @{NSForegroundColorAttributeName : RGBCOLOR(50, 91, 123),
                                             @"index" : [NSIndexPath indexPathForRow:x+1 inSection:section],
                                             @"NREId" : threeModel.NRELastid,
                                             @"lv" : @"3"};
                label.attributedText = [self generateAttributedStringWithCommentItemModel:threeModel type:1];
                num += 1;
            }
        }
        
    }
    NSLog(@"%d", num);
}


- (NSMutableArray *)commentLabelsArray
{
    if (!_commentLabelsArray) {
        _commentLabelsArray = [NSMutableArray new];
    }
    return _commentLabelsArray;
}

- (void)setupWithLikeItemsArray:(NSArray *)likeItemsArray commentItemsArray:(NSArray *)commentItemsArray
{
//    self.likeItemsArray = likeItemsArray;
    self.commentItemsArray = commentItemsArray;
    
    if (self.commentLabelsArray.count) {
        [self.commentLabelsArray enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL *stop) {
            [label sd_clearAutoLayoutSettings];
            label.hidden = YES; //重用时先隐藏所以评论label，然后根据评论个数显示label
        }];
    }
    
    if (!commentItemsArray.count && !likeItemsArray.count) {
        self.fixedWidth = @(0); // 如果没有评论或者点赞，设置commentview的固定宽度为0（设置了fixedWith的控件将不再在自动布局过程中调整宽度）
        self.fixedHeight = @(0); // 如果没有评论或者点赞，设置commentview的固定高度为0（设置了fixedHeight的控件将不再在自动布局过程中调整高度）
        return;
    } else {
        self.fixedHeight = nil; // 取消固定宽度约束
        self.fixedWidth = nil; // 取消固定高度约束
    }
    
    UIView *lastTopView = nil;
    
    for (int i = 0; i < _sum; i++) {
        UILabel *label = (UILabel *)self.commentLabelsArray[i];
        label.hidden = NO;
        CGFloat topMargin = (i == 0 && likeItemsArray.count == 0) ? 10 : 5;
        label.sd_layout
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .topSpaceToView(lastTopView, topMargin)
        .autoHeightRatio(0);
        
        label.isAttributedContent = YES;
        lastTopView = label;
    }
    
    [self setupAutoHeightWithBottomView:lastTopView bottomMargin:6];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

#pragma mark - private actions

- (NSMutableAttributedString *)generateAttributedStringWithCommentItemModel:(id)model1 type:(NSInteger)type {
    NSString *firstUserName = nil;
    NSString *secondUserName = nil;
    NSString *firstUserId = @"0";
    NSString *secondUserId = @"0";
    NSString *commentString;
    
    if (type == 0) {//二级评论
        ChargePileCommentTwoInfoModel * model = model1;
        if (model.NRESender_nick != nil) {
            firstUserName = model.NRESender_nick;
        }else {
            firstUserName = [CommonTools hiddenPhone:model.NRESender];
        }
        firstUserId = model.NRESender;
//        if (model.NREReceiver) {
//            if (model.NREReceiver_nick != nil) {
//                secondUserName = model.NREReceiver_nick;
//            }else {
//                secondUserName = [CommonTools hiddenPhone:model.NREReceiver];
//            }
//            secondUserId = model.NREReceiver;
//        }
        commentString = model.NREContent;
        
    }else {//三级评论
        ChargePileCommentThreeInfoModel * model = model1;
        if (model.NRESender_nick != nil) {
            firstUserName = model.NRESender_nick;
        }else {
            firstUserName = [CommonTools hiddenPhone:model.NRESender];
        }
        firstUserId = model.NRESender;
        if (model.NREReceiver) {
            if (model.NREReceiver_nick != nil) {
                secondUserName = model.NREReceiver_nick;
            }else {
                secondUserName = [CommonTools hiddenPhone:model.NREReceiver];
            }
            secondUserId = model.NREReceiver;
        }
        commentString = model.NREContent;
    }
    
    NSString *text = firstUserName;
    if (secondUserName) {
        text = [text stringByAppendingString:[NSString stringWithFormat:@"回复%@", secondUserName]];
    }
    text = [text stringByAppendingString:[NSString stringWithFormat:@"：%@", commentString]];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
    [attString setAttributes:@{NSLinkAttributeName : firstUserId} range:[text rangeOfString:firstUserName]];
    if (secondUserName) {
        [attString setAttributes:@{NSLinkAttributeName : secondUserId} range:[text rangeOfString:secondUserName]];
    }
    return attString;
}

#pragma mark - MLLinkLabelDelegate

- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText linkLabel:(MLLinkLabel *)linkLabel
{
//    if (self.nameClick) {
//        self.nameClick(link.linkValue);
//    }
    if ([self.delegate respondsToSelector:@selector(didNameClick:name:label:)]) {
        [self.delegate didNameClick:link.linkValue name:linkText label:linkLabel];
    }
    NSIndexPath * index = linkLabel.linkTextAttributes[@"index"];
    NSLog(@"%@-------%@-", link.linkValue, linkText);
    NSLog(@"%ld------%ld", index.section, index.row);
    NSLog(@"asdf:%@", linkLabel.linkTextAttributes);
}

@end
