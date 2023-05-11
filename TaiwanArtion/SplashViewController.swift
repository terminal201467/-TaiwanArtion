//
//  SplashViewController.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/11.
//

import UIKit

class SplashViewController: UIViewController {
    
    private let splashView = SplashView()
    
    //MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = splashView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
