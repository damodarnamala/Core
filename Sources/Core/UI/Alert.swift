//
//  File.swift
//  
//
//  Created by Damodar, Namala
//

import Foundation
import UIKit

public extension NSObject {

    // #4: SHOW A SIMPLE ALERT MESSAGE FROM ANY VIEWCONTROLLER OR OBJECT
    func showMessage(with title: String, and body: String) {
        if(UIApplication.shared.applicationState == .active) {
            // IF THE APP IS ACTIVE, IT HAS AN UIVIEWCONTROLLER, LET SHOW USE IT FOR DISPLAYING THE MESSAGE
            if let vc =  UIApplication.shared.windows.first!.rootViewController {
                let alert = UIAlertController(title: title, message:body, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default) { _ in })
                vc.present(alert, animated: true){}
            }
        } else {
            // ELSE, IF THE APP IS IN BACKGROUND, LET'S TRY TO ISSUE A LOCAL NOTIFICATION
            let localNotification:UILocalNotification = UILocalNotification()
            localNotification.alertAction = title
            localNotification.alertBody = body
            localNotification.fireDate = Date()
            UIApplication.shared.scheduleLocalNotification(localNotification)
        }
    }

    // #5: GET THE NEXT AVAILABLE PARENT VIEWCONTROLLER FROM AN OBJECT
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self as? UIResponder
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
/*
 Usage::
 let vc = UIViewController()
 vc.showMessage(with:"Download Complete", and: "Your download is complete!")
 */
