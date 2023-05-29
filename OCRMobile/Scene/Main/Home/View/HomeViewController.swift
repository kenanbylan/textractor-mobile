//
//  HomeViewController.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 26.05.2023.
//

import UIKit
import VisionKit

class HomeViewController: UIViewController, Storyboarded {
    
    let coordinator: HomeCoordinator? = nil
    
    //MARK: UIElements
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var imageToPdfView: ScanCardView!
    @IBOutlet weak var qrCodeView: ScanCardView!
    @IBOutlet weak var mergedPdfView: ScanCardView!
    @IBOutlet weak var imageToTextView: ScanCardView!
    

    //Popular Services
    let services = ["Image to Pdf", "Qr Code", "Merged Pdf", "Image to Text"]

    
    
    /// Checks if is supported and isAvailable'
    var scannerAvailable: Bool {
        DataScannerViewController.isSupported && DataScannerViewController.isAvailable
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGestureSetup()
        searchBar.delegate = self
    }
    
    
    func searchService(service: String) {
        
    }
    
    
    
    func tapGestureSetup() {
        let imageToPdfTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageToPdfTapped))
        let qrCodeTapGesture = UITapGestureRecognizer(target: self, action: #selector(qrCodeTapped))
        let mergedPdfTapGesture = UITapGestureRecognizer(target: self, action: #selector(mergedPdfTapped))
        let imageToTextTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageToTextTapped))
        
        //Hatalı olabilir.
        let views: [UIView] = [imageToPdfView, imageToTextView, mergedPdfView, qrCodeView]
        let gestures: [UIGestureRecognizer] = [imageToPdfTapGesture, imageToTextTapGesture, mergedPdfTapGesture,qrCodeTapGesture]
        
        
        for i in 0..<views.count {
            let view = views[i]
            let gesture = gestures[i]
            view.isUserInteractionEnabled = true
            view.addGestureRecognizer(gesture)
        }
    }
    
    
    
    
    
    
}



extension HomeViewController {
    
    @objc func imageToPdfTapped() {
        imageToPdfView.addTapAnimation()
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "ImageToPdfViewController") as! ImageToPdfViewController
        self.navigationController?.pushViewController(controller, animated: true)
        
//        coordinator?.showImageToPdfPage()
    }
    
    @objc func qrCodeTapped() {
        qrCodeView.addTapAnimation()
        
        guard scannerAvailable == true else {
            print(" Error: Scanner is not available for usage. Please check settings.")
            return
        }        
        let dataScanner = DataScannerViewController(recognizedDataTypes: [ .barcode()], isHighlightingEnabled: true)
        
        dataScanner.delegate = self
        
        present(dataScanner, animated: true ) {
            try? dataScanner.startScanning()
        }
        
        
    }
    
    @objc func mergedPdfTapped() {
        mergedPdfView.addTapAnimation()
    }
    
    @objc func imageToTextTapped() {
        imageToTextView.addTapAnimation()
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "ImagetoTextScannerViewController") as! ImagetoTextScannerViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}



extension HomeViewController: DataScannerViewControllerDelegate {
    
    func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
        
        switch item {
        case .barcode(let code):
            guard let urlString = code.payloadStringValue else { return }
            guard let url = URL(string: urlString) else { return }
            UIApplication.shared.open(url)
            
       
        @unknown default:
            print(" Error: Scanner is not available for usage. Please check settings.")
        }
    }
}


extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
}
