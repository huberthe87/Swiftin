//
//  Context.swift
//  
//
//  Created by Junjie He on 9/4/22.
//

import Foundation

public func startSwiftin(_ context: Context = .main, modules: Module...) {
    modules.forEach { (module) in
        module.inject(context)
    }
}

public class Context: ObservableObject {
    internal let parent: Context?

    public init(parent: Context? = main) {
        self.parent = parent
    }

    internal var classes = [String: Class]()
}

extension Context {
    public static var main: Context = {
        Context(parent: nil)
    }()
}

public typealias FactoryClosure = (Context) -> AnyObject

//public typealias Module = (Context) -> Void

struct Class {
    let singleton: Bool
    let factoryClosure: FactoryClosure
    var instance: AnyObject?
    let file: String
    let function: String
    let line: Int
}

public class Module {
    
    private lazy var context: Context = .main
    
    private let closure: (Module) -> Void
    
    init(closure: @escaping (Module) -> Void) {
        self.closure = closure
    }
    
    public func single<T>(type: T.Type, apply closure: @escaping FactoryClosure) {
        context.singleton(qualifier: Qualifier(type: type), factoryClosure: closure)
    }

    public func single<T>(type: T.Type, qualifier: Qualifier<T>, apply closure: @escaping FactoryClosure) {
        context.singleton(qualifier: qualifier, factoryClosure: closure)
    }

    public func factory<T>(type: T.Type, apply closure: @escaping FactoryClosure) {
        context.factory(qualifier: Qualifier(type: type), factoryClosure: closure)
    }

    public func factory<T>(type: T.Type, qualifier: Qualifier<T>, apply closure: @escaping FactoryClosure) {
        context.factory(qualifier: qualifier, factoryClosure: closure)
    }
    
    internal func inject(_ context: Context) {
        self.context = context
        closure(self)
    }
}
