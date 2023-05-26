//
//  Storyboarded.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 11.05.2023.
//

import Foundation


import UIKit


//MARK: Storyboard
enum StoryboardName: String {
    case main = "Main"
    case authentication = "Auth"

}


protocol Storyboarded {
    static func instantiate(name: StoryboardName) -> Self
}



extension Storyboarded where Self: UIViewController {
    
    static func instantiate(name: StoryboardName) -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: name.rawValue, bundle: Bundle.main)
        
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
