//
//  LanguageViewController.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 20.05.2023.


import UIKit
import PanModal

class LanguageViewController: UIViewController, Storyboarded {
    
    static let identifier = String(describing: LoadingViewController.self)

    @IBOutlet private weak var table: UITableView!
    
    let viewModel = ImageToTextScannerViewModel()
    
    var selectionCallback: ((Languages)->())?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.registerCell(type: LanguageTableViewCell.self)
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
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true) { [weak self] in
            self?.selectionCallback?((self?.viewModel.textLanguage[indexPath.row])!)

        }
        
        
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

