//
//  Annotations.swift
//
//
//  Created by Junjie He on 9/4/22.
//

@propertyWrapper
public struct Inject<T> {
    
    private let qualifier: Qualifier<T>
    private let context: Context
    
    public lazy var wrappedValue: T = {
        context.generate(qualifier: qualifier)
    }()
    
    public init(_ qualifier: Qualifier<T>, _ context: Context = .main) {
        self.qualifier = qualifier
        self.context = context
    }
    
    public init(_ type: T.Type, _ context: Context = .main) {
        self.init(Qualifier(type: type), context)
    }
}

@propertyWrapper
public struct Get<T> {
    
    public let wrappedValue: T
    
    public init(_ qualifier: Qualifier<T>, _ context: Context = .main) {
        self.wrappedValue = context.generate(qualifier: qualifier)
    }
    
    public init(_ type: T.Type, _ context: Context = .main) {
        self.init(Qualifier(type: type), context)
    }
}
