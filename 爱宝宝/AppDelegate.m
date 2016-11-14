//
//  AppDelegate.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/9/12.
//  Copyright © 2016年 PUHIM. All rights reserved.
//58082571e0f55aab9b00131f

#import "AppDelegate.h"
#import "XFRootVC.h"
#import "XFloginVC.h"
#import "XFlabChoseVC.h"
//集成
//#import <UMSocialCore/UMSocialCore.h>
#import "UMSocial.h"
#import "UMSocialSinaSSOHandler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //创建窗口
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //初始化控制器

    //navigation 导航控制器
    XFlabChoseVC *XFlabVC = [[XFlabChoseVC alloc]init];
    UINavigationController *rotVC = [[UINavigationController alloc]initWithRootViewController:XFlabVC];
    
    //
    self.window.rootViewController = rotVC;
    //显示窗口
    [self.window makeKeyAndVisible];
    
    //设置启动图片的持续时间
    [NSThread sleepForTimeInterval:1.0];
    
    //分享的部分
    //
    //
    //打开调试日志
    [UMSocialData setAppKey:@"58082571e0f55aab9b00131f"];
    

    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954"
                                              secret:@"04b48b094faeb16683c32669824ebdad"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//
//
//
//
//
//
//
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}
@end
