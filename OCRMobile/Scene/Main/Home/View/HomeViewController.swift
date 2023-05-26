//
//  HomeViewController.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 26.05.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    let coordinator: HomeCoordinator? = nil
    
    //MARK: UIElements
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var imageToPdfView: ScanCardView!
    @IBOutlet weak var qrCodeView: ScanCardView!
    @IBOutlet weak var mergedPdfView: ScanCardView!
    @IBOutlet weak var imageToTextView: ScanCardView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tapGestureSetup()
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
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "ImagetoTextScannerViewController") as! ImagetoTextScannerViewController
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    @objc func qrCodeTapped() {
        qrCodeView.addTapAnimation()
        
    }
    
    @objc func mergedPdfTapped() {
        mergedPdfView.addTapAnimation()
    }
    
    @objc func imageToTextTapped() {
        imageToTextView.addTapAnimation()
    }
    
}
