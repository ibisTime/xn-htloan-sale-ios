#import "ProtectUsTableView.h"
#import "InformationCell.h"
#define Information @"InformationCell"
@interface ProtectUsTableView ()<UITableViewDataSource,UITableViewDelegate>
@end
@implementation ProtectUsTableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[InformationCell class] forCellReuseIdentifier:Information];
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
    return self.model.count;
}
#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InformationCell *cell = [tableView dequeueReusableCellWithIdentifier:Information forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.model.count > 0) {
        cell.surveyModel = self.model[indexPath.row];
    }
    cell.button.tag = indexPath.row;
    SurveyModel * model = self.model[indexPath.row];
    
    if ([model.fbhgpsNode isEqualToString:@"c1"]){
        [cell.button setTitle:@"录入发报合" forState:(UIControlStateNormal)];
        cell.button.hidden = NO;
    }
    else if ([model.fbhgpsNode isEqualToString:@"c2"]) {
        [cell.button setTitle:@"审核发报合" forState:(UIControlStateNormal)];
        cell.button.hidden = NO;
    }
    else if ([model.fbhgpsNode isEqualToString:@"c1x"]){
        [cell.button setTitle:@"重录发报合" forState:(UIControlStateNormal)];
        cell.button.hidden = NO;
    }

    [cell.button addTarget:self action:@selector(buttonClick1:) forControlEvents:(UIControlEventTouchUpInside)];
    
    return cell;
}
-(void)buttonClick1:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"select1"];
    }
}
//-(void)buttonClick2:(UIButton *)sender
//{
//    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
//        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"select2"];
//    }
//}
//-(void)buttonClick3:(UIButton *)sender
//{
//    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
//        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"select3"];
//    }
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:didSelectRowAtIndexPath:)]) {
        [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
    }
}
#pragma mark -- 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return 280;
    return 330;
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
@end
