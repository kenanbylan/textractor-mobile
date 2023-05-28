//  ImageToPdfViewController.swift
//  OCRMobile
//  Created by Kenan Baylan on 27.05.2023.


import UIKit
import PDFKit

class ImageToPdfViewController: UIViewController, Storyboarded, UINavigationControllerDelegate {
    
    //MARK: UIElements
    @IBOutlet weak var imageToPdfCollectionView: UICollectionView!
    
    
    //MARK: Variables
    var selectedImages: [ImageData] = []
    
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCellNibs()
        
    }
    

    func registerCellNibs() {
        let imageToPdfNibName = ImageConvertPdfCollectionViewCell.identifier
        imageToPdfCollectionView.register(UINib(nibName: imageToPdfNibName, bundle: nil), forCellWithReuseIdentifier: imageToPdfNibName)
    }
    
    
    
    
}


extension ImageToPdfViewController: UICollectionViewDelegate ,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier = ImageConvertPdfCollectionViewCell.identifier
        let cell = imageToPdfCollectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ImageConvertPdfCollectionViewCell
        
        let imageInfo = selectedImages[indexPath.item]
        
        cell.setupImageConvertCell(fileSize: imageInfo.imageSize, fileName: imageInfo.imagePath)
        cell.fileNameLabel.text = imageInfo.imagePath
        cell.fileSizeLabel.text = imageInfo.imageSize
        cell.delegate = self
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Select item: ", indexPath.row)
    }
    
}


extension ImageToPdfViewController: ImageConvertPdfCollectionViewCellDelegate {
    
    
    func didTapTrashButton(cell: ImageConvertPdfCollectionViewCell) {
        guard let indexPath = imageToPdfCollectionView.indexPath(for: cell) else {
            return
        }
        
        selectedImages.remove(at: indexPath.item)
        imageToPdfCollectionView.deleteItems(at: [indexPath])
    }
    
    
}

extension ImageToPdfViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[.originalImage] as? UIImage ,
           let imageData = selectedImage.jpegData(compressionQuality: 1.0) {
            let fileManager = FileManager.default
            let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
            guard let documentDirectory = documentsDirectory else {
                return
            }
            
            
            let fileName = "\(UUID().uuidString).jpg" // Generate a unique file name
            let filePath = documentDirectory.appendingPathComponent(fileName).path
            
            do {
                try imageData.write(to: URL(fileURLWithPath: filePath))
                
                let fileAttributes = try fileManager.attributesOfItem(atPath: filePath)
                let fileSize = fileAttributes[.size] as? Int64 ?? 0
                
                let formatter = ByteCountFormatter()
                formatter.allowedUnits = [.useMB] // You can customize the units as per your requirement
                formatter.countStyle = .file
                let fileSizeString = formatter.string(fromByteCount: fileSize)
                
                let imageData = ImageData(image: selectedImage, imageSize:fileSizeString , imagePath: filePath)
                selectedImages.append(imageData)
                imageToPdfCollectionView.reloadData()
                
            } catch {
                print("Error writing image data to file: \(error)")
                
            }
            
            
        }
    }
    
    
    @IBAction func addDocButtonTapped(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        // imagePicker.allowsMultipleSelection = true
        
        present(imagePicker, animated: true)
        
    }
    
    
    @IBAction func convertButtonTapped(_ sender: Any) {
        let pdfDocument = PDFDocument()
        
        for imageInfo in selectedImages {
            if let pdfPage = PDFPage(image: imageInfo.image) {
                pdfDocument.insert(pdfPage, at: pdfDocument.pageCount)
            }
        }
        
        let filePath = ""
        pdfDocument.write(toFile: filePath)
        
        
        if selectedImages.isEmpty {
            //will be alert
            
        } else {
            
            // Or present the PDF using UIActivityViewController
            let activityViewController = UIActivityViewController(activityItems: [pdfDocument.dataRepresentation()], applicationActivities: nil)
            present(activityViewController, animated: true, completion: nil)
            
        }
        
    }
}
