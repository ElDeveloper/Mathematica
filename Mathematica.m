#import <Foundation/Foundation.h>

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	BOOL weDidIt=NO;
	BOOL findWolframAlpha=NO;
	BOOL findWolframResearch=!findWolframAlpha;
	
	int usernamePicker,i=0, postWith=0;
	usernamePicker=2;
	
	
	NSMutableArray *theUsernames=[[NSMutableArray alloc] initWithObjects:@"yoshikiv",@"yosmark",nil];
	NSMutableArray *theArray=[[NSMutableArray alloc] init];
	NSMutableString *theRetweetedString;
	NSString *parsedString;
	NSRange theRange;
	theRange.location=0;
	NSString *aString;
	
	if (findWolframAlpha) {
		theRetweetedString=[[NSMutableString alloc] initWithString:@"RT: @Wolfram_Alpha "];
	}
	if (findWolframResearch) {
		theRetweetedString=[[NSMutableString alloc] initWithString:@"RT: @WolframResearch "];
	}
	
#ifdef Debugging_Process_not_now
	NSLog(@"\nSo far I have this usernames.\n\tOn the slot 0: %@\n\tOn the slot 1: %@\n\n",
		  [theUsernames objectAtIndex:0],[theUsernames objectAtIndex:1]);
	
	theArray=[TwitterHelper homeDeUsername:[theUsernames objectAtIndex:0] conPassword:@"" yNumeroDeTweets:20];
	NSLog(@"This\n\n: %@",[[[theArray objectAtIndex:0] objectForKey:@"user"] objectForKey:@"name"]);
#endif
	
	while (!weDidIt) {
		if (usernamePicker%2==0) {
			postWith=0;
			theArray=[TwitterHelper homeDeUsername:[theUsernames objectAtIndex:0] conPassword:@"" yNumeroDeTweets:20];
			NSLog(@"Estoy usando yoshikiv");
#ifdef Debugging_Process_not_now
			NSLog(@"This user: %@",[[[theArray objectAtIndex:0] objectForKey:@"user"] objectForKey:@"name"]);
			NSLog(@"Tweeted this: %@",[[theArray objectAtIndex:0] objectForKey:@"text"]);
#endif
		}
		else {
			if (usernamePicker%2==1) {
				postWith=1;
				theArray=[TwitterHelper homeDeUsername:[theUsernames objectAtIndex:1] conPassword:@"" yNumeroDeTweets:20];
				NSLog(@"Estoy usando yosmark");
#ifdef Debugging_Process_not_now
				NSLog(@"This user: %@",[[[theArray objectAtIndex:0] objectForKey:@"user"] objectForKey:@"name"]);
				NSLog(@"Tweeted this: %@",[[theArray objectAtIndex:0] objectForKey:@"text"]);
#endif
			}
		}

		if (findWolframAlpha) {
			for(i=0;i<5;i++){
				if ([[[[theArray objectAtIndex:i] objectForKey:@"user"] objectForKey:@"name"] isEqualToString:@"Wolfram|Alpha"]) {
					
					weDidIt=YES;
					
					NSLog(@"We found Wolfram|Alpha on the %d chance.",i);
					
					[theRetweetedString appendString:[[theArray objectAtIndex:i] objectForKey:@"text"]];
					
					parsedString=[theRetweetedString stringByReplacingOccurrencesOfString:@"&" withString:@""];
					theRetweetedString=(NSMutableString *)parsedString;
					
					if ([theRetweetedString length]>138) {
						NSLog(@"It's a long string");
						theRange.length=138;
						aString=[theRetweetedString substringWithRange:theRange];
						NSLog(@"ESTO ES LO QUE TWITTEARE:\n %@",aString);
						NSLog(@"Mide %d",[aString length]);
						[TwitterHelper updateStatus:aString forUsername:@"yoshikiv" withPassword:@""];
						break;
					}
					
					NSLog(@"ESTO ES LO QUE TWITTEARE:\n %@",theRetweetedString);
					NSLog(@"Mide %d",[theRetweetedString length]);
					[TwitterHelper updateStatus:theRetweetedString forUsername:@"yoshikiv" withPassword:@""];
					break;
				}
			}
		}
		
		if (findWolframResearch) {
			for(i=0;i<5;i++){
				
				if ([[[[theArray objectAtIndex:i] objectForKey:@"user"] objectForKey:@"name"] isEqualToString:@"Wolfram Research"]) {
					
					weDidIt=YES;
					
					NSLog(@"We found Wolfram Research on the %d chance.",i);
					
					[theRetweetedString appendString:[[theArray objectAtIndex:i] objectForKey:@"text"]];
					
					parsedString=[theRetweetedString stringByReplacingOccurrencesOfString:@"&" withString:@""];
					theRetweetedString=(NSMutableString *)parsedString;
					
					if ([theRetweetedString length]>138) {
						NSLog(@"It's a long string");
						theRange.length=138;
						aString=[theRetweetedString substringWithRange:theRange];
						NSLog(@"ESTO ES LO QUE TWITTEARE:\n %@",aString);
						NSLog(@"Mide %d",[aString length]);
						[TwitterHelper updateStatus:aString forUsername:@"yosmark" withPassword:@""];
						break;
					}
					
					NSLog(@"ESTO ES LO QUE TWITTEARE:\n %@",theRetweetedString);
					NSLog(@"Mide %d",[theRetweetedString length]);
					[TwitterHelper updateStatus:theRetweetedString forUsername:@"yosmark" withPassword:@""];
					break;
				}
			}
		}
		
		usernamePicker++;
		if (usernamePicker>150) {
			usernamePicker=2;
		}
		
		[NSThread sleepForTimeInterval:15];
	}
	
	
    [pool drain];
    return 0;
}
