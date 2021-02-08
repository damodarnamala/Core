//
//  File.swift
//  
//
//  Created by Damodar, Namala (623-Extern) on 08/02/21.
//

import Foundation

infix operator ???

public func ???<T>(lhs: T?,
                   error: @autoclosure () -> Error) throws -> T {
    guard let value = lhs else { throw error() }
    return value
}

/*
let value: String? = nil

struct OptionalError: Error {}

do {
    let v = try value ??? OptionalError()
    print(v) // unreachable
} catch {
    print(error) //=> OptionalError
}
**/
