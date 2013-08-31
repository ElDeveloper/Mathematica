//
//  Twitterer.h
//  UsuarioTwitter
//
//  Created by Yoshiki  Vázquez  Baeza on 25/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TwitterHelper.h"
#import "Debugging.h"

@interface Twitterer : NSObject {
	NSMutableString *username;
	NSMutableArray *timeline;
}

-(void)inicializaConUsername:(NSMutableString *)cadena;
-(NSMutableArray *)getTimeline;
//+(UIImage *)returnImageForUsername:(NSMutableString *)name;
@property (retain, nonatomic) NSMutableString *username;
@end
