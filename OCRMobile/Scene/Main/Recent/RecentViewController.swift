//
//  RecentViewController.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 22.05.2023.
//

import UIKit
import Lottie

class RecentViewController: UIViewController {

    @IBOutlet weak var lottieView: LottieAnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        lottieView.contentMode = .scaleAspectFit
        lottieView.loopMode = .loop
        
        lottieView.play()
    }
  

}
