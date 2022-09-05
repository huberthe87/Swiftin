//
//  Scope+Registration.swift
//  
//
//  Created by Junjie He on 9/4/22.
//

import Foundation


extension Context {
    fileprivate func warnDuplicatedRegistrationIfExist<Service>(_ qualifier: Qualifier<Service>, _ function: String, _ file: String, _ line: Int) {
        if classes.keys.contains(qualifier.value) {
            // swiftlint:disable:next line_length
            print("⚠️⚠️⚠️ The \(qualifier.type) has already been registered in this Scope, this behavior will override the existing value. Please carefully review your code at \(function) \(file):\(line)! ⚠️⚠️⚠️")
        }
    }
    
    internal func factory<Service>(qualifier: Qualifier<Service>,
                                   factoryClosure: @escaping FactoryClosure,
                                   file: String = #file,
                                   function: String = #function,
                                   line: Int = #line ) {
        warnDuplicatedRegistrationIfExist(qualifier, function, file, line)
        classes[qualifier.value] = Class(singleton: false,
                                         factoryClosure: factoryClosure,
                                         instance: nil,
                                         file: file,
                                         function: function,
                                         line: line)
    }

    internal func singleton<Service>(qualifier: Qualifier<Service>,
                                     factoryClosure: @escaping FactoryClosure,
                                     lazyLoad: Bool = true,
                                     file: String = #file,
                                     function: String = #function,
                                     line: Int = #line ) {
        warnDuplicatedRegistrationIfExist(qualifier, function, file, line)
        classes[qualifier.value] = Class(singleton: true,
                                         factoryClosure: factoryClosure,
                                         instance: lazyLoad ?  nil : factoryClosure(self),
                                         file: file,
                                         function: function,
                                         line: line)
    }
}
