//
//  EGOCache.m
//  enormego
//
//  Created by Shaun Harrison on 7/4/09.
//  Copyright 2009 enormego. All rights reserved.
//

#import "EGOCache.h"
#import "NSString+NimbusCore.h"

#define cachePathForKey(key) [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/EGOCache/%@", [key md5Hash]]]

static id __instance;

@implementation EGOCache

+ (EGOCache*)currentCache {
	@synchronized(self) {
		if(!__instance) {
			__instance = [[EGOCache alloc] init];
		}
	}
    
	return __instance;
}

- (id)init {
	if((self = [super init])) {
		NSDictionary* dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"EGOCache"];
		if([dict isKindOfClass:[NSDictionary class]]) {
			cacheDictionary = [dict mutableCopy];
		} else {
			cacheDictionary = [[NSMutableDictionary alloc] init];
		}
        
		[[NSFileManager defaultManager] createDirectoryAtPath:cachePathForKey(@"") 
								  withIntermediateDirectories:YES 
												   attributes:nil 
														error:NULL];
        
		for(NSString* key in cacheDictionary) {
			NSDate* date = cacheDictionary[key];
			if([[[NSDate date] earlierDate:date] isEqualToDate:date]) {
				[[NSFileManager defaultManager] removeItemAtPath:cachePathForKey(key) error:NULL];
			}
		}
	}
    
	return self;
}

- (BOOL)hasCacheForKey:(NSString*)key {
	NSDate* date = cacheDictionary[key];
	if(!date) return NO;
	if([[[NSDate date] earlierDate:date] isEqualToDate:date]) return NO;
    NSString *filePath = cachePathForKey(key);
	return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

#pragma mark -
#pragma mark Data methods

- (void)setData:(NSData*)data forKey:(NSString*)key {
	[self setData:data forKey:key withTimeoutInterval:TIME_INTERVAL_FOR_ONE_DAY];
}

- (void)setData:(NSData*)data forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval {
	[data writeToFile:cachePathForKey(key) atomically:YES];
	cacheDictionary[key] = [NSDate dateWithTimeIntervalSinceNow:timeoutInterval];
	[[NSUserDefaults standardUserDefaults] setObject:cacheDictionary forKey:@"EGOCache"];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSData*)dataForKey:(NSString*)key {
	if([self hasCacheForKey:key]) {
		return [NSData dataWithContentsOfFile:cachePathForKey(key) options:0 error:NULL];
	} else {
		return nil;
	}
}

#pragma mark -
#pragma mark String methods

- (NSString*)stringForKey:(NSString*)key {
	return [[NSString alloc] initWithData:[self dataForKey:key] encoding:NSUTF8StringEncoding];
}

- (void)setString:(NSString*)aString forKey:(NSString*)key {
	[self setString:aString forKey:key withTimeoutInterval:TIME_INTERVAL_FOR_ONE_DAY];
}

- (void)setString:(NSString*)aString forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval {
	[self setData:[aString dataUsingEncoding:NSUTF8StringEncoding] forKey:key withTimeoutInterval:timeoutInterval];
}

#pragma mark -
#pragma mark Image methds

#if TARGET_OS_IPHONE

- (UIImage*)imageForKey:(NSString*)key {
	return [UIImage imageWithData:[self dataForKey:key]];
}

- (void)setImage:(UIImage*)anImage forKey:(NSString*)key {
	[self setImage:anImage forKey:key withTimeoutInterval:TIME_INTERVAL_FOR_ONE_DAY];
}

- (void)setImage:(UIImage*)anImage forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval {
	[self setData:UIImagePNGRepresentation(anImage) forKey:key withTimeoutInterval:timeoutInterval];
}


#else

- (NSImage*)imageForKey:(NSString*)key {
	return [[[NSImage alloc] initWithData:[self dataForKey:key]] autorelease];
}

- (void)setImage:(NSImage*)anImage forKey:(NSString*)key {
	[self setImage:anImage forKey:key withTimeoutInterval:TIME_INTERVAL_FOR_ONE_DAY];
}

- (void)setImage:(NSImage*)anImage forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval {
	[self setData:[[[anImage representations] objectAtIndex:0] representationUsingType:NSPNGFileType properties:nil]
		   forKey:key withTimeoutInterval:timeoutInterval];
}

#endif

@end