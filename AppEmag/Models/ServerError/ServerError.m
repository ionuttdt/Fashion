//
//  ServerError.m
//  AppEmag
//
//  Created by Viorel on 07.09.2023.
//

#import <Foundation/Foundation.h>
#import "ServerError.h"

@implementation ServerError

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _errorCode = [dictionary objectForKey:@"errorCode"];
        _errorMessage = [dictionary objectForKey:@"errorMessage"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.errorCode forKey:@"errorCode"];
    [encoder encodeObject:self.errorMessage forKey:@"errorMessage"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        _errorCode = [decoder decodeObjectForKey:@"errorCode"];
        _errorMessage = [decoder decodeObjectForKey:@"errorMessage"];
    }
    return self;
}

@end
