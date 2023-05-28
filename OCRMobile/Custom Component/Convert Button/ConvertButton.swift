//
//  ConvertButton.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 28.05.2023.
//

import Foundation
import UIKit


class ConvertButton: UIButton {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton() {
        
        setTitleColor(UIColor(named:"text-color"), for: .normal)
        titleLabel?.font = UIFont(name: "Poppins-Medium", size: 20)
        layer.cornerRadius = 12
        
        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowOffset  = CGSize(width: 0.0, height: 6.0)
        layer.shadowRadius  = 8
        layer.shadowOpacity = 0.5
        layer.borderColor = UIColor(named: "text-color")?.cgColor
        layer.borderWidth = 2.0
        shake()
    }
    
    func shake() {
        
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 8, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 8, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: "position")
    }

}
