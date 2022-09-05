//
//  AnnotationsTest.swift
//  
//
//  Created by Junjie He on 9/4/22.
//

import XCTest
@testable import Swiftin

final class AnnotationsTests: XCTestCase {
    
    func testInjectSingleton() {
        let context = Context.main
        context.singleton(qualifier: Qualifier(type: MockProtocol.self)) { _ in
            MockProtocolImpl()
        }
        
        let mock1 = MockClass()
        XCTAssertNotNil(mock1.mockProtocol)
        
        let mock2 = MockClass()
        XCTAssertNotNil(mock2.mockProtocol)

        XCTAssertTrue(mock1.mockProtocol === mock2.mockProtocol)
    }
    
    func testInjectFactory() {
        let context = Context.main
        context.factory(qualifier: Qualifier(type: MockProtocol.self)) { _ in
            MockProtocolImpl()
        }
        
        let mock1 = MockClass()
        XCTAssertNotNil(mock1.mockProtocol)
        
        let mock2 = MockClass()
        XCTAssertNotNil(mock2.mockProtocol)

        XCTAssertTrue(mock1.mockProtocol !== mock2.mockProtocol)
    }
    
    func testGetSingleton() {
        let context = Context.main
        context.factory(qualifier: Qualifier(type: MockProtocol.self)) { _ in
            MockProtocolImpl()
        }
        
        let mock1 = MockClass()
        XCTAssertNotNil(mock1.mockProtocol)
    }
    
    func testInjectNamed() {
        let context = Context.main
        context.factory(qualifier: named(name: "Test", type: SecondMockProtocol.self)) { _ in
            SecondMockProtocolImpl()
        }
        
        let mock1 = MockClass()
        XCTAssertNotNil(mock1.secondMockProtocol)
    }
}
