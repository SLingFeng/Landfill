//
//  CommonTools.h
//  RenCaiKu
//
//  Created by mac on 16/5/31.
//  Copyright © 2016年 LingFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonTools : NSObject

+(CommonTools *)shareTools;
/**
 *  @author LingFeng, 2016-06-08 11:06:07
 *
 *  设置tabbar
 */
+(void)setupTabbarViewControllers:(UIWindow *)window;

+ (BOOL)isFontDownloaded:(NSString *)fontName;
/**
 *  @author LingFeng, 2016-06-08 11:06:15
 *
 *  判断用户是否存在
 *
 *  @return yes存在 no不存在
 */
+(BOOL)isUserData;
/**
 *  @author LingFeng, 2016-06-08 11:06:04
 *
 *  根据宽度获取label文字 高度
 *
 *  @param text     文字
 *  @param fontSize 字体大小
 *  @param weight   根据高宽度
 *
 *  @return 高度
 */
+(CGFloat)textHight:(NSString *)text font:(CGFloat)fontSize width:(CGFloat)width;
+(CGSize)textSize:(NSString *)text font:(UIFont *)font;
///对比版本号
+(BOOL)isCurrentVersionChange;
#pragma mark - 生成不重复随机数
+(NSArray *)getUniqueRandomNumberGeneration:(NSInteger)count;
#pragma mark - 颜色
/**
 *  @author LingFeng, 2016-06-08 11:06:46
 *
 *  标题颜色
 *
 *  @return 颜色
 */
+(UIColor *)getTitleColor;
/**
 *  @author LingFeng, 2016-06-08 11:06:02
 *
 *  次级标题颜色
 *
 *  @return 颜色
 */
+(UIColor *)getSecondaryTitleColor;
/**
 *  @author LingFeng, 2016-06-08 11:06:12
 *
 *  正文顏色
 *
 *  @return 顏色
 */
+(UIColor *)getTextLightColor;
/**
 *  @author LingFeng, 2016-06-13 14:06:19
 *
 *  文本高亮颜色
 *
 *  @return 文本高亮颜色
 */
+(UIColor *)getTextHColor;
/**
 *  @author LingFeng, 2016-06-08 11:06:22
 *
 *  导航颜色
 *
 *  @return 导航颜色
 */
+(UIColor *)getNavBarColor;
/**
 *  @author LingFeng, 2016-06-08 11:06:36
 *
 *  导航字体颜色
 *
 *  @return 导航字体颜色
 */
+(UIColor *)getNavTintTextColor;
/**
 * @author LingFeng, 2016-06-24 09:06:29
 *
 * 正常字体颜色
 *
 * @return 正常字体颜色 51 33
 */
+(UIColor *)getFontNormalColor;
/**
 * @author LingFeng, 2016-06-24 09:06:54
 *
 * 字体颜色
 *
 * @return 字体颜色 102 66
 */
+(UIColor *)getFontLightColor;
/**
 * @author LingFeng, 2016-06-24 09:06:07
 *
 * 字体颜色
 *
 * @return 字体颜色 153 99
 */
+(UIColor *)getFontDarkColor;

/**
 *  @author LingFeng, 2016-06-08 17:06:32
 *
 *  背景颜色
 *
 *  @return 背景颜色
 */
+(UIColor *)getBackgroundColor;

+(UIColor *)getBackgroundDarkColor;

+(UIColor *)getBackgroundLightColor;

//颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor *)colorHex:(NSString *)color;
+ (UIColor *)colorHex:(NSString *)color alpha:(CGFloat)alpha;
#pragma mark - tableViewCell下面的线位置
+(void)tableCellSeparator:(UITableView *)table left:(CGFloat)left right:(CGFloat)right;
#pragma mark - 画线
/**
 * @author LingFeng, 2016-07-04 14:07:08
 *
 * 画一条横向线
 * @param hight 线对于y的高度
 * @param space 线对于左右的空间
 */
+(void)drawLineToHight:(float)hight spaceForRightAndLetf:(float)space;
/**
 * @author LingFeng, 2016-07-29 10:07:46
 *
 * 画一条横向虚线
 * @param hight 线对于y的高度
 * @param space 线对于左右的空间
 */
+(void)drawDashLineToHight:(float)hight spaceForRightAndLetf:(float)space;

/**
 * @author LingFeng, 2016-10-12 14:07:46
 *
 * 画一条I向
 * @param X 对于X位置
 * @param topSpace 线初始位置
 * @param bottomSpace 线终点位置
 */
+(void)drawLineToX:(float)X topSpace:(float)topSpace bottomSpace:(float)bottomSpace;

+(void)drawLineToY:(CGFloat)y spaceForRightAndLetf:(CGFloat)space color:(UIColor *)color lineW:(CGFloat)lineW;
+(void)drawLineToY:(CGFloat)y leftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace color:(UIColor *)color lineW:(CGFloat)lineW;

+(UIView *)lineViewToHight:(float)hight spaceForRightAndLetf:(float)space;

+ (void)line:(UIView *)view y:(CGFloat)y color:(NSString *)color;

+(void)line:(UIView *)view y:(CGFloat)y space:(CGFloat)space color:(NSString *)color;

+(void)line:(UIView *)view y:(CGFloat)y space:(CGFloat)space color:(NSString *)color lineW:(CGFloat)lineW;
+(void)line:(UIView *)view y:(CGFloat)y leftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace color:(NSString *)color lineW:(CGFloat)lineW;

+(void)lineDash:(UIView *)view hight:(CGFloat)hight x:(CGFloat)x y:(CGFloat)y color:(NSString *)color lineW:(CGFloat)lineW;
#pragma mark - 清除缓存
+(NSString *)clearMsg;
+(void)clearAll:(UIViewController *)vc;
#pragma mark - 判断
+(BOOL)kongGe:(NSString *)text;

#pragma mark - 用户信息
+(void)setUserInfo:(int)idd name:(NSString *)name
/**
 *  @author LingFeng, 2016-06-08 11:06:46
 *
 *  根据本地存放pls文件获取用户名
 *
 *  @return 用户名
 */
+(NSString *)getUserName;
/**
 *  @author LingFeng, 2016-06-12 16:06:22
 *
 *  根据本地存放pls文件获取用户id
 *
 *  @return 用户id
 */
+(NSString *)getUserID;
+(void)setUserKey:(NSString *)key value:(NSString *)value
+(NSString *)getUserKey:(NSString *)key
#pragma mark - 其他
/**
 * @author LingFeng, 2016-06-23 16:06:36
 *
 * 去掉返回按钮文字
 *
 * @param bai 去掉返回按钮文字 白色返回Yes
 */
+(void)setupNavBackBtn:(BOOL)bai;
/**
 * @author LingFeng, 2016-07-25 10:07:40
 *
 * 设置状态导航条颜色
 * @param weak <#weak description#>
 * @param bai <#bai description#>
 */
+(void)setupSatuts:(UIViewController *)weak bai:(BOOL)bai;
/**
 * @author LingFeng, 2016-06-24 09:06:34
 *
 * 设置分享按钮
 *
 * @param weakSelf 当前视图控制器->设置分享按钮
 * @param bai 去掉返回按钮文字 白色返回Yes
 */
-(void)setupNavRightShareBtn:(UIViewController *)weakSelf bai:(BOOL)bai;
/**
 * @author LingFeng, 2016-06-24 09:06:02
 *
 * 分享点击方法
 */
@property (copy, nonatomic) void(^NavRightShareBtnClick)();
/**
 * @author LingFeng, 2016-06-30 09:06:07
 *
 * alert的确定点击方法
 */
@property (copy, nonatomic) void (^alertClick)();
/**
 * @author LingFeng, 2016-07-14 17:07:23
 *
 * 警告框
 * @param weakSelf 当前视图控制器->设置警告框
 * @param title 标题
 * @param text 文字内容
 * @param cancel 是否显示取消按钮 Yes显示 no不显示
 */
+(void)showAlertViewTo:(UIViewController *)weakSelf title:(NSString *)title text:(NSString *)text cancel:(BOOL)cancel;
#pragma mark - 自适应宽高
+(CGFloat)adaptiveWidth:(CGFloat)width;
+(CGFloat)adaptiveHeight:(CGFloat)height;
#pragma mark - 比例
+(CGFloat)heightScale4_3:(CGFloat)width;
+(CGFloat)widthScale4_3:(CGFloat)height;
#pragma mark - 转换 字体
+(UIFont *)pxFont:(CGFloat)size;

+(UIFont *)pxBoldFont:(CGFloat)size;

+(NSString *)strToInt:(NSInteger)intt;

+(NSString *)strToFloat:(CGFloat)floatt;

+(NSMutableString *)hiddenPhone:(NSString *)phone;

#pragma mark - 截取图片中间部分
+(void)jieQuZhongJianTuPianToImageView:(UIImageView *)imageView url:(NSURL *)url placeholderImage:(UIImage *)placeholderImage;

#pragma mark - 字体大小
/**
 *  @author LingFeng, 2016-06-08 11:06:54
 *
 *  设置输入框字体大小
 *
 *  @return 字体大小
 */
+(UIFont *)getTextFieldFontSize;
/**
 *  @author LingFeng, 2016-06-13 09:06:57
 *
 *  文本字体大小
 *
 *  @return 文本字体大小
 */
+(UIFont *)getTextFontSize;
/**
 *  @author LingFeng, 2016-06-13 09:06:39
 *
 *  大 文本字体大小
 *
 *  @return 大 文本字体大小
 */
+(UIFont *)getTextBigFontSize;
#pragma mark - 判断
/**
 *  @author LingFeng, 2016-06-08 11:06:08
 *
 *  判断学历
 *
 *  @param type 类型
 *
 *  @return 学历
 */
+(NSString *)getEduCational:(NSString *)type;
#pragma mark - 创建日期
+(NSString *)time:(NSString *)formatter;
/**
 *  @author LingFeng, 2016-06-12 10:06:05
 *
 *  获取时间间隔
 *
 *  @param date 创建的时间 格式：yyyy-MM-dd HH:mm
 *
 *  @return 时间间隔
 */
+(NSString *)getTimeIntervalIsCreateTime:(NSString *)date;

#pragma mark - 检查上一次更新时间
/**
 * @author LingFeng, 2016-09-09 09:09:47
 *
 * 检查上一次更新时间
 * @return 如果本地没有'值'返回->2 有->返回天数
 */
+(NSInteger)checkLastTimeUpApp;
/**
 *  @author LingFeng, 2016-06-08 11:06:30
 *
 *  判断公司类型
 *
 *  @param type 类型
 *
 *  @return 公司类型
 */
+(NSString *)getCompanyType:(NSString *)type;

/**
 *  @author LingFeng, 2016-06-08 11:06:21
 *
 *  判断邮箱
 *
 *  @param email 用户输入的邮箱
 *
 *  @return yes是邮箱 no不是邮箱
 */
+(BOOL)isValidateEmail:(NSString *)email;
/**
 *  @author LingFeng, 2016-06-08 11:06:32
 *
 *  判断电话号码
 *
 *  @param number 用户输入的电话号码
 *
 *  @return yes是电话号码 no不是电话号码
 */
+(BOOL)isValidateTelNumber:(NSString *)number;
/**
 *  @author LingFeng, 2016-06-08 11:06:08
 *
 *  判断电话号码
 *
 *  @param mobileNum 用户输入的电话号码
 *
 *  @return yes是电话号码 no不是电话号码
 */
+(BOOL)isMobileNumber:(NSString *)mobileNum;
/**
 *  @author LingFeng, 2016-06-08 11:06:22
 *
 *  判断密码是否符合
 *
 *  @param passWord 密码6-16 数字英文
 *
 *  @return yes符合 no不符合
 */
+ (BOOL)isValidatePassword:(NSString *)passWord;
/**
 * @author LingFeng, 2016-08-11 11:08:53
 *
 * 提示用户名
 * @param text 用户名
 * @return 提示用户名
 */
+(NSString *)isUserTiShi:(NSString *)text;
/**
 * @author LingFeng, 2016-08-11 11:08:22
 *
 * 提示密码
 * @param text 密码
 * @return 提示密码
 */
+(NSString *)isUserPasswordTiShi:(NSString *)text;
/**
 * @author LingFeng, 2016-08-11 11:08:26
 *
 * 提示 2次密码比对
 * @param lastText 第2个密码
 * @param firstText 第一个密码
 * @return 提示 2次密码比对
 */
+(NSString *)isUserPasswordAgainTiShiLast:(NSString *)lastText first:(NSString *)firstText;
@end


