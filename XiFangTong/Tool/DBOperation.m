//
//  DBOperation.m
//  SQLiteTest
//
//  Created by iss on 6/19/13.
//  Copyright (c) 2013 iss. All rights reserved.
//

#import "DBOperation.h"
#import "HouseInfo.h"

#define DBNAME           @"HouseDataBase.sqlite"
#define FavoriteDBName   @"Favorite"
#define HistoryDBName    @"History"
#define GroupBuyDBName   @"Groups"
#define ActivityDBName   @"Actives"

@implementation DBOperation

- (BOOL)openDatabase
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DBNAME];

    if (sqlite3_open([database_path UTF8String], &dataBase) != SQLITE_OK) {
        sqlite3_close(dataBase);
        return NO;
    }else{
        return YES;
    }
}

- (BOOL)createTableWithSQL:(NSString *)sql
{
    if ([self openDatabase]) {
        char *errorMsg = nil;
        int exec_result = sqlite3_exec(dataBase, [sql UTF8String], nil, nil, &errorMsg);
        if (exec_result == SQLITE_OK) {
            [self closeDatabase];
            return YES;
        } else {
            NSLog(@"创建失败");
            [self closeDatabase];
            return NO;
        }
    }else{
        NSLog(@"数据库打开失败 : %@",sql);
        return NO;
    }
}

- (BOOL)insertDataWithSQL:(NSString *)sql
{
    if ([self openDatabase]) {
        char *errorMsg = nil;
        int exec_result = sqlite3_exec(dataBase, [sql UTF8String], nil, nil, &errorMsg);
        if (exec_result == SQLITE_OK) {
            [self closeDatabase];
            return YES;
        } else {
            NSLog(@"插入失败");
            [self closeDatabase];
            return NO;
        }
    }else{
        NSLog(@"数据库打开失败 : %@",sql);
        return NO;
    }
}

//查询某一条数据中的某一个字段时使用
- (NSString *)selectDataWithSQL:(NSString *)sql
{
    if ([self openDatabase]) {
        sqlite3_stmt * stmt;
        NSString *resultString = [[NSString alloc] init];
        int result = sqlite3_prepare_v2(dataBase, [sql UTF8String], -1, &stmt, nil);
        
        if (result == SQLITE_OK) {
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                resultString = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
            }
            [self closeDatabase];
            return resultString;
        } else {
            NSLog(@"查询失败");
            [self closeDatabase];
            return nil;
        }
    }else{
        NSLog(@"数据库打开失败");
        return nil;
    }
}

- (BOOL)updateDataWithSQL:(NSString *)sql
{
    if ([self openDatabase]) {
//        char *errorMsg = nil;
        sqlite3_stmt * stmt;
        int exec_result = sqlite3_prepare_v2(dataBase, [sql UTF8String], -1, &stmt, nil);
//        int exec_result = sqlite3_exec(dataBase, [sql UTF8String], nil, nil, &errorMsg);
        if (exec_result == SQLITE_OK) {
            exec_result = sqlite3_step(stmt);
            sqlite3_finalize(stmt);
             if (exec_result == SQLITE_ERROR) {
                 [self closeDatabase];
                 return NO;
             }
             else{
                 [self closeDatabase];
                 return YES;
             }
            
        } else {
            NSLog(@"更新失败");
            [self closeDatabase];
            return NO;
        }
    }else{
        NSLog(@"数据库打开失败 : %@",sql);
        return NO;
    }
}

- (BOOL)deleteDataWithSQL:(NSString *)sql
{
    if ([self openDatabase]) {
        char *errorMsg = nil;
        int exec_result = sqlite3_exec(dataBase, [sql UTF8String], nil, nil, &errorMsg);
        if (exec_result == SQLITE_OK) {
            [self closeDatabase];
            return YES;
        } else {
            NSLog(@"删除失败");
            [self closeDatabase];
            return NO;
        }
    }else{
        NSLog(@"数据库打开失败 : %@",sql);
        return NO;
    }
}
#pragma mark -
#pragma mark request
-(void)houseInfoRequestSuccess:(HouseInfo *)houseInfo
{
    NSDictionary *require = [NSDictionary dictionaryWithObject:houseInfo.houseID forKey:@"houseid"];
    NSArray *keys = @[@"fullName",@"tuan",@"actIntro"];
    NSArray *values = [NSArray arrayWithObjects:houseInfo.shortName,houseInfo.tuan,houseInfo.actIntro, nil];
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:values forKeys:keys];
    if (updateTag == kUpdateActiveDB) {

        [self updateValuesWithRequires:require Table:ActivityDBName ValuesDic:dic];
    }
    else{
        [self updateValuesWithRequires:require Table:GroupBuyDBName ValuesDic:dic];
    }
}
-(void)houseInfoRequestFailed:(NSString *)message
{
    if (downloadHouseID.length != 0){
        [houseRequest requestHouseInfoWithID:downloadHouseID];
    }
}
#pragma mark -
#pragma mark 活动
//插入我的活动数据
-(BOOL)insertMyActive:(NSDictionary *)active{
    
    //数据存在check 
    NSMutableDictionary *require = [[NSMutableDictionary alloc] init];
    [require setValue:[NSString stringWithFormat:@" = '%@' ",[active valueForKey:@"activeID"]] forKey:@"activeID"];
    NSArray *arr = (NSArray *)ACTIVE;
    NSArray *exitActive = [self selectValuesWithRequires:require Table:@"actives" Keys:arr OrderBy:nil];
    if ([exitActive count]>0) {
        return FALSE;
    }
    return [self insertDataWithTable:ActivityDBName Values:active];
}
-(BOOL)insertMyActivity:(ActivityInfo *)activity
{
    if (activity == nil) {
        return FALSE;
    }
    else{
        //@"activeID", @"houseid", @"fullName",@"tuan",@"actIntro",@"dateEnd", @"saveDate"
        updateTag = kUpdateActiveDB;
        downloadHouseID = activity.houseid;
        NSString *houseid = activity.houseid;
        if (houseid.length == 0|| houseid == nil) {
            houseid = @"";
        }
        
        NSArray *a = (NSArray *)ACTIVE;
        NSMutableArray *keys = [NSMutableArray arrayWithArray:a];
        [keys removeLastObject];
        if (activity.dtime.length == 0) {
            activity.dtime = @"";
        }
        NSString *housename = activity.houseShortName;
        if (housename.length == 0 || housename == nil) {
            housename = @"";
        }
        NSString *activityID = activity.activityID;
        if (activityID.length == 0) {
            activityID = @"";
        }
        NSString *info = activity.daoyu;
        if (info.length == 0) {
            info = @"";
        }
        NSString *dtime= activity.dtime;
        if (dtime.length == 0 || dtime == nil) {
            dtime = @"";
        }
        NSArray *values = [NSArray arrayWithObjects:activityID,houseid,housename, @"",info,dtime,nil];
        return [self insertDataWithTable:ActivityDBName Values:[NSDictionary dictionaryWithObjects:values forKeys:keys]];
    }

}
//已预约活动查询
-(NSArray *)selectActiveWithActiveID:(NSString *)activeID compareDate:(BOOL)compare{
    
    NSMutableDictionary *require = [[NSMutableDictionary alloc] initWithCapacity:0];
//    NSDate *nowDate = [NSDate date];
//    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
//    [dateformatter setDateFormat:@"yyyy/MM/dd"];
//    [require setValue:[NSString stringWithFormat:@" > '%@' ",[dateformatter stringFromDate:nowDate]] forKey:@"dateEnd"];
    if ([activeID length]>0) {
        [require setValue:[NSString stringWithFormat:@" = '%@' ",activeID] forKey:@"activeID"];
    }
    
    NSArray *arr = (NSArray *)ACTIVE;
    NSArray *results = [self selectValuesWithRequires:require Table:ActivityDBName Keys:arr OrderBy:@"saveDate"];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    //@"activeID", @"houseid", @"fullName",@"tuan",@"actIntro",@"dateEnd", @"saveDate"
    for (NSDictionary *dic in results) {
        if (compare) {
            NSString *time = [[[dic objectForKey:@"dateEnd"] componentsSeparatedByString:@"T"] objectAtIndex:0];
            if ([Tool compareDateIsLaterThanNowDate:time]) {
                ActivityInfo *activity = [[ActivityInfo alloc] init];
                activity.activityID = [dic objectForKey:@"activeID"];
                activity.houseid = [dic objectForKey:@"houseid"];
                activity.houseShortName = [dic objectForKey:@"fullName"];
                activity.houseTuan = [dic objectForKey:@"tuan"];
                activity.daoyu = [dic objectForKey:@"actIntro"];
                
                activity.dtime = [dic objectForKey:@"dateEnd"];
                
                [array addObject:activity];
                if (activity.houseFullName.length == 0 || activity.houseActIntro.length == 0) {
                    updateTag = kUpdateActiveDB;
                    [houseRequest requestHouseInfoWithID:activity.houseid];
                }
            }
        }
        else{
            ActivityInfo *activity = [[ActivityInfo alloc] init];
            activity.activityID = [dic objectForKey:@"activeID"];
            activity.houseid = [dic objectForKey:@"houseid"];
            activity.houseShortName = [dic objectForKey:@"fullName"];
            activity.houseTuan = [dic objectForKey:@"tuan"];
            activity.daoyu = [dic objectForKey:@"actIntro"];
            activity.dtime = [dic objectForKey:@"dateEnd"];
            [array addObject:activity];           
        }
   }
    return array;
}

#pragma mark 团购
//插入我的团购数据
-(BOOL)insertMyGroup:(NSDictionary *)group{
    
    //数据存在check 
    NSMutableDictionary *require = [[NSMutableDictionary alloc] init];
    [require setValue:[NSString stringWithFormat:@" = '%@' ",[group valueForKey:@"groupID"]] forKey:@"groupID"];
    NSArray *arr = (NSArray *)GROUP;
    NSArray *exitActive = [self selectValuesWithRequires:require Table:GroupBuyDBName Keys:arr OrderBy:nil];
    if ([exitActive count]>0) {
        return FALSE;
    }
    return [self insertDataWithTable:GroupBuyDBName Values:group];
}
-(BOOL)insertMyGroupBuy:(GroupBuyInfo *)group
{
    if (group == nil) {
        return FALSE;
    }
    else{
        updateTag = kUpdateGroupBuyDB;
        downloadHouseID = group.houseID;
        NSString *houseid = group.houseID;
        if (downloadHouseID.length != 0) {
//            [houseRequest requestHouseInfoWithID:group.houseID];
        }
        else{
            houseid = @"";
        }
        NSArray *a = (NSArray *)GROUP;
        NSMutableArray *keys = [NSMutableArray arrayWithArray:a];
        [keys removeLastObject];
        if (group.eDate.length == 0) {
            group.eDate = @"";
        }
        NSString *groupID = group.groupBuyID;
        if (groupID.length == 0) {
            groupID = @"";
        }
        NSString *info = group.houseAgio;
        if (info.length == 0) {
            info = @"";
        }
        NSString *housename = group.houseShortName;
        if (housename.length == 0 || housename == nil) {
            housename = @"";
        }
        NSString *edate = group.eDate;
        if (edate.length == 0 || edate == nil) {
            edate = @"";
        }
        //@"groupID", @"houseid",  @"fullName",@"tuan",@"actIntro", @"eDate", @"saveDate"
        NSArray *values = [NSArray arrayWithObjects:groupID,houseid,housename, info,@"",edate, nil];
        
        return [self insertDataWithTable:GroupBuyDBName Values:[NSDictionary dictionaryWithObjects:values forKeys:keys]];
    }
}
//已预约团购查询
-(NSArray *)selectGroupWithGroupID:(NSString *)groupID compareDate:(BOOL)compare
{
    
    NSMutableDictionary *require = [[NSMutableDictionary alloc] initWithCapacity:0];
//    NSDate *nowDate = [NSDate date];
//    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
//    [dateformatter setDateFormat:@"yyyy-MM-dd"];
//    [require setValue:[NSString stringWithFormat:@" > '%@' ",[dateformatter stringFromDate:nowDate]] forKey:@"dateEnd"];
    if ([groupID length]>0) {
        [require setValue:[NSString stringWithFormat:@" = '%@' ",groupID] forKey:@"houseid"];
    }
    NSArray *arr = (NSArray *)GROUP;
    NSArray *results = [self selectValuesWithRequires:require Table:GroupBuyDBName Keys:arr OrderBy:@"saveDate"];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dic in results) {
        if (compare) {
            NSString *time = [[[dic objectForKey:@"eDate"] componentsSeparatedByString:@"T"] objectAtIndex:0];
            if ([Tool compareDateIsLaterThanNowDate:time]) {
                GroupBuyInfo *group = [[GroupBuyInfo alloc] init];
                group.groupBuyID = [dic objectForKey:@"groupID"];
                group.houseID = [dic objectForKey:@"houseid"];
                group.houseShortName = [dic objectForKey:@"fullName"];
                group.houseAgio = [dic objectForKey:@"tuan"];
                group.houseActIntro = [dic objectForKey:@"actIntro"];
                group.eDate = [dic objectForKey:@"eDate"];
                [array addObject:group];
                if (group.houseFullName.length == 0 || group.houseTuan.length == 0) {
                    updateTag = kUpdateGroupBuyDB;
                    [houseRequest requestHouseInfoWithID:group.houseID];
                }
            } 
        }
        else{
            GroupBuyInfo *group = [[GroupBuyInfo alloc] init];
            group.groupBuyID = [dic objectForKey:@"groupID"];
            group.houseID = [dic objectForKey:@"houseid"];
            group.houseShortName = [dic objectForKey:@"fullName"];
            group.houseAgio = [dic objectForKey:@"tuan"];
            group.houseActIntro = [dic objectForKey:@"actIntro"];
            group.eDate = [dic objectForKey:@"eDate"];
            [array addObject:group];
        }
    }
    return array;
}
#pragma mark 浏览记录
-(BOOL)insertMyHistory:(NSDictionary *)house{
    
    //数据存在check houseID
    NSMutableDictionary *require = [[NSMutableDictionary alloc] init];
    [require setValue:[NSString stringWithFormat:@" = '%@' ",[house valueForKey:@"houseID"]] forKey:@"houseID"];
    NSArray *arr = (NSArray *)HISTORY;
    NSArray *exitActive = [self selectValuesWithRequires:require Table:@"History" Keys:arr OrderBy:nil];
    if ([exitActive count]>0) {
        return FALSE;
    }
    return [self insertDataWithTable:HistoryDBName Values:house];
}
-(BOOL)insertMyHistoryHouse:(HouseInfo *)house
{
    if (house == nil) {
        return FALSE;
    }
    else{
        NSArray *houseList = [self selectHistoryWithHouseID:@""];
        if (houseList.count >= 10) {
            for (int i = 9; i<houseList.count; i++) {
                HouseInfo *dHouse = [houseList objectAtIndex:i];
                
                [self deleteHistoryWithRequire:[NSDictionary dictionaryWithObject:dHouse.houseID forKey:@"houseID"]];
            }
        }
        NSArray *a = (NSArray *)HISTORY;
        NSMutableArray *keys = [NSMutableArray arrayWithArray:a];
        [keys removeLastObject];
        NSArray *values = [NSArray arrayWithObjects:house.houseID,house.shortName,house.logoPath,house.referencePrice,house.avgPrice,house.districtID,house.tag, nil];
        
        return [self insertDataWithTable:HistoryDBName Values:[NSDictionary dictionaryWithObjects:values forKeys:keys]];
    }
}
-(NSArray *)selectHistoryWithHouseID:(NSString *)houseID{

    NSMutableDictionary *require = [[NSMutableDictionary alloc] initWithCapacity:0];
    if ([houseID length]>0) {
        [require setValue:[NSString stringWithFormat:@" = '%@' ",houseID] forKey:@"houseID"];
    }
    NSArray *arr = (NSArray *)HISTORY;
    
    NSArray *results = [self selectValuesWithRequires:require Table:HistoryDBName Keys:arr OrderBy:@"saveDate"];
    NSMutableArray *array = [[NSMutableArray alloc] init];
   
    for (NSDictionary *dic in results) {
        HouseInfo *house = [[HouseInfo alloc] init];
        house.houseID = [dic objectForKey:@"houseID"];
        house.referencePrice = [dic objectForKey:@"referencePrice"];
        house.shortName = [dic objectForKey:@"fullName"];
        house.logoPath = [dic objectForKey:@"logoPath"];
        house.avgPrice = [dic objectForKey:@"avgPrice"];
        house.districtID = [dic objectForKey:@"district"];
        house.tag = [dic objectForKey:@"tag"];
        [array addObject:house];
    }
    return array;    
}

-(BOOL)deleteHistoryWithRequire:(NSDictionary *)require{
    return [self deleteDataWithTable:HistoryDBName Where:require];
}

#pragma mark 我的收藏
-(BOOL)insertMyFavoriteHouse:(HouseInfo *)house{
    if (house == nil) {
        return FALSE;
    }
    else{
        NSArray *a = (NSArray *)FAVORITES;
        NSMutableArray *keys = [NSMutableArray arrayWithArray:a];
        [keys removeLastObject];
        NSArray *values = [NSArray arrayWithObjects:house.houseID,house.shortName,house.logoPath,house.referencePrice,house.avgPrice,house.opened,house.buildAddress,house.finishDate,house.tag,house.tuan,house.actIntro, nil];
        return [self insertDataWithTable:FavoriteDBName Values:[NSDictionary dictionaryWithObjects:values forKeys:keys]];
    }
}
-(BOOL)insertMyFavorite:(NSDictionary *)favorite{
    //数据存在check houseID
    NSMutableDictionary *require = [[NSMutableDictionary alloc] init];
    [require setValue:[NSString stringWithFormat:@" = '%@' ",[favorite valueForKey:@"houseID"]] forKey:@"houseID"];
    NSArray *arr = (NSArray *)FAVORITES;
    NSArray *exitActive = [self selectValuesWithRequires:require Table:FavoriteDBName Keys:arr OrderBy:nil];
    if ([exitActive count]>0) {
        return FALSE;
    }
    return [self insertDataWithTable:FavoriteDBName Values:favorite];

}

-(NSArray *)selectFavoriteWithHouseID:(NSString *)houseID{
    
    NSMutableDictionary *require = [[NSMutableDictionary alloc] initWithCapacity:0];
    if ([houseID length]>0) {
        [require setValue:[NSString stringWithFormat:@" = '%@' ",houseID] forKey:@"houseID"];
    }
    NSArray *arr = (NSArray *)FAVORITES;
//    return [self selectValuesWithRequires:require Table:FavoriteDBName Keys:arr OrderBy:@"saveDate"];
    
    // @"houseID", @"fullName", @"logoPath", @"referencePrice", @"avgPrice", @"opened", @"buildAddress", @"finishDate", @"tag", @"intro",@"saveDate"
    NSArray *results = [self selectValuesWithRequires:require Table:FavoriteDBName Keys:arr OrderBy:@"saveDate"];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in results) {
        HouseInfo *house = [[HouseInfo alloc] init];
        house.houseID = [dic objectForKey:@"houseID"];
        house.referencePrice = [dic objectForKey:@"referencePrice"];
        house.shortName = [dic objectForKey:@"fullName"];
        house.logoPath = [dic objectForKey:@"logoPath"];
        house.avgPrice = [dic objectForKey:@"avgPrice"];
        house.opened = [dic objectForKey:@"opened"];
        house.buildAddress = [dic objectForKey:@"buildAddress"];
        house.finishDate = [dic objectForKey:@"finishDate"];
        house.tag = [dic objectForKey:@"tag"];
        house.tuan = [dic objectForKey:@"tuan"];
        house.actIntro = [dic objectForKey:@"actIntro"];

        [array addObject:house];
    }
    return array;
}
-(BOOL)deleteMyFavoriteHouse:(HouseInfo *)house
{
    return  [self deleteDataWithTable:FavoriteDBName Where:[NSDictionary dictionaryWithObject:house.houseID forKey:@"houseID"]];
}
#pragma mark 共通方法
//共通数据
-(BOOL)insertDataWithTable:(NSString *)table Values:(NSDictionary *)value{
    //数据存在check
    
    NSMutableString *keys = [[NSMutableString alloc] init];
    NSMutableString *values = [[NSMutableString alloc] init];
    
    NSEnumerator *enumerator = [value keyEnumerator];
    for (id key in enumerator) {
        [keys appendFormat:@" %@,",key];
        [values appendFormat:@" '%@',",[value valueForKey:key]];
    }
    [keys appendString:@" saveDate "];
    [values appendFormat:@" '%@' ",[NSDate date]];
    
    NSString *SQL = [NSString stringWithFormat:@"INSERT INTO %@ (%@) VALUES (%@)",table,keys,values];
    
    return [self insertDataWithSQL:SQL];

}

-(NSArray *)selectValuesWithRequires:(NSDictionary *)require Table:(NSString *)table Keys:(NSArray *)key OrderBy:(NSString *)order{
    
    //组成SQL
    NSMutableString *keys = [[NSMutableString alloc] init];
    for (NSString *str in key) {        
        [keys appendFormat:@" %@,",str];
    }
    [keys setString:[keys substringToIndex:[keys length]-1]];
    //[keys substringToIndex:[keys length]-1];
    
    NSMutableString *wheres = [[NSMutableString alloc] init];
    if ((require != nil) && ([require count]>0)) {
        [wheres appendString:@" WHERE "];
        NSEnumerator *enumerator = [require keyEnumerator];
        id requires;
        while (requires = [enumerator nextObject]) {
            [wheres appendFormat:@" %@ %@ AND",requires,[require valueForKey:requires]];
        }
        [wheres setString:[wheres substringToIndex:[wheres length]-3] ];
    }
    
    if ((order != nil) && ([order length]>0)) {
        [wheres appendFormat:@" ORDER BY %@ DESC ",order];
    }
    
    NSString *SQL = [NSString stringWithFormat:@" SELECT %@ FROM %@ %@",keys,table,wheres];
    
    if ([self openDatabase]) {
        sqlite3_stmt * stmt;
        NSMutableArray *resultDataList = [[NSMutableArray alloc] init];
        int result = sqlite3_prepare_v2(dataBase, [SQL UTF8String], -1, &stmt, nil);
        if (result == SQLITE_OK) {
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                NSMutableDictionary *resultData = [[NSMutableDictionary alloc] init];
                for (int i = 0; i < sqlite3_column_count(stmt); i++) {
                    [resultData setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, i)] forKey:[NSString stringWithUTF8String:(char *)sqlite3_column_name(stmt, i)]];
                }
                [resultDataList addObject:resultData];
            }
            [self closeDatabase];
            return resultDataList;
        } else {
            NSLog(@"查询失败");
            [self closeDatabase];
            return nil;
        }
    } else {
        NSLog(@"数据库打开失败");
        return nil;
    }
}
-(BOOL)updateValuesWithRequires:(NSDictionary *)require Table:(NSString *)table ValuesDic:(NSDictionary *)dic
{
    NSMutableString *wheres = [[NSMutableString alloc] init];
    if ((require !=nil) && ([require count]>0)) {
        [wheres appendString:@" WHERE "];
        
        NSEnumerator *enumerator = [require keyEnumerator];
        id requires;
        while (requires = [enumerator nextObject]) {
            [wheres appendFormat:@" %@ = '%@' AND",requires,[require valueForKey:requires]];
        }
        [wheres setString:[wheres substringToIndex:[wheres length]-3] ];
    }
   
    NSMutableString *keyValue = [[NSMutableString alloc] init];
    if ((dic !=nil) && ([dic count]>0)) {
        
        NSEnumerator *enumerator = [dic keyEnumerator];
        id kv;
        while (kv = [enumerator nextObject]) {
            [keyValue appendFormat:@" %@ = '%@' ,",kv,[dic valueForKey:kv]];
        }
        [keyValue setString:[keyValue substringToIndex:[keyValue length]-1] ];
    }
    
    NSString *SQL = [NSString stringWithFormat:@"UPDATE %@ SET %@ %@",table,keyValue,wheres];
    return [self updateDataWithSQL:SQL];
}
-(BOOL)deleteDataWithTable:(NSString *)table Where:(NSDictionary *)where{
    NSMutableString *wheres = [[NSMutableString alloc] init];
    if ((where !=nil) && ([where count]>0)) {
        [wheres appendString:@" WHERE "];
        
        NSEnumerator *enumerator = [where keyEnumerator];
        id requires;
        while (requires = [enumerator nextObject]) {
            [wheres appendFormat:@" %@ = '%@' AND",requires,[where valueForKey:requires]];
        }
        [wheres setString:[wheres substringToIndex:[wheres length]-3] ];
    }    
    NSString *SQL = [NSString stringWithFormat:@"DELETE FROM %@ %@ ",table,wheres];
    
    return [self deleteDataWithSQL:SQL];
}

- (void)closeDatabase
{
    sqlite3_close(dataBase);
}
- (BOOL)checkDatabaseExist:(NSString *)dbName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:DBNAME];
    NSString *subPath = [documentPath stringByAppendingPathComponent:dbName];
    NSFileManager *fileManger = [NSFileManager defaultManager];
    if ([fileManger fileExistsAtPath:subPath]) {
        return YES;
    }
    return NO;
    
}
#pragma mark -
#pragma mark init
-(void)initWithCustom
{
    houseRequest = [[HouseInfoRequest alloc] init];
    [houseRequest setDelegate:self];
    
    if (![self checkDatabaseExist:FavoriteDBName]) {
        [self createTableWithSQL:SQL_CreateFavoriteTable];
    }
    if (![self createTableWithSQL:SQL_CreateHistoryTable]) {
        [self createTableWithSQL:SQL_CreateFavoriteTable];
    }
    if (![self createTableWithSQL:SQL_CreateGroupTable]) {
        [self createTableWithSQL:SQL_CreateFavoriteTable];
    }
    if (![self createTableWithSQL:SQL_CreateActiveTable]) {
        [self createTableWithSQL:SQL_CreateFavoriteTable];
    }
}
static DBOperation * instance = nil;
+(DBOperation *)Instance
{
    @synchronized(self)
    {
        if (nil == instance)
        {
            [[self alloc] initWithCustom];
        }
    }
    return instance;
}
+(id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (instance == nil) {
            instance = [super allocWithZone:zone];
            return instance;
        }
    }
    return nil;
}

@end
