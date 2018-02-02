# Log4OC

## Log4OC is log tool for iOS developer.you can use it as NSLog.

Log will be exported to file, the path is “/Documents/Log/” eg:access_2017_07_19_1.log


# 基本用法 Basic Usage

## 1、 it's just like use NSLog;基本用法和NSLog用法一致

```
eg:DEBUGLog(@"DEBUGLog");
INFOLog(@"INFOLog");
WARNINGLog(@"WARNINGLog");
ERRORLog(@"ERRORLog");
```
    

## 2、In development, using DEBUGLog, setting the testLogLevel level, does not output DEBUG useless output in release mode 在开发中，使用DEBUGLog，设置testLogLevel级别可以在release模式不输出DEBUG无用的输出

## 3、You can use the log rollback feature testRollBack, which defaults to 10MB rollback and generates a new log file 可以使用日志回滚功能testRollBack，默认设置了10MB回滚，会产生一个新的日志文件

# Usege with pod

### pod "Log4OC"

## 简书介绍：https://www.jianshu.com/p/be897862231a
