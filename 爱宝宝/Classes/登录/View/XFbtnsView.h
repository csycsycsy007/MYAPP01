//
//  XFbtnsView.h
//  爱宝宝
//
//  Created by 小凡 席 on 16/9/22.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XFbtnsView;
//typedef void(^goLoginBtn)(UIButton *button);
@protocol XFbtnViewDelegate <NSObject>
@optional // 可选实现
// 代理方法命名规范: 当前被代理者类名不加前缀开头,方法最少要有一个参数把被代理者自己给传过去
- (void)loginBtnClick:(XFbtnsView *)appView;

@end
@interface XFbtnsView : UIView
@property (nonatomic, weak) id<XFbtnViewDelegate> delegate;
+(instancetype)initWithnnnib;

//- (void)setLoginBtn:(goLoginBtn)block2;

@end
