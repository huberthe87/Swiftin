//
//  SupportClasses.swift
//  
//
//  Created by Junjie He on 9/5/22.
//

@testable import Swiftin

class MockClass {
    
    @Inject(MockProtocol.self)
    var mockProtocol: MockProtocol
    
    @Inject(named(name: "test", type: SecondMockProtocol.self))
    var secondMockProtocol: SecondMockProtocol
}

class MockGetClass {
    
    @Get(MockProtocol.self)
    var mockProtocol: MockProtocol
}

protocol MockProtocol: AnyObject {
    func doNothing()
}

class MockProtocolImpl: MockProtocol {
    func doNothing() {
    }
}

class MockProtocolImpl2: MockProtocol {
    func doNothing() {
    }
}

class MockProtocolImpl3: MockProtocol {
    func doNothing() {
    }
}

protocol SecondMockProtocol {
    
    func doNothing()
}

class SecondMockProtocolImpl: SecondMockProtocol {
    
    func doNothing() {
    }
}
