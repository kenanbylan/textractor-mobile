//
//  RecentViewController.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 22.05.2023.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController {
    
    static let shared = HistoryViewController()
    
    //MARK: UIElements
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: Variable
    var nameArray = [String]()
    var languageArray = [String]()
    var idArray = [UUID]()
    
    
    //Bir defa VC gözüktüğünde çalışır
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCellNibs()
        getCoreData()
        
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Recent Scanner"
        
      
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
            
            tableView.reloadData()
            
        } catch {
            print("Catch Error: ", error.localizedDescription)
        }
        
    }
    
    
    func registerCellNibs() {
        let historyNibName = RecentTableViewCell.identifier
        tableView.register(UINib(nibName: historyNibName, bundle: nil), forCellReuseIdentifier: historyNibName)
        
    }
    
    
}



extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return idArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableViewIdentifier = RecentTableViewCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewIdentifier, for: indexPath) as! RecentTableViewCell
        
        cell.resultText.text = nameArray[indexPath.row]
       // cell.languageLabel.text = languageArray[indexPath.row]
        cell.copyButton.setTitle("copy", for: .normal)
        return cell
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Recent")
        let idString = idArray[indexPath.row].uuidString
        fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
        fetchRequest.returnsObjectsAsFaults = false

        if editingStyle == .delete {
            
            do {
                let results = try context.fetch(fetchRequest)
                for result in results as! [NSManagedObject] {
                    
                    if let id = result.value(forKey: "id") as? UUID {
                        context.delete(result)
                        nameArray.remove(at: indexPath.row)
                        idArray.remove(at: indexPath.row)
                        //languageArray.remove(at: indexPath.row)
                        self.tableView.reloadData()
                        
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
    
}
