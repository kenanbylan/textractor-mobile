//
//  ImageConvertPdfCollectionViewCell.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 27.05.2023.
//

import UIKit


//ImageToPdfViewController için oluşturuldu.
protocol ImageConvertPdfCollectionViewCellDelegate: AnyObject {
    func didTapTrashButton(cell: ImageConvertPdfCollectionViewCell)
}



class ImageConvertPdfCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: ImageConvertPdfCollectionViewCell.self)
    
    
    weak var delegate: ImageConvertPdfCollectionViewCellDelegate?

    
    @IBOutlet weak var trashImageView: UIImageView!
    @IBOutlet weak var fileNameLabel: UILabel!
    @IBOutlet weak var fileSizeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        trashImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(trashButtonTapped))
        trashImageView.addGestureRecognizer(tapGesture)
    }
    
    

    
    @objc func trashButtonTapped() {
        trashImageView.addClickButton()
        delegate?.didTapTrashButton(cell: self)
        
    }
    
    
    func setupImageConvertCell(fileSize: String, fileName: String) {
        let displayName = URL(fileURLWithPath: fileName).lastPathComponent
        fileSizeLabel.text = fileSize
        fileNameLabel.text = displayName
    }

    
}
