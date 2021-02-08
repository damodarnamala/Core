//
//  File.swift
//  
//
//  Created by Damodar, Namala
//

import Foundation
import UIKit

public extension UIBarButtonItem {
    static func create(image name: String,
                       target: AnyObject,
                       action: Selector) -> UIBarButtonItem {
        let image = UIImage(named: name)?.withRenderingMode(.alwaysOriginal)
        let barButton = UIBarButtonItem(image: image,
                                        style: .plain ,
                                        target: target,
                                        action: action)
        return barButton
        
    }
}

