//
//  TwitterHelper.h
//  Presence
//

#import <Foundation/Foundation.h>

// More methods will be added to this file as the Presence assignments progress.
// We've left it up to you to figure out how to use the return values.
// Try inspecting the dictionary and array contents using NSLog or the debugger.
// Read about Twitter's API at http://apiwiki.twitter.com/
// Read about json-framework at http://code.google.com/p/json-framework

// Define USE_TEST_SERVER as 1 to avoid rate-limiting while developing.
// Define it as 0 (or comment it out) to use real live data from Twitter.
// Read more at http://apiwiki.twitter.com/Rate-limiting
#define USE_TEST_SERVER 0
#define USE_CACHED_DATA 1

@interface TwitterHelper : NSObject {

}

// Returns a dictionary with info about the given username.
// This method is synchronous (it will block the calling thread).
+ (NSDictionary *)fetchInfoForUsername:(NSString *)username;

// Returns an array of status updates for the given username.
// This method is synchronous (it will block the calling thread).
+ (NSArray *)fetchTimelineForUsername:(NSString *)username;

// Returns YES if the status update succeeded, otherwise NO.
+ (BOOL)updateStatus:(NSString *)status forUsername:(NSString *)username withPassword:(NSString *)password;

// Returns an array of the users with the most recent status updates.
+ (NSArray *)fetchPublicTimeline;

// Returns status updates matching the query string.
+ (NSDictionary *)fetchSearchResultsForQuery:(NSString *)query;

+ (NSMutableArray *)homeDeUsername:(NSString *)username conPassword:(NSString *)contrasena yNumeroDeTweets:(int)numero;

+ (NSArray *)mentionsDeUsername:(NSString *)username conPassword:(NSString *)contrasena yNumeroDeTweets:(int)numero;

+ (NSArray *)directMessagesDeUsername:(NSString *)username conPassword:(NSString *)contrasena yNumeroDeTweets:(int)numero;

+ (NSDictionary *)compruebaUsername:(NSString *)username conPassword:(NSString *)contrasena;

@end
