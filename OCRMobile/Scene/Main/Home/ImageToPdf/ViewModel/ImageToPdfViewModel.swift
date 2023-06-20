//
//  ImageToPdfViewModel.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 27.05.2023.
//

import Foundation
import UIKit
import PDFKit


protocol ImageToPdfViewModelDelegate: AnyObject {
    func reloadData()
}


class ImageToPdfViewModel {
    
    weak var delegate: ImageToPdfViewModelDelegate?
    
    private var selectedImages: [ImageData] = []
    
    
    func addImage(image: UIImage , fileSize: String, imagePath: String) {
        let imageData = ImageData(image: image, imageSize: fileSize, imagePath: imagePath)
        selectedImages.append(imageData)
        delegate?.reloadData()
    }
    
    func removeImage(at index: Int) {
        selectedImages.remove(at: index)
        delegate?.reloadData()
    }
    
    func getImageData(at index: Int) -> ImageData {
        return selectedImages[index]
        
    }
    
    func getNumberOfImages() -> Int {
        return selectedImages.count
    }
    
    
    
    func convertToPdf() -> PDFDocument? {
        let pdfDocument = PDFDocument()
        
        for imageData in selectedImages {
            if let pdfPage = PDFPage(image: imageData.image) {
                pdfDocument.insert(pdfPage, at: pdfDocument.pageCount)
            }
        }
        
        return pdfDocument
        
    }
    
    
    
}
