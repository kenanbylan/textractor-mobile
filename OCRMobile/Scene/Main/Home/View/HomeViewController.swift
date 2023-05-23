//
//  HomeViewController.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 11.05.2023.
//

import UIKit
import CoreData
import PanModal
import ProgressHUD


class HomeViewController: UIViewController {
    
    
    let viewModel = HomeViewModel()
    let context = AppDelegate()
    
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
        
        guard let imageUrlString = imageUrlString else {
            ProgressHUD.show("Please select an image", icon: .privacy, delay: 2.0)
            return
        }
        
        guard let selectedLangCode = selectedLangCode else {
            ProgressHUD.show("Please select an language", icon: .privacy, delay: 2.0)
            return
        }
        
        guard let selectedType = selectedType else {
            ProgressHUD.show("Please select an Type", icon: .privacy, delay: 2.0)
            return
        }
        
        self.viewModel.postImagetoText(imageUrl: imageUrlString, lang: selectedLangCode) { [weak self] in
            DispatchQueue.main.async {
                self?.textView.text = self?.viewModel.textViewData
                
                
                
                //MARK: CoreData Insert Operation
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                let context = appDelegate.persistentContainer.viewContext
                
                guard let entity = NSEntityDescription.entity(forEntityName: "Recent", in: context) else { return  }

                let recentObject = NSManagedObject(entity: entity, insertInto: context)
                
                recentObject.setValue(self!.viewModel.textViewData, forKey: "text")
                recentObject.setValue(selectedLangCode, forKey: "language")
                recentObject.setValue(UUID(), forKey: "id")
                
                do {
                    try context.save()
                    print("Success") //will add alert
                } catch {
                    print("error:",error.localizedDescription)
                }
                
                NotificationCenter.default.post(name: NSNotification.Name.init("newData"), object: nil)
            
            }
        }
    }
    
}


extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectImage = info[.originalImage] as? UIImage else { return }
        self.imageView.image = selectImage
        
        
        selectedImage = selectImage //Photo is assigned to the variable.
        
        guard let imageData = selectImage.pngData() else { return }
        let base64String = imageData.base64EncodedString(options: [])

        
        
        imageUrlString = "data:image/png;base64,\(base64String)"
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
        selectedLanguage = language.language
        
    }
    
}


extension HomeViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(312)
    }
    
    var cornerRadius: CGFloat {
        16
    }
}

