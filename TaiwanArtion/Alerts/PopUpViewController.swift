//
//  PopUpViewController.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/13.
//

import UIKit

class PopUpViewController: UIViewController {

    var popUpView: UIView?
    
    init(popUpView: UIView) {
        super.init(nibName: nil, bundle: nil)
        self.popUpView = popUpView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = popUpView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
