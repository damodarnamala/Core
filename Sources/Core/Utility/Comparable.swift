//
//  File.swift
//  
//
//  Created by Damodar, Namala
//

import Foundation

public extension Comparable {
    func clamp(low: Self, high: Self) -> Self {
        if (self > high) {
            return high
        } else if (self < low) {
            return low
        }
        return self
    }
}
