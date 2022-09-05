//
//  Scope+Injection.swift
//  
//
//  Created by Junjie He on 9/4/22.
//

import Foundation

extension Context {
    internal func generate<Service>(
        qualifier: Qualifier<Service>) -> Service {
            guard var clazz = classes[qualifier.value] else {
                guard let service = parent?.generate(qualifier: qualifier) else {
                    fatalError("\(qualifier.value) is not registered, please make sure to setup it before calling resolve.")
                }
                return service
            }
            if clazz.singleton {
                // Singleton mode
                if clazz.instance == nil {
                    clazz.instance = clazz.factoryClosure(self)
                    classes[qualifier.value] = clazz
                }
                guard let service = clazz.instance as? Service else {
                    // swiftlint:disable:next line_length
                    fatalError("Can't force cast \(String(describing: clazz.instance.self)) to \(qualifier.type), please check your implementation of function \(clazz.function) at \(clazz.file) line:\(clazz.line).")
                }
                return service
            } else {
                // Factory mode
                guard let service = clazz.factoryClosure(self) as? Service else {
                    // swiftlint:disable:next line_length
                    fatalError("The factory closure didn't return a valid intance of \(qualifier.type), please check your implementation of function \(clazz.function) at \(clazz.file) line:\(clazz.line).")
                }
                return service
            }
        }
}
