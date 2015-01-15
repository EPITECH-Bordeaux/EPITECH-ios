//
//  NetworkRequest.h
//  Epitech
//
//  Created by Remi Robert on 13/01/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface NetworkRequest : NSObject

+ (AFHTTPRequestOperation *)        POST:(NSString *)urlString
                              parameters:(NSDictionary *)parameters
                         blockCompletion:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                      andErrorCompletion:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
