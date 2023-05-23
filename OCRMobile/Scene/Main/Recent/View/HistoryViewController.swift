//
//  RecentViewController.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 22.05.2023.
//

import UIKit

class HistoryViewController: UIViewController {
    
    static let shared = HistoryViewController()
    
    
    //MARK: UIElements
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCellNibs()
    }
    
    
    func registerCellNibs() {
        let historyNibName = RecentTableViewCell.identifier
        tableView.register(UINib(nibName: historyNibName, bundle: nil), forCellReuseIdentifier: historyNibName)
        
        
    }
    
    
}



extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableViewIdentifier = RecentTableViewCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewIdentifier, for: indexPath) as! RecentTableViewCell
        
        cell.resultText.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore"
        
        cell.languageLabel.text = "english"
        cell.copyButton.setTitle("copy", for: .normal)
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    
}
