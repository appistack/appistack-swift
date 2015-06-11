//
//  Config.h
//  Voxxel
//
//  Created by David Conner on 6/7/15.
//  Copyright (c) 2015 Voxxel. All rights reserved.
//

@import Foundation;

@protocol Config <NSObject>
@required
- (id)getKey:(NSString *)key;
@end

extern NSString *const ConfigPlistKey;

@interface Config : NSObject <Config>

+ (instancetype)defaultConfig;
- (id)getKey:(NSString *)key;

@end