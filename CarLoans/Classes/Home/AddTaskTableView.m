//
//  AddTaskTableView.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/6.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "AddTaskTableView.h"
#import "InputBoxCell.h"
#define InputBox @"InputBoxCell"
@implementation AddTaskTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[InputBoxCell class] forCellReuseIdentifier:InputBox];
        
    }
    return self;
}
-(NSInteger)numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InputBoxCell * cell = [tableView dequeueReusableCellWithIdentifier:InputBox forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray * array = @[@"任务名称",@"任务时效"];
    cell.name = array[indexPath.row];
    cell.tag = 1000 + indexPath.row;
    cell.symbolLabel.hidden = YES;
    if (self.dataDic.count > 0) {
        
        NSArray *Array = @[_dataDic[@"name"],_dataDic[@"time"]];
        cell.nameTextField.text = Array[indexPath.row];
    }
    if (indexPath.row == 1) {
        cell.nameTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
@end
