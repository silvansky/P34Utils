//
//  DownloadPortion.m
//  abookclub
//
//  Created by Глеб Тарасов on 27.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DownloadPortion.h"
#import "ASIHTTPRequest.h"

@interface DownloadPortion()


@property(strong, nonatomic) NSString *title;
@property(strong, nonatomic) NSArray *files;

@end

@implementation DownloadPortion : NSObject

@synthesize title = _title;
@synthesize files = _files;

- (id)initWithSingleUrl:(NSString *)url title:(NSString *)title
{
    return [self initWithTitle:title files:[NSArray arrayWithObject:url]];
}

- (id)initWithSingleUrl:(NSString *)url
{
    return [self initWithSingleUrl:url title:url];
}

- (id)initWithTitle:(NSString *)title files:(NSArray *)files
{
    self = [super init];
    if (self)
    {
        self.title = title;
        self.files = files;
    }
    return self;
}

- (NSString *)description
{
    return self.title;
}

@end
