//
//  JXModel.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/5/18.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "JXModel.h"

@implementation JXModel
- (id)initWithDic:(NSDictionary *)dic
{
    if (self = [self init]) {
        //[self setValuesForKeysWithDictionary:info];
        self.uid= [dic objectForKey:@"uid"];
        self.headurl= [dic objectForKey:@"headurl"];
        self.surname= [dic objectForKey:@"surname"];
        self.price= [dic objectForKey:@"price"];
        self.sex= [dic objectForKey:@"sex"];
        self.tel=[dic objectForKey:@"tel"];
        self.birthday= [dic objectForKey:@"birthday"];
        self.working= [dic objectForKey:@"working"];
        self.record= [dic objectForKey:@"record"];
        self.jiguan= [dic objectForKey:@"jiguan"];
    }
    
    return self;
}
//如果有没有出现的属性对儿 这个是防止闪退
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    return;
}
@end
