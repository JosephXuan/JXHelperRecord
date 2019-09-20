//
//  JXModel.h
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/5/18.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JXModel;
@interface JXModel : NSObject
@property(copy,nonatomic)NSString*birthday;
@property(copy,nonatomic)NSString*appraise;
@property(copy,nonatomic)NSString*techang;
@property(copy,nonatomic)NSString*mtype;
@property(copy,nonatomic)NSString*ishome;
@property(copy,nonatomic)NSString*headurl;
@property(copy,nonatomic)NSString*record;
@property(copy,nonatomic)NSString*sex;
@property(copy,nonatomic)NSString*tel;
@property(copy,nonatomic)NSString*constellation;
@property(copy,nonatomic)NSString*starttime;
@property(copy,nonatomic)NSString*endtime;
@property(copy,nonatomic)NSString*jiguan;
@property(copy,nonatomic)NSString*kouwei;
@property(copy,nonatomic)NSString*latitude;
@property(copy,nonatomic)NSString*name;
@property(copy,nonatomic)NSString*shopname;
@property(copy,nonatomic)NSString*updatetime;
@property(copy,nonatomic)NSString*state;
@property(copy,nonatomic)NSString*userBirthday;
@property(copy,nonatomic)NSString*idStr;
@property(copy,nonatomic)NSString*uid;
@property(copy,nonatomic)NSString*longitude;
@property(copy,nonatomic)NSString*hobby;
@property(copy,nonatomic)NSString*quarters;
@property(copy,nonatomic)NSString*working;
@property(copy,nonatomic)NSString*writeaddress;
@property(copy,nonatomic)NSString*createtime;
@property(copy,nonatomic)NSString*price;
@property(copy,nonatomic)NSString*surname;
@property(copy,nonatomic)NSString*address;
- (id)initWithDic:(NSDictionary *)dic;
@end
