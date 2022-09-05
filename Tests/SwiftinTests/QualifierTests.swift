//
//  QualifierTests.swift
//  
//
//  Created by Junjie He on 9/5/22.
//

import XCTest
@testable import Swiftin

final class QualifierTests: XCTestCase {
    
    func testTypeQualifier() {
        let context = Context()
        context.singleton(qualifier: Qualifier(type: MockProtocol.self)) { _ in
            MockProtocolImpl()
        }
        let mockProtocol = context.generate(qualifier: Qualifier(type: MockProtocol.self))
        XCTAssertNotNil(mockProtocol)
    }
    
    func testStringQualifier() {
        let context = Context()
        context.singleton(qualifier: named(name: "Test", type: MockProtocol.self)) { _ in
            MockProtocolImpl()
        }
        let mockProtocol = context.generate(qualifier: named(name: "Test", type: MockProtocol.self))
        XCTAssertNotNil(mockProtocol)
    }
}
