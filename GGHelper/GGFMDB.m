//
//  GGFMDB.m
//  GGHelper
//
//  Created by alloter on 16/3/19.
//  Copyright © 2016年 alloter. All rights reserved.
//

#import "GGFMDB.h"
#import "FMDB.h"

#define kSqlDatabaseName        @"ggfmdb.sqlite"
#define kSqlConnectError        @"链接数据库失败"
#define kSqlExcuteFailed        @"执行失败"
#define kSqlExcuteSuccess       @"执行成功"
#define kSqlQueryFailed         @"查询失败"
#define kSqlQuerySuccess        @"查询成功"
#define kSqlSingleFailed        @"查询失败"
#define kSqlSingleSuccess       @"查询成功"

// --> 数据库的版本，数据库本地保存的名称
#define kSqlDatabaseVersion     1
#define kSqlDatabaseSaveVersion @"keySaveDatabaseVersion"

@implementation GGFMDB

+ (instancetype)initGGFMDBWithYesOrNo:(BOOL)yesOrNo
{
    GGFMDB *rect = [[GGFMDB alloc] init];
    
    if (yesOrNo) {
        rect.sqlStatus = YES;
        rect.sqlMessage = @"成功";
    }
    else {
        rect.sqlStatus = NO;
        rect.sqlMessage = @"失败";
    }
    
    return rect;
}

#pragma mark --- database config
+ (NSString *)databaseConfigPath
{
    NSString *databaseName = kSqlDatabaseName;
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [docPaths objectAtIndex:0];
    NSString *dataPath = [documents stringByAppendingPathComponent:databaseName];
    
    return dataPath;
}
+ (FMDatabase *)databaseCreateObject
{
    FMDatabase *db = [FMDatabase databaseWithPath:[GGFMDB databaseConfigPath]];
    
    return db;
}

+ (GGFMDB *)databaseExecuteWithSql:(NSString *)sql andArgumentsInArray:(NSArray *)arguments
{
    GGFMDB *rect = [GGFMDB initGGFMDBWithYesOrNo:NO];
    FMDatabase *db = [GGFMDB databaseCreateObject];
    if ([db open]) {
        rect.sqlStatus = [db executeUpdate:sql withArgumentsInArray:arguments];
        if (rect.sqlStatus) {
            rect.sqlMessage = kSqlExcuteSuccess;
        }
        else{
            rect.sqlMessage = kSqlExcuteFailed;
        }
    }
    else {
        QBLog(kSqlConnectError);
        rect.sqlStatus = NO;
        rect.sqlMessage = kSqlConnectError;
    }
    [db close];
    
    return rect;
}
+ (GGFMDB *)databaseExecuteWithSql:(NSString *)sql andParameterDictionary:(NSDictionary *)arguments
{
    GGFMDB *rect = [GGFMDB initGGFMDBWithYesOrNo:NO];
    FMDatabase *db = [GGFMDB databaseCreateObject];
    if ([db open]) {
        rect.sqlStatus = [db executeUpdate:sql withParameterDictionary:arguments];
        if (rect.sqlStatus) {
            rect.sqlMessage = kSqlExcuteSuccess;
        }
        else{
            rect.sqlMessage = kSqlExcuteFailed;
        }
    }
    else {
        QBLog(kSqlConnectError);
        rect.sqlStatus = NO;
        rect.sqlMessage = kSqlConnectError;
    }
    [db close];
    
    return rect;
}
+ (GGFMDB *)databaseQueryWithSql:(NSString *)sql withArgumentsInArray:(NSArray *)arguments
{
    GGFMDB *rect = [GGFMDB initGGFMDBWithYesOrNo:NO];
    FMDatabase *db = [GGFMDB databaseCreateObject];
    if ([db open]) {
        FMResultSet *rs = [db executeQuery:sql withArgumentsInArray:arguments];
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSMutableDictionary *dics = [NSMutableDictionary dictionary];
        NSInteger k = 0;
        while ([rs next]) {
            if (k == 0) {
                for (int c = 0; c < INT_MAX; c++) {
                    BOOL columnIsNull = [rs columnIndexIsNull:c];
                    if (columnIsNull) { break; }
                    
                    NSString *columnName = [rs columnNameForIndex:c];
                    [array addObject:columnName];
                }
            }
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            for (int b = 0; b < array.count; b++) {
                NSString *columnKey = array[b];
                NSString *columnvalue = [rs stringForColumn:columnKey];
                [dic setObject:columnvalue forKey:columnKey];
            }
            [dics setObject:dic forKey:[NSString stringWithFormat:@"%d", k]];
            
            k++;
        }
        
        if (dics.count > 0) {
            rect.sqlStatus = YES;
            rect.sqlMessage = kSqlQuerySuccess;
            rect.dbResultDictionary = dics;
        }
        else{
            rect.sqlStatus = NO;
            rect.sqlMessage = kSqlQueryFailed;
        }
    }
    else {
        QBLog(kSqlConnectError);
        rect.sqlStatus = NO;
        rect.sqlMessage = kSqlConnectError;
    }
    [db close];
    
    return rect;
}
+ (GGFMDB *)databaseQueryWithSql:(NSString *)sql withParameterDictionary:(NSDictionary *)arguments
{
    GGFMDB *rect = [GGFMDB initGGFMDBWithYesOrNo:NO];
    FMDatabase *db = [GGFMDB databaseCreateObject];
    if ([db open]) {
        FMResultSet *rs = [db executeQuery:sql withParameterDictionary:arguments];
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSMutableDictionary *dics = [NSMutableDictionary dictionary];
        NSInteger k = 0;
        while ([rs next]) {
            if (k == 0) {
                for (int c = 0; c < INT_MAX; c++) {
                    BOOL columnIsNull = [rs columnIndexIsNull:c];
                    if (columnIsNull) { break; }
                    
                    NSString *columnName = [rs columnNameForIndex:c];
                    [array addObject:columnName];
                }
            }
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            for (int b = 0; b < array.count; b++) {
                NSString *columnKey = array[b];
                NSString *columnvalue = [rs stringForColumn:columnKey];
                [dic setObject:columnvalue forKey:columnKey];
            }
            [dics setObject:dic forKey:[NSString stringWithFormat:@"%d", k]];
            
            k++;
        }
        
        if (dics.count > 0) {
            rect.sqlStatus = YES;
            rect.sqlMessage = kSqlQuerySuccess;
            rect.dbResultDictionary = dics;
        }
        else{
            rect.sqlStatus = NO;
            rect.sqlMessage = kSqlQueryFailed;
        }
    }
    else {
        QBLog(kSqlConnectError);
        rect.sqlStatus = NO;
        rect.sqlMessage = kSqlConnectError;
    }
    [db close];
    
    return rect;
}
+ (GGFMDB *)databaseSingleWithSql:(NSString *)sql withArgumentsInArray:(NSArray *)arguments
{
    GGFMDB *rect = [GGFMDB initGGFMDBWithYesOrNo:NO];
    FMDatabase *db = [GGFMDB databaseCreateObject];
    if ([db open]) {
        FMResultSet *rs = [db executeQuery:sql withArgumentsInArray:arguments];
        while ([rs next]) {
            BOOL columnIsNull = [rs columnIndexIsNull:0];
            if (columnIsNull) { break; }
            
            NSString *single = [rs stringForColumnIndex:0];
            rect.dbResultSingle = single;
            break;
        }
        
        if (rect.dbResultSingle) {
            rect.sqlStatus = YES;
            rect.sqlMessage = kSqlSingleSuccess;
        }
        else{
            rect.sqlStatus = NO;
            rect.sqlMessage = kSqlSingleFailed;
        }
    }
    else {
        QBLog(kSqlConnectError);
        rect.sqlStatus = NO;
        rect.sqlMessage = kSqlConnectError;
    }
    [db close];
    
    return rect;
}
+ (GGFMDB *)databaseSingleWithSql:(NSString *)sql withParameterDictionary:(NSDictionary *)arguments
{
    GGFMDB *rect = [GGFMDB initGGFMDBWithYesOrNo:NO];
    FMDatabase *db = [GGFMDB databaseCreateObject];
    if ([db open]) {
        FMResultSet *rs = [db executeQuery:sql withParameterDictionary:arguments];
        while ([rs next]) {
            BOOL columnIsNull = [rs columnIndexIsNull:0];
            if (columnIsNull) { break; }
            
            NSString *single = [rs stringForColumnIndex:0];
            rect.dbResultSingle = single;
            break;
        }
        
        if (rect.dbResultSingle) {
            rect.sqlStatus = YES;
            rect.sqlMessage = kSqlSingleSuccess;
        }
        else{
            rect.sqlStatus = NO;
            rect.sqlMessage = kSqlSingleFailed;
        }
    }
    else {
        QBLog(kSqlConnectError);
        rect.sqlStatus = NO;
        rect.sqlMessage = kSqlConnectError;
    }
    [db close];
    
    return rect;
}

#pragma mark --- database getOrset
+ (void)setDatabaseVersionWithVersionNumber:(NSInteger)versionNumber
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:versionNumber forKey:kSqlDatabaseSaveVersion];
    [userDefaults synchronize];
}
+ (NSInteger)getDatabaseVersion
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    id version = [userDefaults objectForKey:kSqlDatabaseSaveVersion];
    if (version == nil) {
        NSInteger kVersion = kSqlDatabaseVersion;
        [userDefaults setInteger:kVersion forKey:kSqlDatabaseSaveVersion];
        [userDefaults synchronize];
        
        return kVersion;
    }
    
    return [version integerValue];
}
+ (BOOL)isNeedUpdateDatabase
{
    BOOL rect = NO;
    
    NSInteger oldVersion = [GGFMDB getDatabaseVersion];
    NSInteger newVersion = kSqlDatabaseVersion;
    if (oldVersion < newVersion) {
        rect = YES;
    }
    
    return rect;
}

#pragma mark --- database stored procedure
+ (BOOL)databaseExecuteProcedureWithSqlArray:(NSArray *)sqlArray
{
    return [GGFMDB databaseExecuteProcedureWithSqlArray:sqlArray andIsTransaction:YES];
}
+ (BOOL)databaseExecuteProcedureWithSqlArray:(NSArray *)sqlArray andIsTransaction:(BOOL)isTransaction
{
    BOOL rect = NO;
    
    FMDatabase *db = [FMDatabase databaseWithPath:[GGFMDB databaseConfigPath]];
    [db open];
    if (isTransaction) {
        [db beginTransaction];
        BOOL isRollBack = NO;
        @try {
            for (int i = 0; i < sqlArray.count; i++) {
                NSString *sql = sqlArray[i];
                BOOL result = [db executeUpdate:sql];
                if (!result) {
                    isRollBack = YES;
                }
            }
        }
        @catch (NSException *exception) {
            isRollBack = YES;
        }
        @finally {
            if (isRollBack) {
                [db rollback];
            }
            else {
                [db commit];
                rect = YES;
            }
        }
    }
    else {
    }
    [db close];
    
    return rect;
}

#pragma mark --- Is Exist
+ (BOOL)isExistTableWithTableName:(NSString *)tableName
{
    BOOL rect = NO;
    
    NSString *sql = [NSString stringWithFormat:@"select count(1) as countNum from sqlite_master where type='table' and name='%@'", tableName];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[GGFMDB databaseConfigPath]];
    [db open];
    FMResultSet *rs = [db executeQuery:sql];
    while ([rs next])
    {
        NSInteger count = [rs intForColumn:@"countNum"];
        
        if (count > 0) {
            rect = YES;
        }
    }
    [db close];
    
    return rect;
}

#pragma mark --- drop table
+ (BOOL)dropTableWithTableName:(NSString *)tableName
{
    BOOL rect = NO;
    
    NSString *sql = [NSString stringWithFormat:@"drop table %@", tableName];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[GGFMDB databaseConfigPath]];
    [db open];
    rect = [db executeUpdate:sql];
    [db close];
    
    return rect;
}

@end
