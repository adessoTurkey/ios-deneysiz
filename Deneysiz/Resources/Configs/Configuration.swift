//
//  Configuration.swift
//  Sample-App
//
//  Created by Baha Ulug on 1.12.2020.
//  Copyright © 2020 Adesso Turkey. All rights reserved.
//

import Foundation

final class Configuration {
    
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }
    
    static var baseURL: String? {
        let str: String? = try? Configuration.value(for: "BASE_URL")
        return str
    }
}

extension Configuration {
    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key) else {
            throw Error.missingKey
        }
        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
}
