//
//  File.swift
//  
//
//  Created by Damodar, Namala (623-Extern) on 08/02/21.
//

import Foundation

public extension Array where Element: Equatable {
    @discardableResult
    mutating func remove(element: Element) -> Index? {
        guard let index = firstIndex(of: element) else { return nil }
        remove(at: index)
        return index
    }

    @discardableResult
    mutating func remove(elements: [Element]) -> [Index] {
        return elements.compactMap { remove(element: $0) }
    }

}

public extension Array where Element: Hashable {
    mutating func unify() {
        self = unified()
    }
}
public extension Collection where Element: Hashable {
    func unified() -> [Element] {
        return Array(Set(self))
    }
}

public extension Collection {
    subscript(safe index: Index) -> Element? {
        return startIndex <= index && index < endIndex ? self[index] : nil
    }
}

/*
 Usage:
 let array = ["foo", "bar"]
 array.remove(element: "foo")
 array //=> ["bar"]
 **/
