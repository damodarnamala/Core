//
//  File.swift
//  
//
//  Created by Damodar, Namala (623-Extern) on 08/02/21.
//

import Foundation
import UIKit

open class BaseCell: UITableViewCell, Reusable {

}

class NibBaseCell: UITableViewCell, Reusable {
    // Here we provide a nib for this cell class
    // (instead of relying of the protocol's default implementation)
    static var nib: UINib? {
        return UINib(nibName: String(NibBasedCustomCell.self), bundle: nil)
    }
}
