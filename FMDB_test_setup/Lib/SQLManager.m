//
// Created by azu on 2013/05/09.
//


#import "SQLManager.h"
#import "FMDatabase.h"


@implementation SQLManager {

}
+ (int)schemaVersion:(FMDatabase *) fmDatabase {
    FMResultSet *resultSet = [fmDatabase executeQuery:@"PRAGMA user_version"];
    int version = 0;
    if ([resultSet next]) {
        version = [resultSet intForColumnIndex:0];
    }
    return version;
}

+ (void)setSchemaVersion:(FMDatabase *) fmDatabase version:(NSInteger) version {
    NSString *query = [NSString stringWithFormat:@"PRAGMA user_version = %d", version];
    [fmDatabase executeUpdate:query];
}
@end