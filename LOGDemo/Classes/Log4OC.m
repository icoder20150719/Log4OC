//
//  Log4OC.m
//  LOGDemo
//
//  Created by xiongan on 2017/7/18.
//  Copyright © 2017年 xiongan. All rights reserved.
//

#import "Log4OC.h"

@implementation Log4OC
static LogLevel __LogLevel = LogLevel_DEBUG;
static NSInteger __count = 1;
static double __fileSize = 10*1000*1000;//10MB
static NSString * __filePath = @"";
static FILE *__logOutp;
void setLogLevel(LogLevel level){
    __LogLevel = level;
}
void setRollBack(double fileSize){
    __fileSize = fileSize;
}

+(void)load {

    //创建日志目录
    NSString *dirc = creatLogDir();
    //创建日志文件
    NSString *filePath = creatLogFile(dirc);
    __filePath = filePath;
    do {
        rollBackSize ();
    } while (fileSize(__filePath) >= __fileSize);
    NSLog(@"LOG日志路径为:%@",__filePath);
    if (__logOutp) {
        fclose(__logOutp);
    }
    //打开输出文件
    __logOutp = fopen([__filePath UTF8String],"a+");
    setvbuf(__logOutp, NULL, _IONBF, 0);
}
static inline NSString* creatLogDir (){
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dirc = [documentsDirectory stringByAppendingPathComponent:@"Log"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:dirc]) {
        [fm createDirectoryAtPath:dirc withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return dirc;
}
static inline NSString* creatLogFile (NSString* path){
    NSFileManager *fm = [NSFileManager defaultManager];
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy_MM_dd";
    NSString *timeStr = [fmt stringFromDate:[NSDate new]];
    NSString *filePath = [path stringByAppendingString:[NSString stringWithFormat:@"/access_%@_%02ld.log",timeStr,(long)__count]];
    if (![fm fileExistsAtPath:filePath]) {
        [fm createFileAtPath:filePath contents:nil attributes:nil];
    }
    return filePath;
}
static inline void rollBackSize () {
    if (fileSize(__filePath) >= __fileSize) {
        __count ++;
        if (__logOutp) {
             fclose(__logOutp);
        }
        NSString *filePath = creatLogFile(creatLogDir());
        __filePath = filePath;
        //打开输出文件
        __logOutp = fopen([filePath UTF8String],"a+");
        setvbuf(__logOutp, NULL, _IONBF, 0);
    }
    
}
static inline double fileSize (NSString *path) {
    NSFileManager *fm = [NSFileManager defaultManager];
    return [[fm attributesOfItemAtPath:path error:nil]fileSize];
}
static NSDateFormatter *__LogFormatter;
static inline NSDateFormatter* logFormatter(){
    if (!__LogFormatter) {
        __LogFormatter = [[NSDateFormatter alloc] init];
        __LogFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.sss";
    }
    return __LogFormatter;
}

void privateLog(const char *cString,LogLevel level){
    NSString *symbols;
    switch (level) {
        case LogLevel_DEBUG:
            symbols = @"【DEBUG】";
            break;
        case LogLevel_VERBOSE:
            symbols = @"【VERBOSE】";
            break;
        case LogLevel_INFO:
            symbols = @"【INFO】";
            break;
        case LogLevel_WARNING:
            symbols = @"【WARNING】";
            break;
        case LogLevel_ERROR:
            symbols = @"【ERROR】";
            break;
        default:
            break;
    }
    const char *dateString = [[logFormatter() stringFromDate:[NSDate date]] UTF8String];
    printf("%s %s : %s \n",[symbols UTF8String],dateString,cString);
    rollBackSize ();
}

void DEBUGLog(NSString *message,...){
    if ((__LogLevel & LogLevel_DEBUG) != LogLevel_DEBUG) {
        return;
    }
    va_list argList;
    va_start(argList, message);
    const char *cString = [[[NSString alloc] initWithFormat:message arguments:argList] UTF8String];
    privateLog(cString, LogLevel_DEBUG);
    va_end(argList);
}

void VERBOSELog(NSString *message,...){
    if ((__LogLevel & LogLevel_VERBOSE) != LogLevel_VERBOSE) {
        return;
    }
    va_list argList;
    va_start(argList, message);
    const char *cString = [[[NSString alloc] initWithFormat:message arguments:argList] UTF8String];
    privateLog(cString, LogLevel_VERBOSE);
    va_end(argList);
}


void INFOLog(NSString *message,...){
    if ((__LogLevel & LogLevel_INFO) != LogLevel_INFO) {
        return;
    }
    va_list argList;
    va_start(argList, message);
    const char *cString = [[[NSString alloc] initWithFormat:message arguments:argList] UTF8String];
    privateLog(cString, LogLevel_INFO);
    va_end(argList);
}

void WARNINGLog(NSString *message,...){
    
    if ((__LogLevel & LogLevel_WARNING) != LogLevel_WARNING) {
        return;
    }
    va_list argList;
    va_start(argList, message);
    const char *cString = [[[NSString alloc] initWithFormat:message arguments:argList] UTF8String];
    privateLog(cString, LogLevel_WARNING);
    va_end(argList);
}


void ERRORLog(NSString *message,...){
    if ((__LogLevel & LogLevel_ERROR) != LogLevel_ERROR) {
        return;
    }
    va_list argList;
    va_start(argList, message);
    const char *cString = [[[NSString alloc] initWithFormat:message arguments:argList] UTF8String];
    privateLog(cString, LogLevel_ERROR);
    va_end(argList);
}
int __cdecl printf(const char *format, ...)  {
    
    int vprintfReturn = 0;
    va_list args;
    va_list tpargs;
    va_start(args, format);
    va_copy(tpargs, args);
    //写文件
    vfprintf(__logOutp, format, tpargs);
    va_end(tpargs);
    //写控制台
    vprintfReturn = vprintf(format, args);
    va_end(args);
    
    return vprintfReturn;
}


@end
