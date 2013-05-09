//
// Created by azu on 2013/05/09.
//


#import <Foundation/Foundation.h>

@class FMDatabase;

@interface SQLManager : NSObject
+ (int)schemaVersion:(FMDatabase *) fmDatabase;

+ (void)setSchemaVersion:(FMDatabase *) fmDatabase version:(NSInteger) version;
@end