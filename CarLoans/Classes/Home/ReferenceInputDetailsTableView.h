//
//  ReferenceInputDetailsTableView.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/19.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "TextFieldCell.h"
NS_ASSUME_NONNULL_BEGIN
@protocol SelectButtonDelegate <NSObject>

-(void)selectButtonClick:(UIButton *)sender;

@end
@interface ReferenceInputDetailsTableView : TLTableView
@property (nonatomic, assign) id <SelectButtonDelegate> ButtonDelegate;
@property (nonatomic , strong)NSArray *bankCreditReport;
@property (nonatomic , strong)NSArray *dataCreditReport;
@property (nonatomic , strong)NSDictionary *dataDic;
@property (nonatomic , copy)NSString *bankResult;
@property (nonatomic , copy)NSString *creditNote;
@property (nonatomic , copy)NSString *creditCardOccupation;

@property (nonatomic , strong)TextFieldCell *cell;
@property (nonatomic , copy)NSString *secondCarReport;
@end

NS_ASSUME_NONNULL_END
