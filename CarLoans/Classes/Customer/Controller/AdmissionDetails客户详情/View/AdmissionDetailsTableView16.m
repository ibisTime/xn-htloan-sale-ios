//
//  AdmissionDetailsTableView16.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/23.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AdmissionDetailsTableView16.h"
#import "AttachmentPoolCell.h"
@interface AdmissionDetailsTableView16 ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation AdmissionDetailsTableView16
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[AttachmentPoolCell class] forCellReuseIdentifier:@"AttachmentPoolCell"];
    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.model.attachments.count;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     //AttachmentPoolCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AttachmentPoolCell" forIndexPath:indexPath];
    static NSString *rid=@"AttachmentPoolCell";
    AttachmentPoolCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    if(cell==nil){
        cell=[[AttachmentPoolCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
    }
    NSString * str1 = self.model.attachments[indexPath.row][@"code"];
    NSString * str2 = self.model.attachments[indexPath.row][@"vname"];
    NSString * str3 = self.model.attachments[indexPath.row][@"attachType"];
    NSArray * arr = [self.model.attachments[indexPath.row][@"url"] componentsSeparatedByString:@"||"];
    
    
    cell.array = @[[NSString stringWithFormat:@"编号：%@",str1],[NSString stringWithFormat:@"附件类型：%@",str2],[BaseModel convertNull: [NSString stringWithFormat: @"资源类型：%@",str3]],[NSString stringWithFormat:@"资源数量：%ld张",arr.count]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
////    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:didSelectRowAtIndexPath:)]) {
////        [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
////    }
//}

#pragma mark -- 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 162.5;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.01;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSMutableArray *muArray = [NSMutableArray array];
    NSArray * arr = [self.model.attachments[indexPath.row][@"url"] componentsSeparatedByString:@"||"];
    for (int i = 0; i < arr.count; i++) {
        [muArray addObject:[arr[i] convertImageUrl]];
    }
    NSArray *seleteArray = muArray;
    
    if (muArray.count > 0) {
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        [ImageBrowserViewController show:window.rootViewController type:PhotoBroswerVCTypeModal index:0 imagesBlock:^NSArray *{
            return seleteArray;
        }];
        
    }
    
}

@end
