//
//  UITableView + Extension.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 25.05.2023.
//

import Foundation
import UIKit

extension UITableView {
    
    func registerCell<T:  NibProtocol & ReuseProtocol>(type: T.Type) {
        register(type.nib, forHeaderFooterViewReuseIdentifier: type.reuseIdentifier)
    }
    
    func dequeueCell<T: ReuseProtocol>(for indexPath: IndexPath) -> T {
        let dequeued = dequeueReusableCell(withIdentifier: T.reuseIdentifier) as! T
        
        return dequeued
    }
    
}
