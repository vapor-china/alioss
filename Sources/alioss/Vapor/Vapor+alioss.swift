//
//  File.swift
//
//
//  Created by spec on 2022/4/18.
//

import Vapor

public extension Application {
    
    var alioss: AliOSS {
            .init(application: self)
        }
    
    struct AliOSS {
        let application: Application
        
        // Register AliOSS
        public func use(_ config: AliOSSConfig) {
            self.configuration = config
        }
        
        private final class Storage {
            var config: AliOSSConfig
            init(config: AliOSSConfig) {
                self.config = config
            }
        }
        
        private struct Key: StorageKey {
            typealias Value = Storage
        }

        private struct ConfigKey: StorageKey {
            typealias Value = AliOSSConfig
        }

        var configuration: AliOSSConfig {
            get {
                guard let config = self.application.storage[ConfigKey.self] else {
                    fatalError("No AliOSS Configuration. Configure with app.wehcat.use(...)")
                }
                return config
            }
            nonmutating set {
                self.application.storage[ConfigKey.self] = newValue
            }
        }
        
//         var client: Storage {
//            storage
//        }
//
//        private var storage: Storage {
//            if let existing = self.application.storage[Key.self] {
//                return existing
//            } else {
//                guard let config = configuration else {
//                    fatalError("No AliOSS Configuration. Configure with app.wehcat.use(...)")
//                }
//                let storage = Storage(config: config)
//                self.application.storage[Key.self] = storage
//                return storage
//            }
//        }
    }
}
