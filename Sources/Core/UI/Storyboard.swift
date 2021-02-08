//
//  File.swift
//  
//
//  Created by Damodar, Namala
//

import Foundation
import UIKit

public extension UIStoryboard {
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}

public extension UIViewController {
    static func instance<T: UIViewController>() -> T {
        let name = String(describing: self)
        
        guard let controller = UIStoryboard.main.instantiateViewController(withIdentifier: name) as? T else {
            fatalError("ViewController '\(name)' is not of the expected class \(T.self).")
        }
        return controller
        
    }
}
