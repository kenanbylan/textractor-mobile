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
