//
//  AdmissionDetailsTableView19.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/6/17.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AdmissionDetailsTableView19.h"
#import "TongDunCell.h"
@interface AdmissionDetailsTableView19()<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *_isExpandArray;//记录section是否展开
}
@end

@implementation AdmissionDetailsTableView19

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        _isExpandArray = [[NSMutableArray alloc]init];
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.risk_items.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *rid=@"cell";
    TongDunCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    if(cell==nil){
        cell=[[TongDunCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
    }
    cell.type = @"details";
    cell.title = [NSString stringWithFormat:@"规则名称:%@\n规则得分:%@",self.risk_items[indexPath.row][@"risk_name"],self.risk_items[indexPath.row][@"score"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
//
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    for (int i = 0; i < self.risk_items.count; i++) {
//        [_isExpandArray addObject:@"0"];//0:没展开 1:展开
//    }
//    return self.risk_items.count;
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if ([_isExpandArray[section] isEqualToString:@"1"]) {
//        NSDictionary * dic = self.risk_items[section];
//        return dic.count - 1;
//    }else{
//        return 0;
//    }
//}
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *rid=@"cell";
//    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
//    if(cell==nil){
//        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
//    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    return cell;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
//    UILabel *Label = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, SCREEN_WIDTH - 107 - 40 - 15, 60)];
//    Label.numberOfLines = 0;
//    [Label setFont:Font(14)];
//    Label.text = [NSString stringWithFormat:@"规则名称:%@\n规则得分:%@",self.risk_items[section][@"risk_name"],self.risk_items[section][@"score"]];
//    [headerView addSubview:Label];
//
//
//    UIImageView *selectImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 5, 18, 18)];
//    [headerView addSubview:selectImageView];
//    if ([_isExpandArray[section] isEqualToString:@"0"]) {
//        //未展开
//        selectImageView.image = [UIImage imageNamed:@"caret"];
//    }else{
//        //展开
//        selectImageView.image = [UIImage imageNamed:@"caret_open"];
//    }
//
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
//    tap.delegate = self;
//    [headerView addGestureRecognizer:tap];
//    headerView.tag = section;
//    return headerView;
//}
//
//
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 10;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 60;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 30;
//}
//
//- (void)tapAction:(UITapGestureRecognizer *)tap{
//    if ([_isExpandArray[tap.view.tag] isEqualToString:@"0"]) {
//        //关闭 => 展开
//        [_isExpandArray replaceObjectAtIndex:tap.view.tag withObject:@"1"];
//    }else{
//        //展开 => 关闭
//        [_isExpandArray replaceObjectAtIndex:tap.view.tag withObject:@"0"];
//
//    }
//    NSIndexSet *set = [NSIndexSet indexSetWithIndex:tap.view.tag];
//    [self reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
//
//}
@end
