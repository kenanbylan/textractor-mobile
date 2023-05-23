//
//  RecentTableViewCell.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 22.05.2023.
//

import UIKit

class RecentTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: RecentTableViewCell.self)
    
    @IBOutlet weak var resultText: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var copyButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    //MARK: Setup scanned text
    func setupScannedText(history: History ) {
        resultText.text = history.text
        languageLabel.text = history.language
    }
    
    
    @IBAction func copyButtonTapped(_ sender: Any) {
        print("Copy text button clicked.")
    }
    
    
}
