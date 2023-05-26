//
//  LanguageViewController.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 20.05.2023.
//

import UIKit
import PanModal

class LanguageViewController: UIViewController, Storyboarded {

    
    @IBOutlet private weak var table: UITableView!
    
    let viewModel = ImageToTextScannerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        table.registerCell(type: Tablevce)
    }
}


extension LanguageViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LanguageTableViewCell = tableView.dequeueCell(for: indexPath)
        cell.configure(title: viewModel.textLanguage[indexPath.row].language!)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}


extension LanguageViewController: PanModalPresentable {
    
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

