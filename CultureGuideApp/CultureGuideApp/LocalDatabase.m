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
    
    NSString *query = @"SELECT * FROM Places";
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare(_db, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {

            char* placeIdChars = sqlite3_column_text(statement, 0);
            NSString *placeId = [NSString stringWithUTF8String:placeIdChars];
            
            char* nameChars = sqlite3_column_text(statement, 1);
            NSString *name = [NSString stringWithUTF8String:nameChars];
            
            char* placeDescrChars = sqlite3_column_text(statement, 2);
            NSString *placeDescr = [NSString stringWithUTF8String:placeDescrChars];
            
            char* locationChars = sqlite3_column_text(statement, 3);
            NSString *location = [NSString stringWithUTF8String:locationChars];
            
            char* geoLocLatChars = sqlite3_column_text(statement, 4);
            NSString *geoLocLat = [NSString stringWithUTF8String:geoLocLatChars];
            
            char* geoLocLongChars = sqlite3_column_text(statement, 5);
            NSString *geoLocLong = [NSString stringWithUTF8String:geoLocLongChars];
            
            NSDictionary *geoLocDict = @{
                                         @"latitude": geoLocLat,
                                         @"longitude":geoLocLong
                                         };
            
            Place *favPlace = [[Place alloc] initWithName:name];
            favPlace.id = placeId;
            favPlace.placeDescription = placeDescr;
            favPlace.location = location;
            favPlace.geoLocation = geoLocDict;
            
            NSLog(@"Name: %@", name);
            [result addObject:favPlace];
        }
    }
    else {
        NSLog(@"Something ugly happend...");
    }
    
    return result;
}

//, placeDescription, location, geoLocationLatitude, geoLocationLogitude

//(id, name, placeDescription, location, geoLocationLatitude, geoLocationLogitude)
-(void)addFavoritePlace: (Place*) place{
    NSString *geoLocLatQueryStr = [NSString stringWithFormat:@"%@",[place.geoLocation objectForKey:@"latitude"]];
    NSString *geoLocLongQueryStr = [NSString stringWithFormat:@"%@",[place.geoLocation objectForKey:@"longitude"]];
    
    NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO Places VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")",
                       place.id, place.name, place.placeDescription, place.location, geoLocLatQueryStr, geoLocLongQueryStr];
    
    NSString *dbPath = [[NSBundle mainBundle] pathForResource:@"FavoritePlaces" ofType:@"db"];
//[[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:@"FavoritePlaces.db"];
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
            sqlite3_bind_text(statement, 4, [geoLocLatQueryStr UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 5, [geoLocLongQueryStr UTF8String], -1, SQLITE_TRANSIENT);
            NSLog(@"Added..");
            
        } else {
            NSLog(@"error");
            NSLog(@"error: %s", sqlite3_errmsg(contactDB));
        }
        sqlite3_finalize(statement);
        sqlite3_close(contactDB);
        NSArray *arr = [NSArray arrayWithArray:[self favoritePlaces]];
    }
}

@end
