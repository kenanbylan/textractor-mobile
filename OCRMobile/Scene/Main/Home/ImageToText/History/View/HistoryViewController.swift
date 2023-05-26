//
//  HistoryViewController.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 24.05.2023.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController , Storyboarded {
    
    static let shared = HistoryViewController()
    
    
    //MARK: UIElements
    @IBOutlet weak var historyCollectionView: UICollectionView!
    
    
    //MARK: Variable
    var nameArray = [String]()
    var languageArray = [String]()
    var idArray = [UUID]()
    
    var selectedItems: [IndexPath: Bool] = [:]
    var selectedIndexPaths = [IndexPath]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        getCoreData()
        
        
        
        navigationItem.title = "Recent Scanner"
        
        
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteSelectedCells))
        navigationItem.rightBarButtonItem = deleteButton

        
    }
    
    //Her VC açılışında açıldığında çalışır.
    override func viewWillAppear(_ animated: Bool) {
        
        //Her bu sayfa açıldığında yeni bir cell eklendi mi kontrol eder ve varsa getCoreData fonksiyonu çalışır.
        NotificationCenter.default.addObserver(self, selector: #selector(getCoreData), name: NSNotification.Name.init("newData"), object: nil)
        
    }
    
    @objc func getCoreData() {
        
        self.nameArray.removeAll(keepingCapacity: true)
        self.idArray.removeAll(keepingCapacity: true)
        
        
        //MARK: CoreData Read Operation
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Recent")
        fetchRequest.returnsObjectsAsFaults = false //büyük data verilerini için kullanılır.
        
        do {
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject] {
                
                if let language = result.value(forKey: "language") as? String { languageArray.append(language) }
                if let id = result.value(forKey: "id") as? UUID { idArray.append(id) }
                if let text = result.value(forKey: "text") as? String { nameArray.append(text) }
            }
            
            historyCollectionView.reloadData()
            
        } catch {
            print("Catch Error: ", error.localizedDescription)
        }
        
    }
    
    
    
    func registerNibs() {
        let historyNibname = HistoryCollectionViewCell.identifier
        historyCollectionView.register(UINib(nibName: historyNibname, bundle: nil), forCellWithReuseIdentifier: historyNibname)
        
    }
    
}


extension HistoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return idArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let historyIdentifier = HistoryCollectionViewCell.identifier
        let cell = historyCollectionView.dequeueReusableCell(withReuseIdentifier: historyIdentifier, for: indexPath) as! HistoryCollectionViewCell
        // cell.textLabel.text = nameArray[indexPath.row]
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
          cell.addGestureRecognizer(longPressGesture)
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let isSelected = selectedItems[indexPath] {
            selectedItems[indexPath] = !isSelected
        } else {
            selectedItems[indexPath] = true
        }
        
        guard let selectedCell = collectionView.cellForItem(at: indexPath) as? HistoryCollectionViewCell else {
            return }
        
        // Seçim durumuna göre imageView'ın görüntüsünü değiştir
        if let isSelected = selectedItems[indexPath], isSelected {
            selectedCell.checkboxImageView.image =  UIImage(named: "full-check")
            selectedCell.layer.borderColor = UIColor.blue.cgColor
        } else {
            selectedCell.checkboxImageView.image =  UIImage(named: "empty-check")
            selectedCell.layer.borderColor = UIColor.white.cgColor
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Recent")
        let idString = idArray[indexPath.item].uuidString
        fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
        fetchRequest.returnsObjectsAsFaults = false
        
        if action == #selector(deleteAction(_:)) {
            
            do {
                let results = try context.fetch(fetchRequest)
                for result in results as! [NSManagedObject] {
                    
                    if let id = result.value(forKey: "id") as? UUID {
                        context.delete(result)
                        nameArray.remove(at: indexPath.item)
                        idArray.remove(at: indexPath.item)
                        //languageArray.remove(at: indexPath.item)
                        self.historyCollectionView.reloadData()
                        
                        do {
                            try context.save()
                        } catch {
                            print("Catch Error: ", error.localizedDescription)
                        }
                    }
                }
            } catch {
                print("Catch Error: ", error.localizedDescription)
            }
        }
    }
    
    @objc func deleteAction(_ sender: Any?) {
        
        // Silme işlemini gerçekleştir
    }
    
}


extension HistoryViewController {
    

    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        guard gestureRecognizer.state == .began,
              let cell = gestureRecognizer.view as? HistoryCollectionViewCell,
              let textToCopy = cell.textLabel.text else {
            return
        }
        
        // Metni panoya kopyala
        UIPasteboard.general.string = textToCopy
        
        // Kopyalandı mesajı göster
        let alert = UIAlertController(title: "Kopyalandı", message: "Metin panoya kopyalandı.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
    
    func updateSelectionState() {
        if selectedIndexPaths.isEmpty {
            // Hiç hücre seçilmedi, silme butonunu gizle
            navigationItem.rightBarButtonItem = nil
        } else {
            // Hücreler seçildi, silme butonunu göster
            let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteSelectedCells))
            navigationItem.rightBarButtonItem = deleteButton
        }
    }
    
    
    @objc func deleteSelectedCells() {
        
        
    }
    
    
}
