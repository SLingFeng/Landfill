//
//  LF_TableSelectView.h
//
//
//  Created by 孙凌锋 on 2018/11/13.
//  Copyright © 2018 孙凌锋. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LF_TableSelectTypeError,
    LF_TableSelectTypeSingle,
    LF_TableSelectTypeDouble,
    LF_TableSelectTypeThree,
    LF_TableSelectTypeCustomizeLabel,
    
} LF_TableSelectype;

typedef void (^LF_TableSelectIndexBlock)(NSInteger one, NSInteger two, NSInteger three);
typedef void (^LF_TableSelectNameBlock)(NSInteger one, NSString *name);
NS_ASSUME_NONNULL_BEGIN

@interface LF_TableSelectView : UIView


@property (nonatomic, retain) UIView *backgroundView;

@property (nonatomic, retain) NSString *nameStr;

+ (instancetype)selectWithDataArr:(NSArray *)dataArr type:(LF_TableSelectype)type block:(LF_TableSelectNameBlock)block;

+ (instancetype)selectWithDataArr:(NSArray *)dataArr block:(LF_TableSelectIndexBlock)block;

+ (instancetype)selectWithDataArr:(NSArray *)dataArr two:(NSArray *)two block:(LF_TableSelectIndexBlock)block;

+ (instancetype)selectWithDataArr:(NSArray *)dataArr two:(NSArray *)two three:(NSArray *)three block:(LF_TableSelectIndexBlock)block;

@end

@interface LF_TableSelectSubView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) NSMutableArray *dataArr;

@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, copy) LF_TableSelectNameBlock block;;

@property (nonatomic) LF_TableSelectype type;

- (instancetype)initWithData:(NSArray *)data block:(LF_TableSelectNameBlock)block;

@end

@interface LF_TableSelectSubCell : UITableViewCell

@property (nonatomic, retain) BaseTextField *tf;

@end

NS_ASSUME_NONNULL_END
