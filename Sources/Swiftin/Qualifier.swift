//
//  Qualifier.swift
//
//
//  Created by He, Junjie on 3/16/21.
//

public typealias QualifierValue = String

public class Qualifier<T> {
    
    public var type: T.Type
    
    public let value: QualifierValue
    
    public convenience init(type: T.Type) {
        self.init(name: "\(type)", type: type)
    }
    
    public init(name: String, type: T.Type) {
        self.value = name
        self.type = type
    }
}

public func named<T>(name: String, type: T.Type) -> Qualifier<T> {
    return Qualifier(name: name, type: type)
}
