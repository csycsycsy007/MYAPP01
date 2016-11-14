//
//  XFbtnsView.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/9/22.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import "XFbtnsView.h"



@interface XFbtnsView ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneNumLab;

@property (weak, nonatomic) IBOutlet UITextField *checkNumLab;
@property (weak, nonatomic) IBOutlet UIButton *getCheckNumBtn;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@end

@implementation XFbtnsView

+(instancetype)initWithnnnib {
    return [[[NSBundle mainBundle]loadNibNamed:@"XFbtnsView" owner:nil options:nil]lastObject];
}
- (IBAction)checkNumBtnClick:(UIButton *)sender {
    
    self.getCheckNumBtn.enabled = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.getCheckNumBtn.enabled = YES;
    });
    
}

- (IBAction)loginBtnClick:(id)sender {
    
//    NSLog(@"登录");
    
    
    // 通过代理工作
    [self.delegate loginBtnClick:self];

}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    

    NSLog(@"textFieldDidBeginEditing");
    
//    CGRect frame = textField.frame;
//    
//    CGFloat heights = self.frame.size.height;
    
    // 当前点击textfield的坐标的Y值 + 当前点击textFiled的高度 - （屏幕高度- 键盘高度 - 键盘上tabbar高度）
    
    // 在这一部 就是了一个 当前textfile的的最大Y值 和 键盘的最全高度的差值，用来计算整个view的偏移量
    
    int offset = [UIScreen mainScreen].bounds.size.height - (156 + 216);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    float width = self.frame.size.width;
    
    float height = self.frame.size.height;
    
    if(offset > 0)
        
    {
        
        CGRect rect = CGRectMake(0.0f, offset,width,height);
        
        self.frame = rect;
        
    }
    
    [UIView commitAnimations];

    
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"touchbegan");
//    [self endEditing:YES];
//    
//    NSTimeInterval animationDuration = 0.30f;
//    
//    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//    
//    [UIView setAnimationDuration:animationDuration];
//    
//    CGRect rect = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
//    
//    self.frame = rect;
//    
//    [UIView commitAnimations];
    
    if (![_checkNumLab isExclusiveTouch])
    {
        
        [self endEditing:YES];
    }
    if (![_phoneNumLab isExclusiveTouch])
    {
        
        [self endEditing:YES];
    }
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [self validateNumber:string];
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        
        i++;
    }
    
    return res;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
