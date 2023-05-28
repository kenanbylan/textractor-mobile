//
//  HomeViewController.swift
//  OCRMobile
//  Created by Kenan Baylan on 11.05.2023.

import UIKit
import CoreData
import PanModal
import ProgressHUD
import VisionKit


class ImagetoTextScannerViewController: UIViewController, Storyboarded {
    
    
    let viewModel = ImageToTextScannerViewModel()
    let context = AppDelegate()
    var coordinator: ImageToTextCoordinator?
    
    //MARK: UIElements
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var languageButton: AppButton!
    @IBOutlet weak var scanButton: AppButton!
    @IBOutlet weak var textView: UITextView!
    
    //MARK: Variables
    var selectedLanguage: String?
    var selectedLangCode: String?
    var selectedImage: UIImage?
    var imageUrlString: String?
    
    
    private lazy var interaction: ImageAnalysisInteraction = {
        let interaction = ImageAnalysisInteraction()
        interaction.preferredInteractionTypes = .automatic
        return interaction
    }()

    private let imageAnalyzer = ImageAnalyzer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.addInteraction(interaction)
        
//
//        //HomeViewController'a taşınacak.
//        let cameraScan = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(cameraScanVC))
//        navigationItem.rightBarButtonItem = cameraScan
//
        
        let historyTextScanButton = UIBarButtonItem(image: UIImage(named: "recent"), style: .done, target: self, action: #selector(historyButton) )
        navigationItem.rightBarButtonItem = historyTextScanButton
        
        
        tapGasture()
        customUIEdit()
            
        viewModel.getLanguage()

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
    
    
    @IBAction func languageButtonTapped(_ sender: Any) {
        
        viewModel.coordinator?.showLanguageModal()
        print("Language button tapped")
        
        
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
        
        
        guard let image = imageView.image else {
            
            ProgressHUD.show("Please select an image", icon: .privacy, delay: 2.0)
            return
        }
        
        guard let selectedLangCode = selectedLangCode else {
            ProgressHUD.show("Please select an language", icon: .privacy, delay: 2.0)
            return
        }
        
        
        Task {
                let configuration = ImageAnalyzer.Configuration([.text])

                do {
                    let analysis = try await imageAnalyzer.analyze(image, configuration: configuration)

                    DispatchQueue.main.async {
                        self.interaction.analysis = nil
                        self.interaction.preferredInteractionTypes = []

                        self.interaction.analysis = analysis
                        self.interaction.preferredInteractionTypes = .automatic
                    }

                } catch {
                    print(error.localizedDescription)
                }
            }
        
        
        
//        self.viewModel.postImagetoText(imageUrl: imageUrlString, lang: selectedLangCode) { [weak self] in
//            DispatchQueue.main.async {
//
//                self?.textView.text = self?.viewModel.textViewData
//
//
//                //MARK: CoreData Insert Operation
//                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//                let context = appDelegate.persistentContainer.viewContext
//
//                guard let entity = NSEntityDescription.entity(forEntityName: "Recent", in: context) else { return  }
//
//                let recentObject = NSManagedObject(entity: entity, insertInto: context)
//
//                recentObject.setValue(selectedLangCode, forKey: "language")
//                recentObject.setValue(UUID(), forKey: "id")
//
//
//                do {
//                    try context.save()
//                    print("Success") //will add alert
//                } catch {
//                    print("error:",error.localizedDescription)
//                }
//
//                NotificationCenter.default.post(name: NSNotification.Name.init("newData"), object: nil)
//
//            }
//        }
    }
    
}



//MARK: - device image selected.
extension ImagetoTextScannerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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




extension ImagetoTextScannerViewController {
    func handleLanguageSelection(_ language: Languages) {
        languageButton.setTitle(language.language, for: .normal)
        selectedLangCode = language.code
        selectedLanguage = language.language
    }
    
    
    
    @objc func historyButton(){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
        self.navigationController?.show(controller, sender: nil)
    }
    
}


//MARK: - for language actionsheet
extension ImagetoTextScannerViewController: PanModalPresentable {
    
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

