//
//  ServerError.h
//  AppEmag
//
//  Created by Viorel on 07.09.2023.
//

#ifndef ServerError_h
#define ServerError_h

#import <Foundation/Foundation.h>

@interface ServerError : NSObject

@property (nonatomic, copy) NSString *errorCode;
@property (nonatomic, copy) NSString *errorMessage;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end


#endif /* ServerError_h */
