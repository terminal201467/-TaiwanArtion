//
//  SplashViewController.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/11.
//

import UIKit
import RxSwift
import RxCocoa

class SplashViewController: UIViewController {
    
    private let splashView = SplashView()
    
    //MARK: - RxSwift Binding
    private let stepChanged = PublishSubject<Int>()
    
    //MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = splashView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
