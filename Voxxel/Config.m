//
//  Config.m
//  Voxxel
//
//  Created by David Conner on 6/7/15.
//  Copyright (c) 2015 Voxxel. All rights reserved.
//

#import "Config.h"

NSString *const ConfigPlistKey = @"ConfigPlist";

@interface Config ()
@property (nonatomic, readwrite, strong) NSMutableDictionary *store;
@end

@implementation Config

+ (instancetype)defaultConfig; {
    return [[self alloc] init];
}

- (id)init; {
    if (self = [super init]) {
        [self registerDefaultConfig];
    }

    return self;
}

- (id)getKey:(NSString *)key; {
    return self.store[key];
}

- (void)registerDefaultConfig; {
    self.store = [[self loadDefaults] mutableCopy];
}

- (NSDictionary *)loadDefaults; {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *plistName = [bundle objectForInfoDictionaryKey:ConfigPlistKey];
    NSString *plistPath = [bundle pathForResource:plistName ofType:@"plist"];
    return [NSDictionary dictionaryWithContentsOfFile:plistPath];
}

@end