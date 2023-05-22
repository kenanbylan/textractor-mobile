//
//  HomeViewController.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 11.05.2023.
//

import UIKit

class HomeViewController: UIViewController  {
    
    
    let viewModel = HomeViewModel()
    
    //MARK: UIElements
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var typeButton: AppButton!
    @IBOutlet weak var languageButton: AppButton!
    @IBOutlet weak var scanButton: AppButton!
    @IBOutlet weak var textView: UITextView!
    
    //MARK: Variables
    var selectedLanguage: String?
    var selectedLangCode: String?
    var selectedType: String?
    var selectedImage: UIImage?
    
    var imageUrlString: String?
    
    
    //MARK: Const Data
    var typeArray = ["Image to Text", "Image to Pdf","Pdf to Text"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigationBar = UINavigationBarAppearance()
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)]
        navigationController?.navigationBar.standardAppearance = navigationBar
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBar
        
        
        //MARK: GET Request
        viewModel.getLanguage() //sayfa açıldığında otomatik olarak istek atılır ve datalar çekilir.
        tapGasture()
        customUIEdit()
        
        
        
    }
    
    
    func tapGasture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
    }
    
    
    func customUIEdit() {
        textView.layer.borderWidth = 2
        textView.layer.borderColor = UIColor(named: "text-color")?.cgColor
        textView.layer.cornerRadius = 12
    }
    
    
    @objc func imageViewTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
        
    }
    
    
    @IBAction func typeButtonTapped(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Choose Type", message: nil, preferredStyle: .actionSheet)
        for types in typeArray {
            let action =  UIAlertAction(title: types, style: .default) { _ in
                self.selectedType = types
                self.typeButton.setTitle(types, for: .normal)
            }
            alertController.addAction(action)
        }
        
        present(alertController, animated: true)
        
    }
    
    @IBAction func languageButtonTapped(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Choose Language", message: nil, preferredStyle: .actionSheet)
        
        for lang in viewModel.textLanguage  {
            let action = UIAlertAction(title: lang.language, style: .default) { _ in
                self.handleLanguageSelection(lang)
            }
            alertController.addAction(action)
        }
        
        present(alertController, animated: true)
        print("languageButtonTapped")
    }
    
    
    @IBAction func scanButtonTapped(_ sender: Any) {
       
        guard let selectedType = selectedType,
                 let selectedImage = selectedImage,
                 let selectedLanguage = selectedLanguage
                else { return }
        
    }
    
}


extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectImage = info[.originalImage] as? UIImage else { return }
        
        self.imageView.image = selectImage
        selectedImage = selectImage //Photo is assigned to the variable.
        
        guard let imageData = selectImage.pngData() else { return  }
        
        let base64String = imageData.base64EncodedString(options: [])

        print("base64Image : ", base64String)
        self.imageUrlString = "data:image/png;base64,\(base64String)"
        
        print("imageUrlString:",imageUrlString)
        
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}


extension HomeViewController {
    
    func handleLanguageSelection(_ language: Languages) {
        
        languageButton.setTitle(language.language, for: .normal)
        selectedLangCode = language.code
        
    }
    
}
