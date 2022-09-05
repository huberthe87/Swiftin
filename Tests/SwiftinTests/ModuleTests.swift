//
//  ModuleTests.swift
//  
//
//  Created by Junjie He on 9/5/22.
//

import XCTest
@testable import Swiftin

final class ModuleTests: XCTestCase {
    
    let testModule = Module {
        $0.single(type: MockProtocol.self) { _ in
            MockProtocolImpl()
        }
    }
    
    func testCreateModule() {
        startSwiftin(modules: testModule)
        let mockClass = MockClass()
        XCTAssertNotNil(mockClass.mockProtocol)
    }
}
