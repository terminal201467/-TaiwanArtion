//
//  WelcomeRegisterViewController.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/14.
//

import UIKit


class WelcomeRegisterViewController: UIViewController {

    private let welcomeRegisterView = WelcomeRegisterView()
    
    override func loadView() {
        super.loadView()
        view = welcomeRegisterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    

}


