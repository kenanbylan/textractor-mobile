//
//  ScanCardView.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 26.05.2023.
//

import Foundation
import UIKit


class ScanCardView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        imageSetup()
    }
    
    
    func imageSetup() {
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.cornerRadius = 10
        
        
    }
    
    
    
    
    
    
}
