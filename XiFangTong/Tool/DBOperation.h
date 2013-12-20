//
//  DBOperation.h
//  SQLiteTest
//
//  Created by iss on 6/19/13.
//  Copyright (c) 2013 iss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "HouseInfo.h"
#import "ActivityInfo.h"
#import "GroupBuyInfo.h"
#import "HouseInfoRequest.h"

//我报名的活动
#define SQL_CreateActiveTable @"CREATE TABLE IF NOT EXISTS actives (ID INTEGER PRIMARY KEY AUTOINCREMENT, 'activeID' TEXT, 'houseid' TEXT, 'fullName' TEXT, 'tuan' TEXT,'actIntro' TEXT,'dateEnd' TEXT, 'saveDate' TEXT)"

#define ACTIVE @[ @"activeID", @"houseid", @"fullName",@"tuan",@"actIntro",@"dateEnd", @"saveDate"];

//我参加的团购
#define SQL_CreateGroupTable @"CREATE TABLE IF NOT EXISTS Groups (ID INTEGER PRIMARY KEY AUTOINCREMENT, 'groupID' TEXT, 'houseid' TEXT,'fullName' TEXT, 'tuan' TEXT,'actIntro' TEXT, 'eDate' TEXT, 'saveDate' TEXT)"

#define GROUP @[ @"groupID", @"houseid",  @"fullName",@"tuan",@"actIntro", @"eDate", @"saveDate"];

//我的浏览历史记录
#define SQL_CreateHistoryTable @"CREATE TABLE IF NOT EXISTS History (ID INTEGER PRIMARY KEY AUTOINCREMENT, 'houseID' TEXT, 'fullName' TEXT, 'logoPath' TEXT, 'referencePrice' TEXT, 'avgPrice' TEXT,'district' TEXT,'tag'TEXT, 'saveDate' TEXT)"

#define HISTORY @[ @"houseID", @"fullName", @"logoPath", @"referencePrice", @"avgPrice",@"district",@"tag", @"saveDate"];

//我的收藏
#define SQL_CreateFavoriteTable @"CREATE TABLE IF NOT EXISTS Favorite (ID INTEGER PRIMARY KEY AUTOINCREMENT, 'houseID' TEXT, 'fullName' TEXT, 'logoPath' TEXT, 'referencePrice' TEXT, 'avgPrice' TEXT, 'opened' TEXT, 'buildAddress' TEXT, 'finishDate' TEXT, 'tag' TEXT, 'tuan' TEXT,'actIntro' TEXT, 'saveDate' TEXT)"

#define FAVORITES @[ @"houseID", @"fullName", @"logoPath", @"referencePrice", @"avgPrice", @"opened", @"buildAddress", @"finishDate", @"tag", @"tuan",@"actIntro",@"saveDate"];

typedef enum
{
    kUpdateActiveDB,
    kUpdateGroupBuyDB
}UpdateTabelTag;

@interface DBOperation : NSObject<HouseInfoRequestDelegate>
{
    sqlite3 *dataBase;
    HouseInfoRequest *houseRequest;
    UpdateTabelTag updateTag;
    NSString *downloadHouseID;
}

- (BOOL)createTableWithSQL:(NSString *)sql;
- (BOOL)insertDataWithSQL:(NSString *)sql;
- (BOOL)deleteDataWithSQL:(NSString *)sql;
- (BOOL)updateDataWithSQL:(NSString *)sql;
- (NSString *)selectDataWithSQL:(NSString *)sql;//查询某一条数据中的某一个字段时使用

//插入我的活动数据
-(BOOL)insertMyActive:(NSDictionary *)active;
-(BOOL)insertMyActivity:(ActivityInfo *)activity;
//已预约活动查询
-(NSArray *)selectActiveWithActiveID:(NSString *)activeID compareDate:(BOOL)compare;

//插入我的团购数据
-(BOOL)insertMyGroup:(NSDictionary *)group;
-(BOOL)insertMyGroupBuy:(GroupBuyInfo *)group;

//报名的团购查询
-(NSArray *)selectGroupWithGroupID:(NSString *)groupID compareDate:(BOOL)compare;

//浏览历史数据插入
-(BOOL)insertMyHistory:(NSDictionary *)house;
-(BOOL)insertMyHistoryHouse:(HouseInfo *)house;
//浏览历史记录查询
-(NSArray *)selectHistoryWithHouseID:(NSString *)houseID;
//删除浏览记录
-(BOOL)deleteHistoryWithRequire:(NSDictionary *)require;

//我的收藏数据
-(BOOL)insertMyFavoriteHouse:(HouseInfo *)house;
-(BOOL)insertMyFavorite:(NSDictionary *)favorite;
-(NSArray *)selectFavoriteWithHouseID:(NSString *)houseID;
-(BOOL)deleteMyFavoriteHouse:(HouseInfo *)house;

//共通
-(BOOL)insertDataWithTable:(NSString *)table Values:(NSDictionary *)value;
-(NSArray *)selectValuesWithRequires:(NSDictionary *)require Table:(NSString *)table Keys:(NSArray *)key OrderBy:(NSString *)order;
-(BOOL)deleteDataWithTable:(NSString *)table Where:(NSDictionary *)where;

+(DBOperation *) Instance;
+(id)allocWithZone:(NSZone *)zone;

@end
