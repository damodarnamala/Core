//
//  File.swift
//  
//
//  Created by Damodar, Namala
//

import Foundation

public extension Result {
    init(value: Success?, error: Failure?) {
        switch (value, error) {
        case (let value?, _):
            self = .success(value)
        case (_, let error?):
            self = .failure(error)
        default:
            fatalError("Both value and error are nil") // or fallback to a generic error
        }
    }
}
