//  ImageToPdfViewController.swift
//  OCRMobile
//  Created by Kenan Baylan on 27.05.2023.


import UIKit
import PDFKit
import ProgressHUD

class ImageToPdfViewController: UIViewController, Storyboarded, UINavigationControllerDelegate {
    
    
    
    
    //MARK: UIElements
    @IBOutlet weak var imageToPdfCollectionView: UICollectionView!
    @IBOutlet weak var addImageImageView: UIImageView!
    
    
    private var viewModel: ImageToPdfViewModel!
    private var selectedImages: [ImageData] = []
    
    
    let placeholderImage = UIImage(named: "scanner2")
    
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCellNibs()
        setupViewModel()
        
        updateAddDocumentImageView()
    }
    
    private func setupViewModel() {
        viewModel = ImageToPdfViewModel()
        viewModel.delegate = self
    }
    
    func registerCellNibs() {
        let imageToPdfNibName = ImageConvertPdfCollectionViewCell.identifier
        imageToPdfCollectionView.register(UINib(nibName: imageToPdfNibName, bundle: nil), forCellWithReuseIdentifier: imageToPdfNibName)
    }
    
    
    private func updateAddDocumentImageView() {
        addImageImageView.isHidden = viewModel.getNumberOfImages() > 0
    }
}


extension ImageToPdfViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumberOfImages()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier = ImageConvertPdfCollectionViewCell.identifier
        let cell = imageToPdfCollectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ImageConvertPdfCollectionViewCell
        
        let imageInfo = viewModel.getImageData(at: indexPath.row)
        
        
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
        
        viewModel.removeImage(at: indexPath.item)
        imageToPdfCollectionView.reloadData()
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
            print("File Name: ", fileName)
            let filePath = documentDirectory.appendingPathComponent(fileName).path
            
            do {
                try imageData.write(to: URL(fileURLWithPath: filePath))
                
                let fileAttributes = try fileManager.attributesOfItem(atPath: filePath)
                let fileSize = fileAttributes[.size] as? Int64 ?? 0
                
                let formatter = ByteCountFormatter()
                formatter.allowedUnits = [.useMB] // You can customize the units as per your requirement
                formatter.countStyle = .file
                let fileSizeString = formatter.string(fromByteCount: fileSize)
                
                
                viewModel?.addImage(image: selectedImage, fileSize: fileSizeString, imagePath: filePath)
                imageToPdfCollectionView.reloadData()
                dismiss(animated: true)
                
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
        
        
        print("iMAGES : " ,viewModel.getNumberOfImages())
        
        if viewModel.getNumberOfImages() <= 0 {
            ProgressHUD.showFailed("You haven't added the image to convert yet. :/")
        } else {
            
            if let pdfDocument = viewModel?.convertToPdf() {
                
                let filePath = ""
                pdfDocument.write(toFile: filePath)
                
                
                if (viewModel?.getNumberOfImages())! > 0 {
                    // Or present the PDF using UIActivityViewController
                    let activityViewController = UIActivityViewController(activityItems: [pdfDocument.dataRepresentation()], applicationActivities: nil)
                    present(activityViewController, animated: true, completion: nil)
                } else {
                    //display an alert that no images are selected
                }
            }
            
        }
        
        
    }
}

// MARK: ImageToPdfViewModelDelegate
extension ImageToPdfViewController: ImageToPdfViewModelDelegate {
    func reloadData() {
        imageToPdfCollectionView.reloadData()
        updateAddDocumentImageView()
    }
}
