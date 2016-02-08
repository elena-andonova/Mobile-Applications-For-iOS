//
//  LocalDatabase.m
//  CultureGuideApp
//
//  Created by Elena Andonova on 2/8/16.
//  Copyright © 2016 EA. All rights reserved.
//

#import "LocalDatabase.h"

#import <sqlite3.h>

@implementation LocalDatabase
{
    sqlite3 *_db;
}

-(instancetype) init{
    if (self = [super init]) {
        NSString *sqliteDb = [[NSBundle mainBundle] pathForResource:@"FavoritePlaces" ofType:@"db"];
        if (sqlite3_open([sqliteDb UTF8String], &_db)) {
            NSLog(@"Error!");
        }
    }
    return self;
}

-(void) dealloc{
    if (_db != nil) {
        sqlite3_close(_db);
    }
}

+(instancetype) database{
    static LocalDatabase* databaseInstance;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        databaseInstance = [[LocalDatabase alloc] init];
    });
    
    return databaseInstance;
}

-(NSArray*) favoritePlaces{
    
    NSMutableArray *result = [NSMutableArray array];
    
    NSString *query = @"SELECT name FROM Places";
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare(_db, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char* nameChars = sqlite3_column_text(statement, 0);
            NSString *name = [NSString stringWithUTF8String:nameChars];
            NSLog(@"Name: %@", name);
            //[result addObject:obj];
        }
    }
    else {
        NSLog(@"Something ugly happend...");
    }
    
    return [NSArray array];
}

-(void)addFavoritePlace: (Place*) place{
    NSString *insertSQL = [NSString stringWithFormat:@"INSERT into Places (id, name, placeDescription, location) VALUES (\"%@\", \"%@\", \"%@\", \"%@\")",
                       place.id, place.name, place.placeDescription, place.location];
    
    NSString *dbPath = [[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:@"movieData.sqlite"];
    const char *dbpath = [dbPath UTF8String];
    sqlite3 *contactDB;
    
    sqlite3_stmt *statement;

    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        //NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO myMovies (movieName) VALUES (\"%@\")", txt];
        
        const char *insert_stmt = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(contactDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            sqlite3_bind_text(statement, 0, [place.id UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 1, [place.name UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 2, [place.placeDescription UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 3, [place.location UTF8String], -1, SQLITE_TRANSIENT);
            //sqlite3_bind_text(statement, 4, [place.geoLocation UTF8String], -1, SQLITE_TRANSIENT);
            
        } else {
            NSLog(@"error");
        }
        sqlite3_finalize(statement);
        sqlite3_close(contactDB);
    }
}

@end
