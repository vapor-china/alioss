//
//  File.swift
//  
//
//  Created by spec on 2022/4/18.
//

import Vapor

struct AuthResponse: Content {
    let policy: String
    let OSAccessKeyId: String
    let signature: String
}
