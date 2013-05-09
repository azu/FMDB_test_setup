//
// Created by azu on 2013/05/07.
//


#import "Kiwi.h"
#import "FMDatabase.h"
#import "SQLManager.h"

#define DATA_BASE_FILE_PATH @"/tmp/tmp.sqlite"

@interface SQLManagerSpec : KWSpec

@end

@implementation SQLManagerSpec

+ (void)buildExampleGroups {
    describe(@"SQLManager", ^{
        __block FMDatabase *fmDatabase;
        beforeEach(^{
            fmDatabase = [self database];
            [fmDatabase open];
        });
        afterEach(^{
            [fmDatabase close];
            [self cleanup];
        });
        describe(@"#schemaVersion", ^{
            context(@"When default", ^{
                it(@"return 0 which is default value", ^{
                    int version = [SQLManager schemaVersion:fmDatabase];
                    [[theValue(version) should] equal:theValue(0)];
                });
            });
            context(@"When set version=1", ^{
                beforeEach(^{
                    [SQLManager setSchemaVersion:fmDatabase version:1];
                });
                it(@"return 1", ^{
                    int version = [SQLManager schemaVersion:fmDatabase];
                    [[theValue(version) should] equal:theValue(1)];
                });

            });
        });
        describe(@"#setSchemaVersion", ^{
            it(@"Call executeUpdate:", ^{
                // create mock
                id fmDatabaseMock = [KWMock nullMockForClass:[FMDatabase class]];
                [[fmDatabaseMock should] receive:@selector(executeUpdate:)];

                [SQLManager setSchemaVersion:fmDatabaseMock version:1];
            });
        });
    });
}

+ (FMDatabase *)database {
    FMDatabase *fmDatabase = [FMDatabase databaseWithPath:DATA_BASE_FILE_PATH];
    return fmDatabase;
}

+ (void)cleanup {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:DATA_BASE_FILE_PATH]) {
        return;
    }
    NSError *error = nil;
    [fileManager removeItemAtPath:DATA_BASE_FILE_PATH error:&error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
}
@end