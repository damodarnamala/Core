//
//  File.swift
//  
//
//  Created by Damodar, Namala
//

import Foundation

extension Encodable {
    func encode(with encoder: JSONEncoder = JSONEncoder()) throws -> Data {
        return try encoder.encode(self)
    }
}

extension Decodable {
    static func decode(with decoder: JSONDecoder = JSONDecoder(), from data: Data) throws -> Self {
        return try decoder.decode(Self.self, from: data)
    }
}

public extension Encodable {
    func encoded(using encoder: AnyEncoder = JSONEncoder()) throws -> Data {
        return try encoder.encode(self)
    }
}

public protocol AnyEncoder {
    func encode<T: Encodable>(_ value: T) throws -> Data
}

extension JSONEncoder: AnyEncoder {}
extension PropertyListEncoder: AnyEncoder {}

public extension KeyedDecodingContainerProtocol {
    func decode<T: Decodable>(forKey key: Key) throws -> T {
        return try decode(T.self,
                          forKey: key)
    }
    
    func decode<T: Decodable>( forKey key: Key,
                               default defaultExpression: @autoclosure () -> T) throws -> T {
        return try decodeIfPresent(T.self,
                                   forKey: key) ?? defaultExpression()
    }
}


/* Usage::
 try userDidLogin(data.decoded())
 let data = try user.encoded()
 
 // create a new language
 let language = Language(name: "Swift", version: "4")
 
 // encode with one line of code
 let data = try? language.encode()
 
 let lang: Language? = try? Language.decode(from: data!)
 
 */


