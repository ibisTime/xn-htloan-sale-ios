//
//  SurveyModel.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/20.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SurveyModel : NSObject

@property (nonatomic , assign)BOOL isChoose;

@property (nonatomic , copy)NSString *userId;
@property (nonatomic , copy)NSString *realName;
@property (nonatomic , copy)NSString *fullName;
@property (nonatomic , copy)NSString *pledgeNodeCode;
@property (nonatomic , copy)NSString *ascriptionName;
@property (nonatomic , copy)NSString *ascription;
@property (nonatomic , copy)NSString *creditNote;
@property (nonatomic , copy)NSString *secondCarReport;
@property (nonatomic , strong)NSDictionary *carInfoRes;
@property (nonatomic , copy)NSString *loanCode;
@property (nonatomic , copy)NSString *gpsDevNo;
@property (nonatomic , strong)NSDictionary *loanInfo;
@property (nonatomic , strong)NSDictionary *carInfo;
@property (nonatomic , copy)NSString *isGpsAz;
@property (nonatomic , copy)NSString *region;
@property (nonatomic , strong)NSDictionary *repayBiz;
@property (nonatomic , copy)NSString *isFinacing;
@property (nonatomic , copy)NSString *repointAmount;
@property (nonatomic , copy)NSString *name;
@property (nonatomic , copy)NSString *regDate;
@property (nonatomic , copy)NSString *mile;
@property (nonatomic , copy)NSString *enterLocationName;

@property (nonatomic , copy)NSString *carBrand;
@property (nonatomic , copy)NSString *carSeries;
@property (nonatomic , copy)NSString *carModel;
@property (nonatomic , copy)NSString *shopCarGarage;
@property (nonatomic , copy)NSString *saleUserId;
@property (nonatomic , copy)NSString *loanBank;
@property (nonatomic , copy)NSString *makeCardNode;
@property (nonatomic , copy)NSString *curNodeCode;
@property (nonatomic , copy)NSString *teamName;
@property (nonatomic , copy)NSString *opera;
@property (nonatomic , copy)NSString *code;
@property (nonatomic , copy)NSString *updateDatetime;
@property (nonatomic , copy)NSString *saleUserName;
@property (nonatomic , copy)NSString *saleUserCompanyName;
@property (nonatomic , copy)NSString *saleUserDepartMentName;
@property (nonatomic , copy)NSString *updaterName;
@property (nonatomic , copy)NSString *idNo;
@property (nonatomic , copy)NSString *operatorName;
@property (nonatomic , copy)NSString *loanAmount;
@property (nonatomic , copy)NSString *loanBankCode;
@property (nonatomic , copy)NSString *isCancel;
@property (nonatomic , copy)NSString *loanCardNumber;
@property (nonatomic , copy)NSString *rate;
@property (nonatomic , copy)NSString *applyDatetime;
@property (nonatomic , copy)NSString *mobile;
@property (nonatomic , copy)NSString *bizType;
@property (nonatomic , copy)NSString *bizTypeStr;
@property (nonatomic , copy)NSString *budgetCode;
@property (nonatomic , copy)NSString *note;

@property (nonatomic , copy)NSString *companyName;
@property (nonatomic,copy) NSString * insideJobCompanyName;
@property (nonatomic,copy) NSString * insideJobDepartMentName;
@property (nonatomic,copy) NSString * insideJobName;
@property (nonatomic , copy)NSString *insideJob;
@property (nonatomic , copy)NSString *userName;
@property (nonatomic , copy)NSString *teamCode;
@property (nonatomic , copy)NSString *companyCode;
@property (nonatomic , copy)NSString *loanBankName;
@property (nonatomic , strong)NSDictionary *creditUser;
@property (nonatomic , strong)NSArray *creditUserList;
//@property (nonatomic , assign)CGFloat loanAmount;
@property (nonatomic , copy)NSString *bankCode;

@property (nonatomic , copy)NSString *dkAmount;
@property (nonatomic , copy)NSString *status;
@property (nonatomic , copy)NSString *cancelStatus;
@property (nonatomic , copy)NSString *ywyUser;
//@property (nonatomic , strong) NSDictionary *creditUser;
@property (nonatomic , strong)NSDictionary *credit;
@property (nonatomic , strong)NSArray *attachments;
@property (nonatomic , strong)NSArray *bizTasks;
@property (nonatomic , strong)NSArray *bizLogs;

@property (nonatomic,strong) NSString * fbhgpsNode;

@property (nonatomic , copy)NSString *applyUserName;



@property (nonatomic , copy)NSString *intevCurNodeCode;


@property (nonatomic , copy)NSString *marryDivorce;
@property (nonatomic , strong)NSArray *marryDivorcePics;
@property (nonatomic , copy)NSString *applyUserHkb;
@property (nonatomic , strong)NSArray *applyUserHkbPics;
@property (nonatomic , copy)NSString *bankBillPdf;
@property (nonatomic , strong)NSArray *bankBillPdfPics;
@property (nonatomic , copy)NSString *singleProvePdf;
@property (nonatomic , strong)NSArray *singleProvePdfPics;
@property (nonatomic , copy)NSString *incomeProvePdf;
@property (nonatomic , strong)NSArray *incomeProvePdfPics;
@property (nonatomic , copy)NSString *liveProvePdf;
@property (nonatomic , strong)NSArray *liveProvePdfPics;
@property (nonatomic , copy)NSString *houseInvoice;
@property (nonatomic , strong)NSArray *houseInvoicePics;
@property (nonatomic , copy)NSString *buildProvePdf;
@property (nonatomic , strong)NSArray *buildProvePdfPics;
@property (nonatomic , copy)NSString *hkbFirstPage;
@property (nonatomic , strong)NSArray *hkbFirstPagePics;
@property (nonatomic , copy)NSString *hkbMainPage;
@property (nonatomic , strong)NSArray *hkbMainPagePics;
@property (nonatomic , copy)NSString *guarantor1IdNo;
@property (nonatomic , strong)NSArray *guarantor1IdNoPics;
@property (nonatomic , copy)NSString *guarantor1Hkb;
@property (nonatomic , strong)NSArray *guarantor1HkbPics;
@property (nonatomic , copy)NSString *guarantor2IdNo;
@property (nonatomic , strong)NSArray *guarantor2IdNoPics;
@property (nonatomic , copy)NSString *guarantor2Hkb;
@property (nonatomic , strong)NSArray *guarantor2HkbPics;
@property (nonatomic , copy)NSString *ghIdNo;
@property (nonatomic , strong)NSArray *ghIdNoPics;
@property (nonatomic , copy)NSString *ghHkb;
@property (nonatomic , strong)NSArray *ghHkbPics;
@property (nonatomic , copy)NSString *housePic;
@property (nonatomic , strong)NSArray *housePicPics;
@property (nonatomic , copy)NSString *houseUnitPic;
@property (nonatomic , strong)NSArray *houseUnitPicPics;
@property (nonatomic , copy)NSString *houseDoorPic;
@property (nonatomic , strong)NSArray *houseDoorPicPics;
@property (nonatomic , copy)NSString *houseRoomPic;
@property (nonatomic , strong)NSArray *houseRoomPicPics;
@property (nonatomic , copy)NSString *houseCustomerPic;
@property (nonatomic , strong)NSArray *houseCustomerPicPics;
@property (nonatomic , copy)NSString *houseSaleCustomerPic;
@property (nonatomic , strong)NSArray *houseSaleCustomerPicPics;
@property (nonatomic , copy)NSString *companyNamePic;
@property (nonatomic , strong)NSArray *companyNamePicPics;
@property (nonatomic , copy)NSString *companyPlacePic;
@property (nonatomic , strong)NSArray *companyPlacePicPics;
@property (nonatomic , copy)NSString *companyWorkshopPic;
@property (nonatomic , strong)NSArray *companyWorkshopPicPics;
@property (nonatomic , copy)NSString *companySaleCustomerPic;
@property (nonatomic , strong)NSArray *companySaleCustomerPicPics;
@property (nonatomic , copy)NSString *otherFilePdf;
@property (nonatomic , strong)NSArray *otherFilePdfPics;
@property (nonatomic , copy)NSString *isHouseProperty;
@property (nonatomic , copy)NSString *houseProperty;
@property (nonatomic , strong)NSArray *housePropertyPics;
@property (nonatomic , copy)NSString *isLicense;
@property (nonatomic , copy)NSString *license;
@property (nonatomic , strong)NSArray *licensePics;
@property (nonatomic , copy)NSString *isDriceLicense;
@property (nonatomic , copy)NSString *driceLicense;
@property (nonatomic , strong)NSArray *driceLicensePics;
@property (nonatomic , copy)NSString *isSiteProve;
@property (nonatomic , copy)NSString *siteProve;
@property (nonatomic , strong)NSArray *siteProvePics;
@property (nonatomic , copy)NSString *siteArea;
@property (nonatomic , copy)NSString *otherPropertyNote;
@property (nonatomic , copy)NSString *carType;
@property (nonatomic , copy)NSString *carTypeStr;
@property (nonatomic , strong)NSDictionary *bankSubbranch;
@property (nonatomic , copy)NSString *bocFeeWay;
@property (nonatomic , copy)NSString *oilSubsidy;
@property (nonatomic , copy)NSString *oilSubsidyKil;
@property (nonatomic , copy)NSString *gpsDeduct;
@property (nonatomic , copy)NSString *gpsFeeWay;
@property (nonatomic , copy)NSString *gpsFee;
@property (nonatomic , copy)NSString *isPlatInsure;
@property (nonatomic , copy)NSString *otherNote;
@property (nonatomic , copy)NSString *guarantor2BirthAddress;
@property (nonatomic , copy)NSString *guarantor1BirthAddress;
@property (nonatomic , copy)NSString *ghBirthAddress;
@property (nonatomic , copy)NSString *houseType;
@property (nonatomic , copy)NSString *applyNowAddress;
@property (nonatomic , copy)NSString *applyBirthAddress;
@property (nonatomic , copy)NSString *emergencyRelation2;
@property (nonatomic , copy)NSString *emergencyMobile2;
@property (nonatomic , copy)NSString *emergencyName2;
@property (nonatomic , copy)NSString *emergencyRelation1;
@property (nonatomic , copy)NSString *emergencyMobile1;
@property (nonatomic , copy)NSString *emergencyName1;
@property (nonatomic , copy)NSString *guarantor2JourShowIncome;
@property (nonatomic , copy)NSString *guarantor2Balance;
@property (nonatomic , copy)NSString *guarantor2SettleInterest;
@property (nonatomic , copy)NSString *guarantor2MonthIncome;
@property (nonatomic , copy)NSString *guarantor2IsPrint;
@property (nonatomic , copy)NSString *guarantor1JourShowIncome;
@property (nonatomic , copy)NSString *guarantor1Balance;
@property (nonatomic , copy)NSString *guarantor1SettleInterest;
@property (nonatomic , copy)NSString *guarantor1MonthIncome;
@property (nonatomic , copy)NSString *guarantor1IsPrint;
@property (nonatomic , copy)NSString *ghJourShowIncome;
@property (nonatomic , copy)NSString *ghBalance;
@property (nonatomic , copy)NSString *ghSettleInterest;
@property (nonatomic , copy)NSString *ghMonthIncome;
@property (nonatomic , copy)NSString *ghIsPrint;
@property (nonatomic , copy)NSString *applyUserJourShowIncome;
@property (nonatomic , copy)NSString *applyUserBalance;
@property (nonatomic , copy)NSString *applyUserSettleInterest;
@property (nonatomic , copy)NSString *applyUserMonthIncome;
@property (nonatomic , copy)NSString *applyUserIsPrint;
@property (nonatomic , copy)NSString *customerType;
@property (nonatomic , copy)NSString *carDealerType;
@property (nonatomic , copy)NSString *marryState;
@property (nonatomic , copy)NSString *applyUserGhrRelation;
@property (nonatomic , copy)NSString *applyUserDuty;
@property (nonatomic , copy)NSString *applyUserCompany;
@property (nonatomic , copy)NSString *rateType;
@property (nonatomic , copy)NSString *carDealerSubsidy;
@property (nonatomic , copy)NSString *loanPeriods;
@property (nonatomic , copy)NSString *companyLoanCs;
@property (nonatomic , copy)NSString *periods;
@property (nonatomic , copy)NSString *globalRate;
@property (nonatomic , copy)NSString *bankLoanCs;
@property (nonatomic , copy)NSString *carDealerName;
@property (nonatomic , copy)NSString *frameNo;
@property (nonatomic , copy)NSString *bankRate;
@property (nonatomic , copy)NSString *originalPrice;
@property (nonatomic , copy)NSString *PreCompanyLoanCs;
@property (nonatomic , copy)NSString *invoicePrice;
@property (nonatomic , copy)NSString *bizCompanyName;
@property (nonatomic , copy)NSString *collectionAccountNo;
@property (nonatomic , copy)NSString *isAdvanceFund;
@property (nonatomic , copy)NSString *monthIncome;
@property (nonatomic , copy)NSString *wxJourBalance;

@property (nonatomic , copy)NSString *fkDatetime;
@property (nonatomic , copy)NSString *guaCompanyName;
@property (nonatomic , copy)NSString *isCardMailAddress;
@property (nonatomic , copy)NSString *carSettleDatetime;
@property (nonatomic , copy)NSString *mateWxJourInterest;
@property (nonatomic , copy)NSString *repayBankCode;
@property (nonatomic , copy)NSString *mateZfbJourExpend;
@property (nonatomic , copy)NSString *guaZfbJourMonthIncome;
@property (nonatomic , copy)NSString *age;
@property (nonatomic , copy)NSString *guaInterest2;
@property (nonatomic , copy)NSString *zfbJourInterest;
@property (nonatomic , copy)NSString *jourExpend;
@property (nonatomic , copy)NSString *mateMobile;
@property (nonatomic , copy)NSString *carFrameNo;
@property (nonatomic , copy)NSString *mateJourExpend;
@property (nonatomic , copy)NSString *mateJourMonthExpend;
@property (nonatomic , copy)NSString *idKind;
@property (nonatomic , copy)NSString *mateInterest1;
@property (nonatomic , copy)NSString *mateJourIncome;

@property (nonatomic , copy)NSString *guaCompanyAddress;
@property (nonatomic , copy)NSString *familyNumber;
@property (nonatomic , copy)NSString *mateZfbJourBalance;
@property (nonatomic , copy)NSString *guaZfbJourInterest;
@property (nonatomic , copy)NSString *wxJourIncome;
@property (nonatomic , copy)NSString *mateCompanyName;
@property (nonatomic , copy)NSString *repayBankName;

@property (nonatomic , copy)NSString *political;
@property (nonatomic , copy)NSString *invoiceCompany;
@property (nonatomic , copy)NSString *loanProductName;
@property (nonatomic , copy)NSString *nowAddress;
@property (nonatomic , copy)NSString *cancelNodeCode;
@property (nonatomic , copy)NSString *customerName;
@property (nonatomic , copy)NSString *shopWay;
@property (nonatomic , copy)NSString *shopWayStr;
@property (nonatomic , copy)NSString *carInvoice;
@property (nonatomic , copy)NSString *otherIncomeNote;
@property (nonatomic , copy)NSString *currentInvoicePrice;
@property (nonatomic , copy)NSString *carHgzPic;
@property (nonatomic , copy)NSString *carJqx;
@property (nonatomic , copy)NSString *carSyx;
@property (nonatomic , copy)NSString *interviewOtherPdf;
@property (nonatomic , strong)NSArray *pics1;
@property (nonatomic , strong)NSArray *pics2;
@property (nonatomic , strong)NSArray *pics3;
@property (nonatomic , strong)NSArray *pics4;
@property (nonatomic , strong)NSArray *pics5;
@property (nonatomic , copy)NSString *fee;
@property (nonatomic , copy)NSArray *budgetOrderGpsList;
@property (nonatomic , copy)NSString *carDealerCode;
@property (nonatomic , copy)NSString *carDealerCodeStr;
@property (nonatomic , copy)NSArray *carDealerArray;
@property (nonatomic,copy) NSString * xszReverse;
@property (nonatomic,copy) NSString * xszFront;
//@property (nonatomic,copy) NSString * secondCarReport;
@property (nonatomic,strong) NSString * saleUserPostName;
@property (nonatomic,strong) NSString * insideJobPostName;
@property (nonatomic,strong) NSDictionary * carPledge;
@property (nonatomic,strong) NSDictionary * advance;
@property (nonatomic,strong) NSDictionary * bankLoan;
@property (nonatomic,strong) NSArray * budgetOrderGps;
@property (nonatomic,strong) NSString * cardPostAddress;
@property (nonatomic,strong) NSArray * repayPlanList;
@property (nonatomic,strong) NSString * intevDateTime;
@property (nonatomic,strong) NSString * enterLocation;
@property (nonatomic,strong) NSString * cardPostProvince;
@property (nonatomic,strong) NSString * cardPostCity;
@property (nonatomic,strong) NSString * cardPostArea;
@property (nonatomic,copy) NSString * cardPostCode;
@property (nonatomic,copy) NSString * repayCardNumber;
@property (nonatomic,strong) NSArray * repointList;
//@property (nonatomic,strong) NSDictionary *advance;

@property (nonatomic,strong) NSArray * gpsAzList;

@property (nonatomic , strong)NSArray *pics6;
@property (nonatomic , strong)NSArray *pics7;
@property (nonatomic , strong)NSArray *pics8;//身份证照片
@property (nonatomic , copy)NSString *carBigSmj;
@property (nonatomic , copy)NSString *carKey;
@property (nonatomic , copy)NSString *carPd;
@property (nonatomic , copy)NSString *carRegcerti;
@property (nonatomic , copy)NSString *carXszSmj;
@property (nonatomic , copy)NSString *dutyPaidProveSmj;

@property (nonatomic , copy)NSString *hitPieceDatetime;
@property (nonatomic , copy)NSString *hitPieceNote;
@property (nonatomic , copy)NSString *rationaleNote;
@property (nonatomic , copy)NSString *rationaleDatetime;
@property (nonatomic , strong)NSArray *Newpics1;
@property (nonatomic , strong)NSArray *Newpics2;
@property (nonatomic , strong)NSArray *Newpics3;
@property (nonatomic , strong)NSArray *Newpics4;
@property (nonatomic , strong)NSArray *Newpics5;
@property (nonatomic , strong)NSArray *Newpics6;
@property (nonatomic , strong)NSArray *Newpics7;
@property (nonatomic , strong)NSArray *Newpics8;//身份证照片

//http.parameters[@"enterLocation"] = enterLocation;
//        http.parameters[@"insuranceCompany"] = insuranceCompany;
//        http.parameters[@"syxDateStart"] = syxDateStart;
//        http.parameters[@"syxDateEnd"] = syxDateEnd;
@property (nonatomic , copy)NSString *insuranceCompanyName;
@property (nonatomic , copy)NSString *syxDateStart;
@property (nonatomic , copy)NSString *syxDateEnd;


@property (nonatomic , copy)NSString *pledgeUser;
@property (nonatomic , copy)NSString *advanfCurNodeCode;
@property (nonatomic , copy)NSString *pledgeUserIdCardCopy;
@property (nonatomic , copy)NSString *supplementNote;//补充说明
@property (nonatomic , copy)NSString *pledgeAddress; //抵押地点
@property (nonatomic , copy)NSString *approveNote; //抵押地点
@property (nonatomic , copy)NSString *carNumber; //车牌号
@property (nonatomic , copy)NSString *areaName; //区域经理
//@property (nonatomic , strong) NSDictionary *creditUser;
@property (nonatomic , strong) NSDictionary *gpsApply;

@property (nonatomic,strong) NSString * enterNodeCode;

//@property (nonatomic,strong) NSString * repayCardNumber;

@property (nonatomic,copy) NSString * subbranchBankName;

@property (nonatomic,copy) NSString * restAmount;
@property (nonatomic,copy) NSArray * creditJours;
@property (nonatomic,strong) NSDictionary * user;
@property (nonatomic,copy) NSString * enterCode;
@property (nonatomic,copy) NSArray * advanceCollectCardList;

@property (nonatomic , copy)NSString *regionName;
//@property (nonatomic , copy)NSString *gpsFee;
@property (nonatomic , copy)NSString *fxAmount;
@property (nonatomic , copy)NSString *lyDeposit;
@property (nonatomic , copy)NSString *otherFee;
//@property (nonatomic , copy)NSString *repointAmount;
@property (nonatomic , copy)NSString *carFunds3;
@property (nonatomic , copy)NSString *carFunds4;
@property (nonatomic , copy)NSString *carFunds5;


@end
