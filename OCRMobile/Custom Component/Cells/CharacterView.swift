//
//  CharacterView.swift
//  InvioTask
//
//  Created by Kenan Baylan on 16.04.2023.
//

import Foundation
import UIKit


class CharacterView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            initialSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
    

    private func initialSetup() {

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.cornerRadius = 10
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 2
        
        if traitCollection.userInterfaceStyle == .dark {
            layer.borderColor = UIColor.white.cgColor
        } else {
            layer.borderColor = UIColor.black.cgColor
        }
    }
    
    
    
    
}

