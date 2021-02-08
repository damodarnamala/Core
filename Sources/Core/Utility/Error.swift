//
//  File.swift
//  
//
//  Created by Damodar, Namala
//

import Foundation

public struct DictionaryTryValueError: Error {
    public init() {}
}

public extension Dictionary {
    func tryValue(forKey key: Key, error: Error = DictionaryTryValueError()) throws -> Value {
        guard let value = self[key] else { throw error }
        return value
    }
}


/* Usage:
 var dictionary: [String: Int] = [:]
 do {
 let value = try dictionary.tryValue(forKey: "foo")
 print(value) // unreachable
 } catch {
 print(error) //=> DictionaryTryValueError
 }
 */
