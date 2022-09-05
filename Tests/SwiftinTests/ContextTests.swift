import XCTest
@testable import Swiftin

final class ContextTests: XCTestCase {
    
    func testCreateContext() throws {
        let context = Context()
        context.singleton(qualifier: Qualifier(type: MockProtocol.self)) { _ in
            MockProtocolImpl()
        }
        let mockProtocol = context.generate(qualifier: Qualifier(type: MockProtocol.self))
        XCTAssertNotNil(mockProtocol)
    }
    
    func testSubContextFallback() throws {
        let context = Context()
        context.singleton(qualifier: Qualifier(type: MockProtocol.self)) { _ in
            MockProtocolImpl()
        }
        let subContex = Context(parent: context)
        let mockProtocol = subContex.generate(qualifier: Qualifier(type: MockProtocol.self))
        XCTAssertNotNil(mockProtocol)
    }
    
    func testCreateFactoryContext() throws {
        let context = Context()
        context.factory(qualifier: Qualifier(type: MockProtocol.self)) { _ in
            MockProtocolImpl()
        }
        let mockProtocol = context.generate(qualifier: Qualifier(type: MockProtocol.self))
        XCTAssertNotNil(mockProtocol)
    }
    
    func testCreateFactorySubContext() throws {
        let context = Context()
        context.factory(qualifier: Qualifier(type: MockProtocol.self)) { _ in
            MockProtocolImpl()
        }
        let subContex = Context(parent: context)
        let mockProtocol = subContex.generate(qualifier: Qualifier(type: MockProtocol.self))
        XCTAssertNotNil(mockProtocol)
    }
    
}
