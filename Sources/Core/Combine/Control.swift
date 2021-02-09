//
//  File.swift
//  
//
//  Created by Damodar, Namala (623-Extern) on 09/02/21.
//

import UIKit
import Foundation

@objc class ClosureSleeve: NSObject {
    let closure: ()->()

    init (_ closure: @escaping ()->()) {
        self.closure = closure
    }

    @objc func invoke () {
        closure()
    }
}

extension UIControl {
    func on(for controlEvents: UIControl.Event = .touchUpInside,
            _ closure: @escaping ()->()) {
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve,
                  action: #selector(ClosureSleeve.invoke),
                  for: controlEvents)
        objc_setAssociatedObject(self,
                                 String(ObjectIdentifier(self).hashValue) + String(controlEvents.rawValue),
                                 sleeve,
                                 objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}
/*
 button.action(.valueChanged, { (sender: UIControl) in
    print("Switch State:", mySwitch.isOn)
 })
 */


import Combine

class BlockObject: NSObject {
    let block: () -> Void

    init(block: @escaping () -> Void) {
        self.block = block
    }

    @objc dynamic func execute() {
        block()
    }
}

extension UIControl {
    @available(iOS 13.0, *)
    func on( for controlEvents: UIControl.Event,
                     block: @escaping () -> Void) -> Cancellable {
        let blockObject = BlockObject(block: block)
        addTarget(blockObject,
                  action: #selector(BlockObject.execute),
                  for: controlEvents)

        return AnyCancellable {
            self.removeTarget(blockObject,
                              action: #selector(BlockObject.execute),
                              for: controlEvents)
        }
    }
}


/*
 let button = UIButton(type: .system)

 // Add the handler
 let cancellable = button.addHandler(for: .touchUpInside) {
 print("Button pressed!")
 }

 // Remove the handler
 cancellable.cancel()
 */


