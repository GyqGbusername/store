//
//  AddressVC.m
//  MFSC
//
//  Created by mfwl on 16/3/4.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "AddressVC.h"
#import "NewUserInfoVC.h"


@interface AddressVC ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *list;
@property (strong, nonatomic) IBOutlet UITableView *addressTV;
@property (strong, nonatomic) IBOutlet UIButton *addNewAddress;

@end

@implementation AddressVC

- (void)dealloc {
    _addressTV.dataSource = nil;
    _addressTV.delegate = nil;
}
- (IBAction)pushAddressPage:(UIButton *)sender {
    NewUserInfoVC *newVC = [[NewUserInfoVC alloc] init];;
    [self.navigationController pushViewController:newVC animated:YES];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.list = [NSMutableArray arrayWithCapacity:0];
        self.addressTV.delegate = self;
        self.addressTV.dataSource = self;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.list.count == 0) {
        return 1;
    } return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.list.count) {
        case 0: {
            static NSString *cellIdentify = @"cellIdentify";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SoyTCell" owner:self options:nil];
            if ([nib count] > 0) {
                self.soyCell = [nib objectAtIndex:0];
                cell = self.soyCell;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
            
        default: {
            static NSString *simpleIdentify = @"SimpleIdentify";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleIdentify];
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomTableViewCell" owner:self options:nil];
            if ([nib count] > 0)
            {
                self.customCell = [nib objectAtIndex:0];
                cell = self.customCell;
            }
            return cell;
        }
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    // Do any additional setup after loading the view from its nib.
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.list.count) {
        case 0:{
            self.addressTV.scrollEnabled = NO;
        }
            return 300;
            break;
            
        default: {
            self.addressTV.scrollEnabled = YES;
        }
            return 113;
            break;
    }
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
