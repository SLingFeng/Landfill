//
//  MyCityPicker.m
//  test
//
//  Created by mac on 16/7/19.
//  Copyright © 2016年 LingFeng. All rights reserved.
//

#import "MyCityPicker.h"
#import <Masonry/Masonry.h>



@interface MyCityPicker ()<UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSArray * _city;
    NSArray * _province;
}
@property (retain, nonatomic) UIPickerView * pickerView;
@property (nonatomic, strong) UIButton *btnCancel;
@property (nonatomic, strong) UIButton *btnConfirm;
@end

@implementation MyCityPicker

-(instancetype)initWithComponentRowZero:(NSArray<NSString *> *)componentZero ComponentRowOne:(NSArray<NSArray<NSString *>*> *)componentOne Type:(MyCityPickerType)Type {
    if (self = [super init]) {
        self.pickerType = Type;
        if (Type == PickerTypeSingle) {
            self.componentZero = componentZero;
        }else if (_pickerType == PickerTypeTwoGroups) {
            self.componentZero = componentZero;
            self.componentOne = componentOne;
        }
        
    }
    return self;
}

-(instancetype)init {
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}


-(void)setupView {
    self.type = MMPopupTypeSheet;
    self.backgroundColor = [UIColor whiteColor];
    self.userInteractionEnabled = YES;
    [MMPopupWindow sharedWindow].touchWildToHide = YES;
    
    if (_pickerType == PickerTypeCity) {
        _city = [NSArray arrayWithObjects:
                 @[@"北京"],
                 @[@"天津"],
                 @[@"上海"],
                 @[@"重庆"],
                 @[@"福州市", @"厦门市", @"莆田市", @"三明市", @"泉州市", @"漳州市", @"南平市", @"龙岩市", @"宁德市"],
                 @[@"石家庄市", @"唐山市", @"秦皇岛市", @"邯郸市", @"邢台市", @"保定市", @"张家口市", @"承德市", @"沧州市", @"廊坊市", @"衡水市"],
                 @[@"太原市", @"大同市", @"阳泉市", @"长治市", @"晋城市", @"朔州市", @"晋中市", @"运城市", @"忻州市", @"临汾市", @"吕梁市"],
                 @[@"呼和浩特市", @"包头市", @"乌海市", @"赤峰市", @"通辽市", @"鄂尔两斯市", @"呼伦贝尔市", @"巴彦淖尔市", @"乌兰察布市", @"兴安盟", @"锡林郭勒盟", @"阿拉善盟"],
                 @[@"沈阳市", @"大连市", @"鞍山市", @"抚顺市", @"本溪市", @"丹东市", @"锦州市", @"营口市", @"阜新市", @"辽阳市", @"盘锦市", @"铁岭市", @"朝阳市", @"葫芦岛市"],
                 @[@"长春市", @"吉林市", @"四平市", @"辽源市", @"通化市", @"白山市", @"松原市", @"白城市", @"延边"],
                 @[@"哈尔滨市", @"齐齐哈尔市", @"鸡西市", @"鹤岗市", @"双鸭山市", @"大庆市", @"伊春市", @"佳木斯市", @"七台河市", @"牡丹江市", @"黑河市", @"绥化市", @"大兴安岭地区"],
                 @[@"南京市", @"无锡市", @"徐州市", @"常州市", @"苏州市", @"南通市", @"连云港市", @"淮安市", @"盐城市", @"扬州市", @"镇江市", @"泰州市", @"宿迁市"],
                 @[@"杭州市", @"宁波市", @"温州市", @"嘉兴市", @"湖州市", @"绍兴市", @"金华市", @"衢州市", @"舟山市", @"台州市", @"丽水市"],
                 @[@"合肥市", @"芜湖市", @"蚌埠市", @"淮南市", @"马鞍山市", @"淮北市", @"铜陵市", @"安庆市", @"黄山市", @"滁州市", @"阜阳市", @"宿州市", @"巢湖市", @"六安市", @"亳州市", @"池州市", @"宣城市"],
                 @[@"南昌市", @"景德镇市", @"萍乡市", @"九江市", @"新余市", @"鹰潭市", @"赣州市", @"吉安市", @"宜春市", @"抚州市", @"上饶市"],
                 @[@"济南市", @"青岛市", @"淄博市", @"枣庄市", @"东营市", @"烟台市", @"潍坊市", @"济宁市", @"泰安市", @"威海市", @"日照市", @"莱芜市", @"临沂市", @"德州市", @"聊城市", @"滨州市", @"菏泽市"],
                 @[@"郑州市", @"开封市", @"洛阳市", @"平顶山市", @"安阳市", @"鹤壁市", @"新乡市", @"焦作市", @"济源市", @"濮阳市", @"许昌市", @"漯河市", @"三门峡市", @"南阳市", @"商丘市", @"信阳市", @"周口市", @"驻马店市"],
                 @[@"武汉市", @"黄石市", @"十堰市", @"宜昌市", @"襄樊市", @"鄂州市", @"荆门市", @"孝感市", @"荆州市", @"黄冈市", @"咸宁市", @"随州市", @"恩施",],
                 @[@"长沙市", @"株洲市", @"湘潭市", @"衡阳市", @"邵阳市", @"岳阳市", @"常德市", @"张家界市", @"益阳市", @"郴州市", @"永州市", @"怀化市", @"娄底市", @"湘西"],
                 @[@"广州市", @"韶关市", @"深圳市", @"珠海市", @"汕头市", @"佛山市", @"江门市", @"湛江市", @"茂名市", @"肇庆市", @"惠州市", @"梅州市", @"汕尾市", @"河源市", @"阳江市", @"清远市", @"东莞市", @"中山市", @"潮州市", @"揭阳市", @"云浮市"],
                 @[@"南宁市", @"柳州市", @"桂林市", @"梧州市", @"北海市", @"防城港市", @"钦州市", @"贵港市", @"玉林市", @"百色市", @"贺州市", @"河池市", @"来宾市", @"崇左市"],
                 @[@"成都市", @"自贡市", @"攀枝花市", @"泸州市", @"德阳市", @"绵阳市", @"广元市", @"遂宁市", @"内江市", @"乐山市", @"南充市", @"眉山市", @"宜宾市", @"广安市", @"达州市", @"雅安市", @"巴中市", @"资阳市", @"阿坝", @"甘孜", @"凉山"],
                 @[@"贵阳市", @"六盘水市", @"遵义市", @"安顺市", @"铜仁地区", @"毕节", @"黔西南", @"黔东南", @"黔南"],
                 @[@"昆明市", @"曲靖市", @"玉溪市", @"保山市", @"昭通市", @"丽江市", @"思茅市", @"临沧市", @"楚雄", @"红河", @"文山", @"西双版纳", @"大理", @"德宏", @"迪庆"],
                 @[@"西安市", @"铜川市", @"宝鸡市", @"咸阳市", @"渭南市", @"延安市", @"汉中市", @"榆林市", @"安康市", @"商洛市"],
                 @[@"兰州市", @"嘉峪关市", @"金昌市", @"白银市", @"天水市", @"武威市", @"张掖市", @"平凉市", @"酒泉市", @"庆阳市", @"定西市", @"陇南市", @"临夏", @"甘南"],
                 @[@"西宁市", @"海东地区", @"海北", @"黄南", @"海南", @"果洛", @"玉树", @"海西"],
                 @[@"银川市", @"石嘴山市", @"吴忠市", @"固原市", @"中卫市"],
                 @[@"拉萨市", @"昌都地区", @"山南", @"日喀则", @"那曲", @"阿里", @"林芝"],
                 @[@"乌鲁木齐市", @"克拉玛依市", @"吐鲁番", @"哈密", @"昌吉", @"博尔塔拉", @"巴音郭楞", @"阿克苏", @"克孜勒苏", @"喀什", @"和田", @"伊犁", @"塔城", @"阿勒泰"],
                 @[@"海口市", @"三亚市", @"三沙市"],
                 @[@"台北市", @"高雄市", @"基隆市", @"台中市", @"台南市", @"新竹市", @"嘉义市"],
                 @[@"香港"],
                 @[@"澳门"],
                 nil];
        
        _province = @[@"北京", @"天津", @"上海", @"重庆", @"福建", @"河北", @"山西", @"内蒙古", @"辽宁", @"吉林", @"黑龙江", @"江苏", @"浙江", @"安徽", @"江西", @"山东", @"河南", @"湖北", @"湖南", @"广东", @"广西", @"四川", @"贵州", @"云南", @"陕西", @"甘肃", @"宁夏", @"青海", @"西藏", @"新疆", @"海南", @"台湾", @"香港", @"澳门"];

    }else if(_pickerType == PickerTypeSingle) {
        
    }else {
        
    }
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
        make.height.mas_equalTo(216+50);
    }];
    
    self.btnCancel = [UIButton mm_buttonWithTarget:self action:@selector(actionHide)];
    [self addSubview:self.btnCancel];
    [self.btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 50));
        make.left.top.equalTo(self);
    }];
    [self.btnCancel setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.btnCancel setTitleColor:MMHexColor(0xE76153FF) forState:UIControlStateNormal];
    
    
    self.btnConfirm = [UIButton mm_buttonWithTarget:self action:@selector(actionHide)];
    [self addSubview:self.btnConfirm];
    [self.btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 50));
        make.right.top.equalTo(self);
    }];
    [self.btnConfirm setTitle:@"Confirm" forState:UIControlStateNormal];
    [self.btnConfirm setTitleColor:MMHexColor(0xE76153FF) forState:UIControlStateNormal];
    
    self.pickerView = [[UIPickerView alloc] init];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [self addSubview:_pickerView];
    [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
}

-(void)actionHide {
    [self hide];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (_pickerType == PickerTypeCity) {
        return 2;
    }else if(_pickerType == PickerTypeSingle) {
        return 1;
    }else {
        return 2;
    }
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (_pickerType == PickerTypeCity) {
//        城市
        if (0 == component) {
            return _province.count;
        }else {
            NSInteger indexRow = [pickerView selectedRowInComponent:0];
            return [_city[indexRow] count];
        }
    }else if(_pickerType == PickerTypeSingle) {
//        单组
        return _componentZero.count;
    }else {
//        两组
        if (0 == component) {
            return _componentZero.count;
        }else {
            NSInteger indexRow = [pickerView selectedRowInComponent:0];
            return [_componentOne[indexRow] count];
        }
    }
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

    if (_pickerType == PickerTypeCity) {
        //        城市
        if (0 == component) {
            return _province[row];
        }else {
            NSInteger indexRow = [pickerView selectedRowInComponent:0];
            return _city[indexRow] [row];
        }
    }else if(_pickerType == PickerTypeSingle) {
        //        单组
        
        return _componentZero[row];
    }else {
        //        两组
        if (0 == component) {
            return _componentZero[row];
        }else {
            NSInteger indexRow = [pickerView selectedRowInComponent:0];
            return _componentOne[indexRow] [row];
        }
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSMutableArray * temp = [NSMutableArray arrayWithCapacity:2];
    if (_pickerType == PickerTypeCity) {
        //        城市
        if (0 == component) {
            [pickerView reloadComponent:1];
            [pickerView selectRow:0 inComponent:1 animated:YES];
        }
        
        NSInteger cpt = [pickerView selectedRowInComponent:0];
        NSString * province = _province[cpt];
        
        NSInteger two = [pickerView selectedRowInComponent:1];
        NSArray *array = _city[cpt];
        NSString *city = array[two];
        
        [temp addObject:province];
        [temp addObject:city];
        
        if (self.selectContent) {
            self.selectContent(temp);
        }
        
        NSLog(@"%@---%@", province, city);
    }else if(_pickerType == PickerTypeSingle) {
        //        单组
        NSLog(@"%@", _componentZero[row]);
        
        [temp addObject:_componentZero[row]];
        if (self.selectContent) {
            self.selectContent(temp);
        }
    }else {
        //        两组
        if (0 == component) {
            [pickerView reloadComponent:1];
            [pickerView selectRow:0 inComponent:1 animated:YES];
        }
        
        NSInteger cpt = [pickerView selectedRowInComponent:0];
        NSString * province = _componentZero[cpt];
        
        NSInteger two = [pickerView selectedRowInComponent:1];
        NSArray *array = _componentOne[cpt];
        NSString *city = array[two];
        
        NSLog(@"%@---%@", province, city);
        [temp addObject:province];
        [temp addObject:city];
        
        if (self.selectContent) {
            self.selectContent(temp);
        }
    }
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
