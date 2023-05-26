//
//  LanguageTableViewCell.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 25.05.2023.
//

import UIKit

class LanguageTableViewCell: UITableViewCell, NibProtocol , ReuseProtocol {

    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(title: String) {
        titleLabel.text = title
    }
   
}
