
import Vapor

public struct AliOSSConfig {
    
    let appKey: String
    let secret: String
}


extension AliOSSConfig {
    
    func generateWechatMiniprogramAuth(expireTime: Date, maxSize: Int64) throws -> AuthResponse {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        
        let exporation = formmater.string(from: expireTime)
        
        let policyDic = [
            "expiration": "\(exporation)Z", //设置该Policy的失效时间，超过这个失效时间之后，就没有办法通过这个policy上传文件了
            "conditions": [
                    [
                        "content-length-range",
                        0,
                        maxSize
                    ] // 设置上传文件的大小限制
                ]
            ] as [String : Any]
        
        let jsonData1 = try JSONSerialization.data(withJSONObject: policyDic, options: [])
        let msg = jsonData1.base64EncodedString()
        
        if let data = SignTool.encodeWithHMAC(content: msg, key: secret, type: Insecure.SHA1.self, rawData: true) {
            return AuthResponse(policy: msg, OSAccessKeyId: appKey, signature: data.base64EncodedString())
        }
        throw AliOSSError(reason: "签名失败")
    }
}
