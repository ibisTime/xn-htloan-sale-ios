//
//  UpdateBrandTableView.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/6/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "UpdateBrandTableView.h"

@implementation UpdateBrandTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *rid=@"cell";
    CollectionViewCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    if(cell==nil){
        cell=[[CollectionViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
    }
    cell.delegate = self;
    cell.collectDataArray = self.brandlogo;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    UIButton * button = [UIButton buttonWithTitle:@"上传" titleColor:kWhiteColor backgroundColor:MainColor titleFont:14 cornerRadius:3];
    button.frame = CGRectMake(10, 5, SCREEN_WIDTH - 20, 50);
    [button addTarget:self action:@selector(buttonclick:) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:button];
    return view;
}
-(void)buttonclick:(UIButton *)sender{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:105 selectRowState:@"confirm"];
        
    }
}

-(void)CustomCollection:(UICollectionView *)collectionView didSelectRowAtIndexPath:(NSIndexPath *)indexPath str:(NSString *)str
{
    
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
            [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:105 selectRowState:@"add"];
            
        }
    
}
@end
