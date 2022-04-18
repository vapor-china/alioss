//
//  File.swift
//  
//
//  Created by xj on 2020/5/21.
//

import Foundation
import Crypto

public struct SignError: Error {
    let reason: String
}

public struct SignTool {
    
}

extension SignTool {
    static func encodeWithMD5(content: String, uppercase: Bool = false) -> String {
        let digest = Insecure.MD5.hash(data: Data(content.utf8))
        let str = digest.map { String(format: "%02hhx", $0) }.joined()
        if uppercase {
            return str.uppercased()
        } else {
            return str
        }
        
    }
    
    
    static func encodeWithHMAC<H: HashFunction>(content: String, key: String, type: H.Type, rawData: Bool = false) -> Data? {
          let keyData = key.data(using: .utf8)!
              
          let skey = SymmetricKey(data: keyData)
          var hmac = HMAC<H>(key: skey)
          
          let contentData = content.data(using: .utf8)!
          hmac.update(data: contentData)
          
          let result = hmac.finalize()
          
          if rawData {
          let data = result.withUnsafeBytes { (unsafeRawBufferPointer) -> Data in
              return Data(bytes: unsafeRawBufferPointer.baseAddress!, count: unsafeRawBufferPointer.count)
          }
    
              return data
          }
          
          let resultStr = result.map { String(format: "%02hhx", $0) }.joined()
          guard let data = resultStr.data(using: .utf8) else { return nil }

          return data
      }
}
