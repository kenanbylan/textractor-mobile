//
//  UIView + Extension.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 26.05.2023.
//

import Foundation
import UIKit


extension UIView {
    func addTapAnimation() {
        let originalTransform = self.transform
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(scaleX: 0.80, y: 0.80
            )
        }, completion: { _ in
            UIView.animate(withDuration: 0.2) {
                self.transform = originalTransform
            }
        })
    }
}

