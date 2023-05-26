//
//  HistoryCollectionViewCell.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 24.05.2023.
//

import UIKit
import Kingfisher

class HistoryCollectionViewCell: UICollectionViewCell {

    
    static let identifier = String(describing: HistoryCollectionViewCell.self)

    @IBOutlet weak var checkboxImageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 10
    }
    
    
    func setupHistoryList(history: History) {
        textLabel.text = history.text
    }

}
