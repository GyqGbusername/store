//
//  NewUserInfoVC.m
//  MFSC
//
//  Created by mfwl on 16/3/4.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "NewUserInfoVC.h"
#import "AddressModel.h"

@interface NewUserInfoVC ()<UIPickerViewDataSource, UIPickerViewDelegate> {
    NSString *name;
    NSString *address;
    NSString *teleNum;
    NSString *zipCode;
    NSString *defaultState;
}

@property (nonatomic, assign) BOOL isCheck;
@property (strong, nonatomic) UIView *maskView;

@property (strong, nonatomic) IBOutlet UIPickerView *myPicker;
@property (strong, nonatomic) IBOutlet UIView *pickerBgView;

@property (strong, nonatomic) IBOutlet UIButton *provinceBtn;
@property (strong, nonatomic) IBOutlet UIButton *cityBtn;
@property (strong, nonatomic) IBOutlet UIButton *townBtn;
@property (strong, nonatomic) IBOutlet UIButton *checkButton;
/* info */

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *teleTextField;
@property (strong, nonatomic) IBOutlet UITextField *addressTextField;
@property (strong, nonatomic) IBOutlet UITextField *zipCodeTF;

/* data */
@property (strong, nonatomic) NSDictionary *pickerDic;
@property (strong, nonatomic) NSArray *provinceArray;
@property (strong, nonatomic) NSArray *cityArray;
@property (strong, nonatomic) NSArray *townArray;
@property (strong, nonatomic) NSArray *selectedArray;


@property (nonatomic, strong) NSMutableArray *temArr;


@end

@implementation NewUserInfoVC

- (void)dealloc {
    
    _myPicker.dataSource = nil;
    _myPicker.delegate = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
       
        self.isCheck = NO;
        [self.checkButton setImage:[UIImage imageNamed:@"kuang"] forState:(UIControlStateNormal)];
        self.myPicker.dataSource = self;
        self.myPicker.delegate = self;
    }
    return self;
}
- (IBAction)choose:(UIButton *)sender {
    self.isCheck = !self.isCheck;
    if (self.isCheck) {
        [self.checkButton setImage:[UIImage imageNamed:@"gouxuan"] forState:(UIControlStateNormal)];
    } else
        [self.checkButton setImage:[UIImage imageNamed:@"kuang"] forState:(UIControlStateNormal)];
}

- (void)setTF {
    [self.teleTextField addTarget:self action:@selector(TFChange:) forControlEvents:(UIControlEventEditingChanged)];
    [self.zipCodeTF addTarget:self action:@selector(TFChange:) forControlEvents:(UIControlEventEditingChanged)];
    [self.nameTextField addTarget:self action:@selector(TFChange:) forControlEvents:(UIControlEventEditingChanged)];
    [self.addressTextField addTarget:self action:@selector(TFChange:) forControlEvents:(UIControlEventEditingChanged)];
}
- (void)TFChange:(UITextField *)textField {
    switch (textField.tag) {
        case 101:
            name = textField.text;
            break;
        case 102:
            teleNum = textField.text;
            break;
        case 103:
            address = textField.text;
            break;
        case 104:
            zipCode = textField.text;
            break;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self getPickerData];
    [self initView];
    [self setTF];
}

#pragma mark - init view
- (void)initView {
    
    self.maskView = [[UIView alloc] initWithFrame:kScreen_Frame];
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 0;
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMyPicker)]];
   
    self.pickerBgView.width = kScreen_Width;
}

#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinceArray.count;
    } else if (component == 1) {
        return self.cityArray.count;
    } else {
        return self.townArray.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    AddressModel *model = nil;
    if (component == 0) {
        model = self.provinceArray[row];
        return model.region_name;
    } else if (component == 1) {
        model = self.cityArray[row];
        return model.region_name;
        
    } else {
        model = self.townArray[row];
        return model.region_name;
    }
}



- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 0) {
        return 110;
    } else if (component == 1) {
        return 100;
    } else {
        return 110;
    }
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    if (component == 0) {
        AddressModel *model = self.provinceArray[row];
        self.temArr = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in model.city) {
            AddressModel *cityModel = [AddressModel modelWithDictionary:dic];
            [self.temArr addObject:cityModel];
        }
        self.selectedArray = self.temArr;
        if (self.selectedArray.count > 0) {
            self.cityArray = self.temArr;
        } else {
            self.cityArray = nil;
        }
        self.temArr = [NSMutableArray arrayWithCapacity:0];
        if (self.cityArray.count > 0) {
            AddressModel *modelTown = self.cityArray[0];
            for (NSDictionary *dic in modelTown.area) {
                AddressModel *townModel = [AddressModel modelWithDictionary:dic];
                [_temArr addObject:townModel];
            }
            self.townArray = _temArr;
        } else {
            self.townArray = nil;
        }
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }
    [pickerView reloadComponent:1];
    if (component == 1) {
        if (self.selectedArray.count > 0 && self.cityArray.count > 0) {
            AddressModel *modelTown = self.cityArray[row];
            self.temArr = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *dic in modelTown.area) {
                AddressModel *townModel = [AddressModel modelWithDictionary:dic];
                [_temArr addObject:townModel];
            }
            self.townArray = _temArr;

        } else {
            self.townArray = nil;
        }
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }
    
    [pickerView reloadComponent:2];
}

- (void)hideMyPicker {
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0;
        self.pickerBgView.top = self.view.height;
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
        [self.pickerBgView removeFromSuperview];
    }];
}

#pragma mark - xib click

- (IBAction)cancel:(id)sender {
    [self hideMyPicker];
}

- (IBAction)ensure:(id)sender {
    self.provinceBtn.hidden = self.cityBtn.hidden = self.townBtn.hidden = NO;
   
    
    AddressModel *temp = [self.provinceArray objectAtIndex:[self.myPicker selectedRowInComponent:0]];
    [self.provinceBtn setTitle:temp.region_name forState:UIControlStateNormal];
    temp = [self.cityArray objectAtIndex:[self.myPicker selectedRowInComponent:1]];
    [self.cityBtn setTitle:temp.region_name forState:UIControlStateNormal];
    temp = [self.townArray objectAtIndex:[self.myPicker selectedRowInComponent:2]];
    [self.townBtn setTitle:temp.region_name forState:UIControlStateNormal];
    [self hideMyPicker];
}




#pragma mark - get data

//- (void)getPickerData {
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
//    self.pickerDic = [[NSDictionary alloc] initWithContentsOfFile:path];
//    self.provinceArray = [self.pickerDic allKeys];
//    self.selectedArray = [self.pickerDic objectForKey:[[self.pickerDic allKeys] objectAtIndex:0]];
//    
//    if (self.selectedArray.count > 0) {
//        self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
//    }
//    if (self.cityArray.count > 0) {
//        self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
//    }
//}


- (void)getPickerData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"addres" ofType:@"plist"];
    self.pickerDic = [[NSDictionary alloc] initWithContentsOfFile:path];
    /* 省 */
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dic in self.pickerDic[@"province"]) {
        AddressModel *model = [AddressModel modelWithDictionary:dic];
        [tempArr addObject:model];
    }
    self.provinceArray = tempArr;

    /* 选择 */
    AddressModel *model = self.provinceArray[0];
    tempArr = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dic in model.city) {
        AddressModel *cityModel = [AddressModel modelWithDictionary:dic];
        [tempArr addObject:cityModel];
    }
    self.selectedArray = tempArr;
    self.cityArray = tempArr;
    
    if (self.cityArray.count > 0) {
        AddressModel *modelTown = self.cityArray[0];
        tempArr = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in modelTown.area) {
            AddressModel *townModel = [AddressModel modelWithDictionary:dic];
            [tempArr addObject:townModel];
        }
        self.townArray = tempArr;
    }

}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



- (IBAction)showMyPicker:(UIButton *)sender {
  
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.pickerBgView];
    
   
    self.maskView.alpha = 0;
    self.pickerBgView.top = self.view.height;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0.3;
        self.pickerBgView.bottom = self.view.height;
    }];

}

- (IBAction)saveDataandBack:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
#warning 保存收货人信息
    [self saveInfo];
    
}

- (void)saveInfo {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    [dic setObject:name forKey:@"name"];
    [dic setObject:teleNum forKey:@"teleNum"];
    [dic setObject:zipCode forKey:@"zipCode"];
    NSString *str = [NSString stringWithFormat:@"%@, %@, %@", self.provinceBtn.titleLabel.text, self.cityBtn.titleLabel.text, self.townBtn.titleLabel.text];
    address = [NSString stringWithFormat:@"%@,%@", str, address];
    [dic setObject:address forKey:@"address"];
    defaultState = [NSString stringWithFormat:@"%d", self.isCheck];
    [dic setObject:defaultState forKey:@"state"];
  
    [HTTPTOOL POSTWithURL:@"http://192.168.0.112/sl/index.php?app=basic&act=getPersion" withBody:dic withBodyStyle:JSONStyle withHttpHead:nil responseStyle:JSON withSuccess:^(id result) {
       
    } withFail:^(NSError *error) {
      
    }];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
