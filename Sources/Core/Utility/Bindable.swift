//
//  File.swift
//  
//
//  Created by Damodar, Namala
//

import Foundation


protocol Bindable {
    associatedtype T
    func bind(_ object: T)
}

