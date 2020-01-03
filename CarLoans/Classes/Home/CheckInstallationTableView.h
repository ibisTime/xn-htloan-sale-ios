//
//  CheckInstallationTableView.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/6.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "GPSInstallationModel.h"
#import "SurveyPeopleTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface CheckInstallationTableView : TLTableView<UITableViewDataSource,UITableViewDelegate,SurveyPeopleDelegate>
@property (nonatomic , strong)GPSInstallationModel *model;

@property (nonatomic , strong)NSArray *peopleAray;
@end

NS_ASSUME_NONNULL_END
