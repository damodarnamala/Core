//
//  File.swift
//  
//
//  Created by Damodar, Namala (623-Extern) on 08/02/21.
//

import Foundation
public protocol Weakable: class { }

extension NSObject: Weakable { }

public extension Weakable {

    func weakify(_ code: @escaping (Self) -> Void) -> () -> Void {
        return { [weak self] in
            guard let self = self else { return }
            code(self)
        }
    }

    func weakify<A>(_ code: @escaping (Self, A) -> Void) -> (A) -> Void {
        return { [weak self] a in
            guard let self = self else { return }

            code(self, a)
        }
    }

    func weakify<A, B>(_ code: @escaping (Self, A, B) -> Void) -> (A, B) -> Void {
        return { [weak self] a, b in
            guard let self = self else { return }

            code(self, a, b)
        }
    }

    func weakify<A, B, C>(_ code: @escaping (Self, A, B, C) -> Void) -> (A, B, C) -> Void {
        return { [weak self] a, b, c in
            guard let self = self else { return }

            code(self, a, b, c)
        }
    }

    func weakify<A, B, C, D>(_ code: @escaping (Self, A, B, C, D) -> Void) -> (A, B, C, D) -> Void {
        return { [weak self] a, b, c, d in
            guard let self = self else { return }

            code(self, a, b, c, d)
        }
    }
}
