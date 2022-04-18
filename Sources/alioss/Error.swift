//
//  File.swift
//  
//
//  Created by spec on 2022/4/18.
//

import Foundation

public struct AliOSSError: Error {
    
    var reason: String
    
    init(reason: String) {
        self.reason = reason
    }
}

extension AliOSSError: CustomStringConvertible {
    public var description: String {
        "error cause: \(reason)"
    }
}

extension AliOSSError: LocalizedError {
    public var errorDescription: String? {
        reason
    }
}
