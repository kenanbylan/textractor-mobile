//
//  AlertViewHelper.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 11.05.2023.
//

import Foundation


import UIKit

import UIKit

class AlertViewHelper {
    static func showAlert(title: String = "Error", message: String, style: UIAlertController.Style = .alert) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let close = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        alert.addAction(close)
        return alert
    }
    
    static func showActionSheet(title: String, message: String = "",
                                actionItemTitle: String, cancelItemTitle: String = "Cancel",
                                handler: @escaping () -> Void) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let actionItem = UIAlertAction(title: actionItemTitle, style: .default) { _ in
            handler()
        }
        alert.addAction(actionItem)
        
        let cancelItem = UIAlertAction(title: cancelItemTitle, style: .cancel, handler: nil)
        alert.addAction(cancelItem)
        return alert
    }
}
