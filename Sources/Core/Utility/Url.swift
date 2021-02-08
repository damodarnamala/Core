//
//  File.swift
//  
//
//  Created by Damodar, Namala
//

import Foundation

public extension String {
    var url: URL? {
        return URL(string: self)
    }
}

extension URL: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        guard let url = URL(string: value) else {
            fatalError("\(value) is an invalid url")
        }
        self = url
    }

    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(stringLiteral: value)
    }

    public init(unicodeScalarLiteral value: String) {
        self.init(stringLiteral: value)
    }
}
/*

 Usage::
 if let url = "https://example.com".url {
 }

 let url: URL = "https://example.com"
 */
