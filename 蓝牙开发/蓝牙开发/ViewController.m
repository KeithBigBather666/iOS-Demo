//
//  ViewController.m
//  03-蓝牙开发
//
//  Created by HM09 on 2017/4/26.
//  Copyright © 2017年 itheima. All rights reserved.
//

#import "ViewController.h"

#import "HMBlueToothManager.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSArray <CBPeripheral *>*tableArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)scanButtonClick:(id)sender {
    
    [kHMBlueToothManager beginScanCBPeripheral:^(NSArray *peripheralArr) {
        self.tableArr = peripheralArr;
        [self.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    CBPeripheral *peripheral = self.tableArr[indexPath.row];
    
    cell.textLabel.text = peripheral.name ;
    cell.detailTextLabel.text = [peripheral.identifier UUIDString];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CBPeripheral *peripheral = self.tableArr[indexPath.row];
    
    [kHMBlueToothManager connectPeripheral:peripheral Completion:^(NSError *error) {
        if (error == nil) {
            NSLog(@"连接成功");
        }else{
            NSLog(@"连接失败");
        }
    }];
}


@end
