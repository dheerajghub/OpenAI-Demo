//
//  Alert.swift
//  OpenAI
//
//  Created by Dheeraj Kumar Sharma on 15/01/23.
//

import Foundation
import UIKit

class Alert {
    
    static let CancelButtonIndex = -1;
    
    class func showAlert(_ onController: UIViewController, title:String?,message: String? ) {
        showAlert(onController, title: title, message: message, isCancelBtn: true, cancelButton: "OK", buttons: nil, actions: nil)
    }

    /**
     - parameter title:        title for the alert
     - parameter message:      message for alert
     - parameter cancelButton: title for cancel button
     - parameter buttons:      array of string for title for other buttons
     - parameter actions:      action is the callback which return the action and index of the button which was pressed
     */
    class func showAlert(_ onController:UIViewController?, title:String?, message:String? = nil , isCancelBtn: Bool = true , cancelButton:String = "OK",buttons:[String]? = nil,actions:((_ alertAction:UIAlertAction,_ index:Int)->())? = nil) {
        // make sure it would be run on  main queue
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            if isCancelBtn {
                let action = UIAlertAction(title: cancelButton, style: UIAlertAction.Style.cancel) { (action) in
                    alertController.dismiss(animated: true, completion: nil)
                    actions?(action,CancelButtonIndex)
                }
                alertController.addAction(action)
            }
            
            if let _buttons = buttons {
                for button in _buttons {
                    let action = UIAlertAction(title: button, style: .default) { (action) in
                        let index = _buttons.firstIndex(of: action.title!)
                        actions?(action,index!)
                    }
                    alertController.addAction(action)
                }
            }
            if let onController = onController{
                onController.present(alertController, animated: true, completion: nil)
            }
        }
    }

}
