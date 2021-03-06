//
//  TwitterHelper.m
//  Presence
//

#import "TwitterHelper.h"
#import "JSON.h"

NSString *const TwitterHostname = @"twitter.com";
NSString *const TwitterCachedDataHostname = @"www.stanford.edu/class/cs193p/presence-test";

@implementation TwitterHelper

+ (BOOL)canUseCachedDataForUsername:(NSString *)username
{
    static NSArray *cachedUsernames = nil;
    if (!cachedUsernames) {
        cachedUsernames = [[NSArray alloc] initWithObjects:@"stevewozniak", @"THE_REAL_SHAQ", @"williamshatner", nil];
    }
    return [cachedUsernames containsObject:username];
}

+ (NSString *)twitterHostnameForUsername:(NSString *)username
{
    if ([self canUseCachedDataForUsername:username]) {
        return TwitterCachedDataHostname;
    } else {
        return TwitterHostname;
    }
}

+ (id)fetchJSONValueForURL:(NSURL *)url
{
    NSString *jsonString = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    id jsonValue = [jsonString JSONValue];
    
	[jsonString release];
    
    return jsonValue;
}

+ (NSDictionary *)fetchInfoForUsername:(NSString *)username
{
    NSString *urlString = [NSString stringWithFormat:@"http://%@/users/show/%@.json", [self twitterHostnameForUsername:username], username];
    NSURL *url = [NSURL URLWithString:urlString];
    return [self fetchJSONValueForURL:url];
}

+ (NSArray *)fetchTimelineForUsername:(NSString *)username
{
    NSString *urlString = [NSString stringWithFormat:@"http://%@/statuses/user_timeline/%@.json", [self twitterHostnameForUsername:username], username];
    NSURL *url = [NSURL URLWithString:urlString];
    return [self fetchJSONValueForURL:url];
}

+ (BOOL)updateStatus:(NSString *)status forUsername:(NSString *)username withPassword:(NSString *)password
{
    if (!username || !password) {
        return NO;
    }
	
    NSString *post = [NSString stringWithFormat:@"status=%@", [status stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@@%@/statuses/update.json", username, password, TwitterHostname]];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLResponse *response;
    NSError *error;
	// We should probably be parsing the data returned by this call, for now just check the error.
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    return (error == nil);
}

+ (NSArray *)fetchPublicTimeline
{
    NSString *urlString = [NSString stringWithFormat:@"http://%@/statuses/public_timeline.json", TwitterHostname];
	NSURL *url = [NSURL URLWithString:urlString];
    return [self fetchJSONValueForURL:url];
    
}

+ (NSDictionary *)fetchSearchResultsForQuery:(NSString *)query
{
    // Sanitize the query string.
	query = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *urlString = [NSString stringWithFormat:@"http://search.twitter.com/search.json?q=%@", query];
    NSURL *url = [NSURL URLWithString:urlString];
    
    return [self fetchJSONValueForURL:url];
    
}

+ (NSMutableArray *)homeDeUsername:(NSString *)username conPassword:(NSString *)contrasena yNumeroDeTweets:(int)numero{
	if(numero>199){
		numero=199;
	}
	NSString *cadenaDeURL=[NSString stringWithFormat:@"http://%@:%@@twitter.com/statuses/friends_timeline.json?count=%d",username,contrasena,numero];
	NSURL *url=[NSURL URLWithString:cadenaDeURL];
	
	return [self fetchJSONValueForURL:url];
}

+ (NSArray *)mentionsDeUsername:(NSString *)username conPassword:(NSString *)contrasena yNumeroDeTweets:(int)numero{
	if(numero>199){
		numero=199;
	}
	NSString *cadenaDeURL=[NSString stringWithFormat:@"http://%@:%@@twitter.com/statuses/mentions.json?count=%d",username,contrasena,numero];
	NSURL *url=[NSURL URLWithString:cadenaDeURL];
	
	return [self fetchJSONValueForURL:url];
}

+ (NSArray *)directMessagesDeUsername:(NSString *)username conPassword:(NSString *)contrasena yNumeroDeTweets:(int)numero{
	if(numero>199){
		numero=199;
	}
	NSString *cadenaDeURL=[NSString stringWithFormat:@"http://%@:%@@twitter.com/direct_messages.json?count=%d",username,contrasena,numero];
	NSURL *url=[NSURL URLWithString:cadenaDeURL];
	
	return [self fetchJSONValueForURL:url];
}

+ (NSDictionary *)compruebaUsername:(NSString *)username conPassword:(NSString *)contrasena{
	NSString *cadenaDeURL=[NSString stringWithFormat:@"http://%@:%@@twitter.com/account/verify_credentials.json",username,contrasena];
	NSURL *url=[NSURL URLWithString:cadenaDeURL];
	return [self fetchJSONValueForURL:url];
}

@end


//#import "TwitterHelper.h"
//#import "JSON.h"
//
//@implementation TwitterHelper
//
//+ (NSString *)twitterHostname
//{
//#if USE_TEST_SERVER
//	return @"www.stanford.edu/class/cs193p/presence-test";
//#else
//	return @"twitter.com";
//#endif
//}
//
//+ (id)fetchJSONValueForURL:(NSURL *)url
//{
//    NSString *jsonString = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
//    
//    id jsonValue = [jsonString JSONValue];
//    
//	[jsonString release];
//    
//    return jsonValue;
//}
//
//+ (NSDictionary *)fetchInfoForUsername:(NSString *)username
//{
//    NSString *urlString = [NSString stringWithFormat:@"http://%@/users/show/%@.json", [self twitterHostname], username];
//    NSURL *url = [NSURL URLWithString:urlString];
//    return [self fetchJSONValueForURL:url];
//}
//
//
//+ (NSArray *)fetchTimelineForUsername:(NSString *)username
//{
//    NSString *urlString = [NSString stringWithFormat:@"http://%@/statuses/user_timeline/%@.json", [self twitterHostname], username];
//    NSURL *url = [NSURL URLWithString:urlString];
//    return [self fetchJSONValueForURL:url];
//}
//
//@end
