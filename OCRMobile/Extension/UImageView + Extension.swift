//
//  UImageView + Extension.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 20.05.2023.
//

import Foundation
import UIKit


import UIKit

class BorderImageView: UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
        setupBorder()
    }
    
    private func setupBorder() {
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor(named: "text-color")?.cgColor
        
    }
}

extension UIImageView {
    
    func addClickButton() {
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
