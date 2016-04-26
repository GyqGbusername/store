//
//  UserViewController.m
//  MFSC
//
//  Created by mfwl on 16/2/16.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "UserViewController.h"
#import "UserLoginTCell.h"
#import "LoginVC.h"
#import "OrderVC.h"
#import "AllOrderTCell.h"
#import "OrderStateTVCell.h"
#import "SmallGroupTCell.h"
#import "MyAccountVC.h"
#import "OpenShopVC.h"
#import "FeedbackVC.h"
#import "AttentionStoreVC.h"
#import "ImageChooseTool.h"



@interface UserViewController () <OrderStateTVCellDelegate,UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    NSInteger token;
    id __block imageOpen;
    id __block UserButtonView;
}

@property (nonatomic, strong) UITableView *userTableView;

@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, strong) PHPhotoLibrary *photoLibrary;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;

@property (nonatomic, strong) UIImage *tempImage;
@property (nonatomic, strong) NSData *tempImageData;


/* titleV */
@property (nonatomic, strong) UIView *titleBV;
@property (nonatomic, strong) UILabel *nameLB;
@property (nonatomic, strong) UIButton *messageBT;


@end

@implementation UserViewController



- (void)dealloc {
    _userTableView.delegate = nil;
    _userTableView.dataSource = nil;
    _imagePickerController.delegate = nil;
    [mFNotiCenter removeObserver:UserButtonView];
    [mFNotiCenter removeObserver:imageOpen];
    
}

- (id)readNSUserDefaultsLogin {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults stringForKey:@"token"]; /* 读取 */
}

#pragma mark 初始化事件
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.dataArr = @[@{@"title":@"商品关注", @"color":[UIColor blueColor], @"mixTitle":@"免费抢 [youtiaoh]", @"image":@"fuli"}, @{@"title":@"店铺关注", @"color":[UIColor cyanColor], @"mixTitle":@"0 [youtiaoh]",@"image":@"diyong"}, @{@"title":@"浏览记录", @"color":[UIColor greenColor], @"mixTitle":@"好礼已上线 [youtiaoh]", @"image":@"jifen"}, @{@"title":@"每日推荐", @"color":[UIColor grayColor], @"mixTitle":@"今日推荐 [youtiaoh]", @"image":@"tuijian"}, @{@"title":@"服务/反馈", @"color":[UIColor yellowColor], @"mixTitle":@"我是商家 [youtiaoh]", @"image":@"hezuo"}, @{@"title":@"我要合作", @"color":[UIColor purpleColor], @"mixTitle":@"提意见 [youtiaoh]", @"image":@"mianfei"}];
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated {
    token = [[self readNSUserDefaultsLogin] integerValue];
    [self.userTableView reloadData];
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBarHidden = YES;
}

- (void)setTitle {
    _titleBV = [[UIView alloc] init];
    [self.view addSubview:_titleBV];
   
    _nameLB = [[UILabel alloc] init];
    _messageBT = [UIButton buttonWithType:UIButtonTypeSystem];
    [_messageBT setTintColor:[UIColor whiteColor]];
    [self.titleBV addSubview:_nameLB];
    [_messageBT setImage:[UIImage imageNamed:@"lingdang"] forState:(UIControlStateNormal)];
    [_messageBT addTarget:self action:@selector(messageBTClick:) forControlEvents:(UIControlEventTouchUpInside)];
    _nameLB.text = @"我的";
    _nameLB.textAlignment = 0;
    _nameLB.textColor = [UIColor whiteColor];
    _nameLB.font = [UIFont systemFontOfSize:17];
    [self.titleBV addSubview:_messageBT];
    _titleBV.backgroundColor = THEMECOLOR;
}
- (void)messageBTClick:(UIButton *)button {
    [self.navigationController pushViewController:[MessageVC shareMessageVC] animated:YES];
}
#pragma mark 添加约束
- (void)addMasnory {
    [_titleBV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.left.top.equalTo(self.view);
        make.height.equalTo(@64);
    }];
    [_nameLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleBV).offset(15);
        make.top.equalTo(self.titleBV).with.offset(32);
        make.height.equalTo(@21);
        make.width.equalTo(@68);
    }];
    [_messageBT mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titleBV).offset(-15);
        make.width.height.equalTo(@25);
        make.top.equalTo(self.titleBV).offset(30);
    }];
  
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.alpha = 1.0;
    [self setTitle];
    [self addMasnory];
    [self createUserTableView];
    [self notificationHandle];
}




- (void)createUserTableView {
    self.userTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreen_Width, kScreen_Height) style:(UITableViewStyleGrouped)];
    [self.view addSubview:self.userTableView];
    self.userTableView.bounces = NO;
    [self.userTableView mas_makeConstraints:^(MASConstraintMaker *make) {
   
        make.top.equalTo(self.titleBV.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom).offset(-49);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.centerX.equalTo(self.view);

    }];
    self.userTableView.delegate = self;
    self.userTableView.dataSource = self;
    self.userTableView.showsHorizontalScrollIndicator = NO;
    self.userTableView.showsVerticalScrollIndicator = NO;
    [self.userTableView  registerClass:[UserLoginTCell class] forCellReuseIdentifier:@"UserViewController_UserLoginTCell"];

    [self.userTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UserViewController_UITableViewCell"];
    [self.userTableView registerClass:[SmallGroupTCell class] forCellReuseIdentifier:@"UserViewController_SmallGroupTCell"];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 9;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    switch (indexPath.section) {
        case 0: {
            
            UserLoginTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserViewController_UserLoginTCell"];
            cell.token = token;
            if (_tempImage && token == 1) {
                cell.userImage.image = _tempImage;
                cell.userImage.layer.cornerRadius = 25;
                cell.userImage.layer.masksToBounds = YES;
            } else {
                cell.userImage.layer.cornerRadius = 25;
                cell.userImage.layer.masksToBounds = YES;
                cell.userImage.image = [UIImage imageNamed:@"houzi"];
            }
            cell.backgroundColor = THEMECOLOR;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 1: {
            static NSString *cellName = @"UserViewController_AllOrderTCell";
            AllOrderTCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
            if (!cell) {
                cell = [[AllOrderTCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:cellName
                ];
            }
            
            return cell;
        }
            break;
        case 2: {
            static NSString *tempCell = @"OrderStateTVCell";
            OrderStateTVCell *cell = [tableView dequeueReusableCellWithIdentifier:tempCell];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"OrderStateTVCell" owner:nil options:nil] firstObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            return cell;
        }
            break;
            
        default: {
            SmallGroupTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserViewController_SmallGroupTCell"];
            cell.serviceDic = self.dataArr[indexPath.section - 3];
            return cell;
        }
            
            break;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 2:
            return NO;
            break;
            
        default:
            return YES;
            break;
    }
}

- (void)jumpWith:(NSInteger)tag {
    OrderVC *orderVC = [[OrderVC alloc] init];
    orderVC.tempStartPoint = tag;
    [self.navigationController pushViewController:orderVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 130;
            break;
        case 1:
            return 40;
            break;
            case 2:
            return 90;
            break;
        default:
            return 40;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1|| section == 3 || section == 5 || section == 8) {
        return CGFLOAT_MIN;
    }
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            
            switch (token) {
                case 0: {
                    LoginVC *loginVC = [[LoginVC alloc] init];
                    [self.navigationController pushViewController:loginVC animated:YES];
                }
                    break;
                    
                case 1: {
                    MyAccountVC *accountVC = [[MyAccountVC alloc] init];
                    [self.navigationController pushViewController:accountVC animated:YES];
                }
                    break;
                    
            }
            
           
        }
            break;
        case 1: {
            OrderVC *orderVC = [[OrderVC alloc] init];
            orderVC.tempStartPoint = 0;
            [self.navigationController pushViewController:orderVC animated:YES];
            
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
            break;
            
        case 3: {
            AttentionStoreVC *attent = [[AttentionStoreVC alloc] init];
            attent.segment.selectedSegmentIndex = 0;
            [self.navigationController pushViewController:attent animated:YES];
        }
            break;
        case 4: {
            AttentionStoreVC *attent = [[AttentionStoreVC alloc] init];
            attent.segment.selectedSegmentIndex = 1;
            [self.navigationController pushViewController:attent animated:YES];
        }
            break;
        case 7: {
            FeedbackVC *feedBack = [[FeedbackVC alloc] init];
            [self.navigationController pushViewController:feedBack animated:YES];
        }
            break;
        case 8: {
            OpenShopVC *openShop = [[OpenShopVC alloc] init];
            [self.navigationController pushViewController:openShop animated:YES];
        }
            break;
        
        default:
            
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#warning button 跳转

- (void)notificationHandle {
    
    UserButtonView = [mFNotiCenter addObserverForName:@"UserButtonView" object:@"button" queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        NSLog(@"%@", [note .userInfo objectForKey:@"push"]);
    }];
    imageOpen = [mFNotiCenter addObserverForName:@"imageOpen" object:@"image" queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
              [self setImagePickerController];
        //[[[UIApplication sharedApplication].delegate window] addSubview:self.headportraitView];
        NSLog(@"%@", [note .userInfo objectForKey:@"1"]);
    }];
}

- (void)setImagePickerController {
    //创建UIAlertController是为了让用户去选择照片来源,拍照或者相册.
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:1];
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"从相册选取" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action)
                                   {
                                       //这里可以不写代码
                                   }];
    [self presentViewController:alertController animated:YES completion:nil];
    
    //用来判断来源 Xcode中的模拟器是没有拍摄功能的,当用模拟器的时候我们不需要把拍照功能加速
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        
    {
        [alertController addAction:okAction];
        [alertController addAction:cancelAction];
        [alertController addAction:photoAction];
    }
    else
    {
        [alertController addAction:okAction];
        [alertController addAction:cancelAction];
    }
}


//这个是选取完照片后要执行的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    //选取裁剪后的图片
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    /* 此处info 有六个值
     * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
     * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
     * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
     * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
     * UIImagePickerControllerMediaURL;       // an NSURL
     * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
     * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
     */
    
    _tempImage = image;

    [self.userTableView reloadData];
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
