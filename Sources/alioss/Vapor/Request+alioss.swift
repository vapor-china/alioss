//
//  File.swift
//  
//
//  Created by spec on 2022/4/18.
//

import Vapor

extension Request {
    
    public struct AliOSS {
        let request: Request
        
        private var config: AliOSSConfig {
            request.application.alioss.configuration
        }
    }
}

extension Request.AliOSS {
    public func fetchAuthToken(expireTime: Date = Date().addingTimeInterval(1800), maxSize: Int64 = 1048576000) {
//        let time = Date().addingTimeInterval(1800)
        
    }
}
