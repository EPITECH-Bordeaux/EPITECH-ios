//
//  NetworkRequest.m
//  Epitech
//
//  Created by Remi Robert on 13/01/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

#import "NetworkRequest.h"

@implementation NetworkRequest

+ (AFHTTPRequestOperation *)        POST:(NSString *)urlString
                              parameters:(NSDictionary *)parameters
                         blockCompletion:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                      andErrorCompletion:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager.requestSerializer setTimeoutInterval:30];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    AFHTTPRequestOperation *postRequestOperation = [manager POST:urlString parameters:parameters
                                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation, error);
    }];
    return (postRequestOperation);
}

@end
