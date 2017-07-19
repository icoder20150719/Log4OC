//
//  Log4OC.h
//  LOGDemo
//
//  Created by xiongan on 2017/7/18.
//  Copyright © 2017年 xiongan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Log4OC : NSObject
//系统日志级别
typedef NS_ENUM(NSUInteger,LogLevel) {
    /*! 显示包括(DEBUGLog,VERBOSELog,INFOLog,WARNINGLog,ERRORLog的Log)*/
    LogLevel_DEBUG   = 0b00011111,
    /*! 显示包括(VERBOSELog,INFOLog,WARNINGLog,ERRORLog的Log)*/
    LogLevel_VERBOSE = 0b00001111,
    /*! 显示包括(INFOLog,WARNINGLog,ERRORLog的Log)*/
    LogLevel_INFO    = 0b00000111,
    /*! 显示包括(WARNINGLog,ERRORLog的Log)*/
    LogLevel_WARNING = 0b00000011,
    /*! 只显示ERRORLog的log*/
    LogLevel_ERROR   = 0b00000001,
};

/**
 * level  设计日志输出级别
 *  eg: 
            #ifdef __OPTIMIZE__
                setLogLevel(LogLevel_INFO); //在realse模式下只输出INFO级别或者更高级别的LOG，不输出DEBUGLog
            #endif
 *
 */
FOUNDATION_EXPORT void setLogLevel(LogLevel level);
/*
 * 设置日志回滚大小，单位字节 默认10MB
 */
FOUNDATION_EXPORT void setRollBack(double fileSize);

FOUNDATION_EXPORT void DEBUGLog(NSString *message,...) NS_FORMAT_FUNCTION(1,2);
FOUNDATION_EXPORT void VERBOSELog(NSString *message,...) NS_FORMAT_FUNCTION(1,2);
FOUNDATION_EXPORT void INFOLog(NSString *message,...) NS_FORMAT_FUNCTION(1,2);
FOUNDATION_EXPORT void WARNINGLog(NSString *message,...) NS_FORMAT_FUNCTION(1,2);
FOUNDATION_EXPORT void ERRORLog(NSString *message,...) NS_FORMAT_FUNCTION(1,2);
@end
