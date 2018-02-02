//
//  ViewController.m
//  LOGDemo
//
//  Created by xiongan on 2017/7/18.
//  Copyright © 2017年 xiongan. All rights reserved.
//

#import "ViewController.h"

#import "Log4OC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*####使用说明###*/
    
    //1、基本用法和NSLog用法一致
    
    //2、在开发中，使用DEBUGLog，设置testLogLevel级别可以在release模式不输出DEBUG无用的输出
    
    //3、可以使用日志回滚功能testRollBack，默认设置了10MB回滚，会产生一个新的日志文件

    [self testBase];
    NSLog(@"NSLog");
}
/**
 *  测试日志基本功能
 */
- (void)testBase {
    NSString *str = @"hello world";
    DEBUGLog(@"%@",str);
    INFOLog(@"INFOLog");
    WARNINGLog(@"WARNINGLog");
    ERRORLog(@"ERRORLog");
    
}
/**
 *  测试日志回滚功能
 */
- (void)testRollBack {
    
    int i = 0;
    while (i < 500000) {
        i ++;
        DEBUGLog(@" 😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄%d",i);
    }
    
}
/**
 *  测试日志在realse模式下只输出INFO级别或者更高级别的LOG
 */
- (void)testLogLevel {
#ifdef __OPTIMIZE__
    setLogLevel(LogLevel_INFO);
#endif
}



@end
