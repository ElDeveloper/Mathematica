//
//  Twitterer.m
//  UsuarioTwitter
//
//  Created by Yoshiki  Vázquez  Baeza on 25/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Twitterer.h"


@implementation Twitterer

@synthesize username;

-(void)inicializaConUsername:(NSMutableString *)cadena
{
//	NSLog(@"About to execute inicializaConUsername");
	username=cadena;
	NSLog(@"Username usado: %@",cadena);
}
-(NSMutableArray *)getTimeline
{
	NSArray *temp=[NSMutableArray array];
	int i;
	int j; /*Sirve como indice para saber cuantos twitts tiene esta persona en su timeline*/

	temp=[TwitterHelper fetchTimelineForUsername:username];
	timeline=[NSMutableArray array];
	j=[temp count];
	for(i=0;i<(j);i++)
	{
#ifdef Debugging_Process
		NSLog(@"%@",[[[temp objectAtIndex:i] objectForKey:@"user"] objectForKey:@"screen_name"]);
		NSLog(@"%@",[[temp objectAtIndex:i] objectForKey:@"text"]);
#endif
		[timeline insertObject:[[temp objectAtIndex:i] objectForKey:@"text"] atIndex:i];
	}
	return timeline;
}

//+(UIImage *)returnImageForUsername:(NSMutableString *)name
//{
//	NSString *string=[[NSString alloc] initWithString:[[TwitterHelper fetchInfoForUsername:name] objectForKey:@"profile_image_url"]];
//	NSURL *url=[[NSURL alloc] initWithString:string];
//	NSData *data=[[NSData alloc] initWithContentsOfURL:url];
//	UIImage *imagen=[[UIImage alloc] initWithData:data];
//
//	[string release];
//	[url release];
//	[data release];
////	return [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[TwitterHelper fetchInfoForUsername:name] objectForKey:@"profile_image_url"]]]];
//	return imagen;
//}

-(void)dealloc{
	[timeline release];
	[username release];
	[super dealloc];
}

@end
