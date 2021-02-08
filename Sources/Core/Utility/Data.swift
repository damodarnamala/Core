//
//  File.swift
//  
//
//  Created by Damodar, Namala (623-Extern) on 08/02/21.
//

import Foundation

public extension Data {
    func decoded<T: Decodable>(using decoder: JSONDecoder = .init()) throws -> T {
        return try decoder.decode(T.self, from: self)
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


/* Usage:
 try userDidLogin(data.decoded())
 let data = try user.encoded()
*/
