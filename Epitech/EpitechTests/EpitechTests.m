//
//  EpitechTests.m
//  EpitechTests
//
//  Created by Remi Robert on 13/01/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NetworkRequest.h"

@interface EpitechTests : XCTestCase

@end

@implementation EpitechTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testLoginConnectionGood {

    XCTestExpectation *expectation = [self expectationWithDescription:@"Connection Good"];
    NSDictionary *params = @{@"login":@"robert_r", @"password":@"fl5>[dWn"};

    [NetworkRequest POST:@"https://epitech-api.herokuapp.com/login" parameters:params blockCompletion:^(AFHTTPRequestOperation *operation, id responseObject) {
        [expectation fulfill];
        NSLog(@"%@", responseObject);
        XCTAssert(responseObject, @"Pass");
    } andErrorCompletion:^(AFHTTPRequestOperation *operation, NSError *error) {
        [expectation fulfill];
        XCTFail(@"fail");
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void) testLoginConnectionWrongUsername {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"connection with wrong username"];
    NSDictionary *params = @{@"login":@"robert_fdsr", @"password":@"fl5>[dWn"};
    
    [NetworkRequest POST:@"https://epitech-api.herokuapp.com/login" parameters:params blockCompletion:^(AFHTTPRequestOperation *operation, id responseObject) {
        [expectation fulfill];
        XCTFail(@"fail");
    } andErrorCompletion:^(AFHTTPRequestOperation *operation, NSError *error) {
        [expectation fulfill];
        XCTAssert(true, @"Pass");
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void) testLoginConnectionWrongUrl {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Connection with wrong url"];
    NSDictionary *params = @{@"login":@"robert_fdsr", @"password":@"fl5>[dWn"};
    
    [NetworkRequest POST:@"https://www.google.com" parameters:params blockCompletion:^(AFHTTPRequestOperation *operation, id responseObject) {
        [expectation fulfill];
        XCTFail(@"fail");
    } andErrorCompletion:^(AFHTTPRequestOperation *operation, NSError *error) {
        [expectation fulfill];
        XCTAssert(true, @"Pass");
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void) testLoginConnectionWrongWithNoParameters {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Connection with no parameters"];

    [NetworkRequest POST:@"https://epitech-api.herokuapp.com/login" parameters:nil blockCompletion:^(AFHTTPRequestOperation *operation, id responseObject) {
        [expectation fulfill];
        XCTAssert(false, @"fail");
    } andErrorCompletion:^(AFHTTPRequestOperation *operation, NSError *error) {
        [expectation fulfill];
        XCTAssert(true, @"Pass");
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
