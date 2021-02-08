//
//  File.swift
//  
//
//  Created by Damodar, Namala (623-Extern) on 08/02/21.
//

import UIKit
import Foundation

public extension UINavigationBar {
    func clearAppearance() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        // Sets shadow (line below the bar) to a blank image
        UINavigationBar.appearance().shadowImage = UIImage()
        // Sets the translucent background color
        UINavigationBar.appearance().backgroundColor = .clear
        // Set translucent. (Default value is already true, so this can be removed if desired.)
        UINavigationBar.appearance().isTranslucent = true
    }

    func appearance(with color: UIColor) {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        // Sets shadow (line below the bar) to a blank image
        UINavigationBar.appearance().shadowImage = UIImage()
        // Sets the translucent background color
        UINavigationBar.appearance().backgroundColor = color
        // Set translucent. (Default value is already true, so this can be removed if desired.)
        UINavigationBar.appearance().isTranslucent = true
    }
}

public extension UIBarButtonItem {
    func appearance(with color: UIColor = .systemBlue,
                    font: UIFont = UIFont(name: "Helvetica", size: 12)!) {
        if #available(iOS 13.0, *) {
            let button = UIBarButtonItemAppearance(style: .plain)
            button.normal.titleTextAttributes = [.foregroundColor: color, .font: font]
        } else {
            UIBarButtonItem.appearance()
                .setTitleTextAttributes([NSAttributedString.Key.font: font],
                                        for: .normal)

        }
    }
}
