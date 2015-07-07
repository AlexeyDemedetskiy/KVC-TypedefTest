//
//  TypedefTests.m
//  Typedef Test
//
//  Created by Alexey Demedckiy on 07.07.15.
//  Copyright (c) 2015 DAloG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>


@protocol TestProtocol <NSObject>

@property (readonly) NSString* content;

@end


@interface TestImpl : NSObject<TestProtocol>

@property NSString* content;

@end

@implementation TestImpl
@end

typedef NSObject<TestProtocol> TestProtocol;
typedef NSObject<TestProtocol>* TestProtocolPtr;

@interface TestContainer : NSObject

@property id<TestProtocol> idTest;
@property NSObject<TestProtocol>* objectTest;
@property TestProtocol* namedTest;
@property TestProtocolPtr pointerTest;

@end

@implementation TestContainer
@end



@interface TypedefTests : XCTestCase

@property TestContainer* container;

@end

@implementation TypedefTests

- (void)setUp {
    [super setUp];
    
    self.container = [TestContainer new];
    
    TestImpl* impl = [TestImpl new];
    impl.content = @"content";
    
    self.container.idTest = impl;
    self.container.objectTest = impl;
    self.container.namedTest = impl;
    self.container.pointerTest = impl;
}

- (void)tearDown {
    
    self.container = nil;
    
    [super tearDown];
}

- (void)testID {
    XCTAssertEqualObjects([self.container valueForKeyPath:@"idTest.content"], @"content");
}

- (void)testObject {
    XCTAssertEqualObjects([self.container valueForKeyPath:@"objectTest.content"], @"content");
}

- (void)testNamed {
    XCTAssertEqualObjects([self.container valueForKeyPath:@"namedTest.content"], @"content");
}

- (void)testPointer {
    XCTAssertEqualObjects([self.container valueForKeyPath:@"pointerTest.content"], @"content");
}

@end
