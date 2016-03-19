//
//  GGFMDB.h
//  GGHelper
//
//  Created by alloter on 16/3/19.
//  Copyright © 2016年 alloter. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMResultSet, FMDatabase;

@interface GGFMDB : NSObject

/*** sql执行 是否成功，YES:成功，No:失败 */
@property (nonatomic, assign) BOOL sqlStatus;
/*** sql执行 描述 */
@property (nonatomic, strong) NSString *sqlMessage;
/*** data结果 结果集 */
@property (nonatomic, strong) NSDictionary *dbResultDictionary;
/*** data结果 单个值 */
@property (nonatomic, strong) NSString *dbResultSingle;


/*** 初始化，返回结果集对象 */
+ (instancetype)initDBSqlHelperWithYesOrNo:(BOOL)yesOrNo;

#pragma mark --- database path
+ (NSString *)databaseConfigPath;
+ (FMDatabase *)databaseCreateObject;

+ (GGFMDB *)databaseExecuteWithSql:(NSString *)sql andArgumentsInArray:(NSArray *)arguments;
+ (GGFMDB *)databaseExecuteWithSql:(NSString *)sql andParameterDictionary:(NSDictionary *)arguments;
+ (GGFMDB *)databaseQueryWithSql:(NSString *)sql withArgumentsInArray:(NSArray *)arguments;
+ (GGFMDB *)databaseQueryWithSql:(NSString *)sql withParameterDictionary:(NSDictionary *)arguments;
+ (GGFMDB *)databaseSingleWithSql:(NSString *)sql withArgumentsInArray:(NSArray *)arguments;
+ (GGFMDB *)databaseSingleWithSql:(NSString *)sql withParameterDictionary:(NSDictionary *)arguments;

#pragma mark --- database getOrset
+ (void)setDatabaseVersionWithVersionNumber:(NSInteger)versionNumber;
+ (NSInteger)getDatabaseVersion;
+ (BOOL)isNeedUpdateDatabase;

#pragma mark --- database stored procedure
/*** 使用存储过程批量执行 */
+ (BOOL)databaseExecuteProcedureWithSqlArray:(NSArray *)sqlArray;
/*** 使用存储过程批量执行, isTransaction:是否事务处理 */
+ (BOOL)databaseExecuteProcedureWithSqlArray:(NSArray *)sqlArray andIsTransaction:(BOOL)isTransaction;

#pragma mark --- Is Exist
/*** 判断表是否存在 */
+ (BOOL)isExistTableWithTableName:(NSString *)tableName;

#pragma mark --- drop table
/*** 删除表 */
+ (BOOL)dropTableWithTableName:(NSString *)tableName;

@end
